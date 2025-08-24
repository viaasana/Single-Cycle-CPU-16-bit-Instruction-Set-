module tb_Sing_Circle_CPU;

    reg clk;
    reg reset_n;
    reg clear_code;
    reg getcode;
    reg signed [7:0] data_in;
    reg [15:0] instruction_in;
    wire signed [7:0] data_out;

    Single_Circle_CPU cpu (
        .clk(clk),
        .reset_n(reset_n),
        .clear_code(clear_code),
        .getcode(getcode),
        .data_in(data_in),
        .instruction_in(instruction_in),
        .data_out(data_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period of 10 time units
    end

    initial begin
        // Initialize inputs
        reset_n = 0;
        clear_code = 0;
        getcode = 0;
        data_in = 8'b0;
        instruction_in = 16'b0;


        // Clear code memory
        #10;
        clear_code = 1;
        #10;
        clear_code = 0;
        #10;
        
        // Load instructions
        getcode = 1;
        // === Input / Output ===
        instruction_in = 16'b1000000000000000; #10; // LINP -> R0
        instruction_in = 16'b1000010000000000; #10; // LINP -> R1
        instruction_in = 16'b1010000000000000; #10; // WOUT R0
        instruction_in = 16'b1010010000000000; #10; // WOUT R1

        // === Arithmetic & Logic (RR format) ===
        instruction_in = 16'b0000000010100000; #10; // ADD  R0,R1 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010100001; #10; // INC  R0    -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010100010; #10; // SUB  R0,R1 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010100011; #10; // DEC  R0    -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010100100; #10; // AND  R0,R1 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010100101; #10; // OR   R0,R1 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010100110; #10; // XOR  R0,R1 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010100111; #10; // NAND R0,R1 -> R2
        instruction_in = 16'b1010100000100000; #10; // WOUT R2

        // === Shift Ops ===
        instruction_in = 16'b0000000010101000; #10; // SHL1 R0 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010101001; #10; // SHL2 R0 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010101010; #10; // SHL3 R0 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010101011; #10; // SHL4 R0 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010101100; #10; // SHR1 R0 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010101101; #10; // SHR2 R0 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010101110; #10; // SHR3 R0 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2
        instruction_in = 16'b0000000010101111; #10; // SHR4 R0 -> R2
        instruction_in = 16'b1010100000000000; #10; // WOUT R2

        // === Jump Instructions (RRI format) ===
        //instruction_in = 16'b0100000000000100; #10; // JUM  (if R0==R0) jump imm=4
        instruction_in = 16'b0110000000000000; #10; // JAL  (jump to @r0)
        getcode = 0;
        #10;
        reset_n = 1;
        #10;
        data_in = 8'd15; // Input value for R0
        #10;
        data_in = 8'd10; // Input value for R1
        #10;
        #10;
        #10;
        #10;
        $display("Add R0, R1: Output: %d", data_out);
        #20;
        $display("INC R0: Output: %d", data_out);
        #20;
        $display("SUB R0, R1: Output: %d", data_out);
        #20;
        $display("DEC R0: Output: %d", data_out);
        #20;
        $display("AND R0, R1: Output: %d", data_out);
        #20;
        $display("OR R0, R1: Output: %d", data_out);
        #20;
        $display("XOR R0, R1: Output: %d", data_out);
        #20;
        $display("NAND R0, R1: Output: %d", data_out);
        #20;
        $display("SHIFT LEFT R0 1 BIT: Output: %d", data_out);
        #20;
        $display("SHIFT LEFT R0 2 BITS: Output: %d", data_out);
        #20;
        $display("SHIFT LEFT R0 3 BITS: Output: %d", data_out);
        #20;
        $display("SHIFT LEFT R0 4 BITS: Output: %d", data_out);
        #20;
        $display("SHIFT RIGHT R0 1 BIT: Output: %d", data_out);
        #20;
        $display("SHIFT RIGHT R0 2 BITS: Output: %d", data_out);
        #20;
        $display("SHIFT RIGHT R0 3 BITS: Output: %d", data_out);
        #20;
        $display("SHIFT RIGHT R0 4 BITS: Output: %d", data_out);
        #100; // Wait for some time to let the CPU process instructions


    end
endmodule