`timescale 1ns/1ps

module tb_ALU();

    parameter WIDTH = 8;

    // DUT inputs
    reg [3:0] opcode;
    reg signed [WIDTH-1:0] op1, op2;

    // DUT outputs
    wire signed [WIDTH-1:0] result;
    wire equals_zero;
    wire overflow;

    // Instantiate DUT
    ALU #(.WIDTH(WIDTH)) uut (
        .opcode(opcode),
        .op1(op1),
        .op2(op2),
        .result(result),
        .equals_zero(equals_zero),
        .overflow(overflow)
    );

    // Task to print results
    task show_result;
        begin
            $display("time=%0t | opcode=%b | op1=%0d | op2=%0d | result=%0d | zero=%b | ovf=%b",
                     $time, opcode, op1, op2, result, equals_zero, overflow);
        end
    endtask

    initial begin
        $display("=== ALU TEST START ===");

        // ADD
        opcode = 4'b0000; op1 = 10; op2 = 20; #5; show_result();
        opcode = 4'b0000; op1 = 100; op2 = 100; #5; show_result(); // overflow expected

        // ADD 1
        opcode = 4'b0001; op1 = 127; op2 = 0; #5; show_result(); // overflow expected
        opcode = 4'b0001; op1 = -1; op2 = 0; #5; show_result();

        // SUB
        opcode = 4'b0010; op1 = 50; op2 = 20; #5; show_result();
        opcode = 4'b0010; op1 = -128; op2 = 1; #5; show_result(); // overflow expected

        // SUB 1
        opcode = 4'b0011; op1 = -128; op2 = 0; #5; show_result(); // overflow expected
        opcode = 4'b0011; op1 = 5; op2 = 0; #5; show_result();

        // AND
        opcode = 4'b0100; op1 = 8'b10101010; op2 = 8'b11001100; #5; show_result();

        // OR
        opcode = 4'b0101; op1 = 8'b10101010; op2 = 8'b11001100; #5; show_result();

        // XOR
        opcode = 4'b0110; op1 = 8'b10101010; op2 = 8'b11001100; #5; show_result();

        // NAND
        opcode = 4'b0111; op1 = 8'b11110000; op2 = 8'b11001100; #5; show_result();

        // shift left 1 bit
        opcode = 4'b1000; op1 = 10; op2 = 20; #5; show_result();
        opcode = 4'b1000; op1 = 100; op2 = 100; #5; show_result(); 

        // shift left 2 bits
        opcode = 4'b1001; op1 = 127; op2 = 0; #5; show_result(); 
        opcode = 4'b0001; op1 = -1; op2 = 0; #5; show_result();

        // shift left 3 bits
        opcode = 4'b1010; op1 = 50; op2 = 20; #5; show_result();
        opcode = 4'b1010; op1 = -128; op2 = 1; #5; show_result(); 

        // shift left 4 bits
        opcode = 4'b1011; op1 = -128; op2 = 0; #5; show_result(); 
        opcode = 4'b1011; op1 = 5; op2 = 0; #5; show_result();

        // sift right 1 bit
        opcode = 4'b1100; op1 = 8'b10101010; op2 = 8'b11001100; #5; show_result();

        // sift right 2 bits
        opcode = 4'b1101; op1 = 8'b10101010; op2 = 8'b11001100; #5; show_result();

        // sift right 3 bits
        opcode = 4'b1110; op1 = 8'b10101010; op2 = 8'b11001100; #5; show_result();

        // sift right 4 bits
        opcode = 4'b1111; op1 = 8'b11110000; op2 = 8'b11001100; #5; show_result();

        $display("=== ALU TEST END ===");
    end

endmodule
