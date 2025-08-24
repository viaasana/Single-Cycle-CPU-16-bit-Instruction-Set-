
module Single_Circle_CPU(
    input clk,
    input reset_n,
    input clear_code,
    input getcode,
    input [7:0] data_in,
    input [15:0] instruction_in,
    output [7:0] data_out
);

    reg [15:0] instruction_memory [0:255];
    reg [7:0] PC;
    reg [7:0] LoadPC = 0;

    reg [7:0] register_file [0:7];


    wire [15:0] instruction_w = instruction_memory[PC];
    wire [3:0] alu_opcode;
    wire [2:0] seltect_alu_inputA;
    wire [2:0] seltect_alu_inputB;
    wire wr_back;
    wire [2:0] seltect_wr_back;
    wire input_en;
    wire output_en;
    wire [2:0] select_output_reg;
    wire [7:0] immediate;
    wire jump_immediate;
    wire [7:0] jump_address;
    wire jump_link;
    wire [2:0] jump_link_reg;

    wire equals_zero;
    wire overflow;
    wire [7:0] alu_result;

    control_unit CU (
        .instruction(instruction_w),
        .alu_opcode(alu_opcode),
        .seltect_alu_inputA(seltect_alu_inputA),
        .seltect_alu_inputB(seltect_alu_inputB),
        .wr_back(wr_back),
        .seltect_wr_back(seltect_wr_back),
        .input_en(input_en),
        .output_en(output_en),
        .select_output_reg(select_output_reg),
        .immediate(immediate),
        .jump_immediate(jump_immediate),
        .jump_address(jump_address),
        .jump_link(jump_link),
        .jump_link_reg(jump_link_reg)
    );

    ALU ALU(
        .opcode(alu_opcode),
        .op1(register_file[seltect_alu_inputA]),
        .op2(register_file[seltect_alu_inputB]),
        .result(alu_result),
        .equals_zero(equals_zero),
        .overflow(overflow)
    );


    // code installation
    always @(posedge clk or clear_code) begin
        if(clear_code) begin
            LoadPC <= 8'b0;
        end
    end


    always @(posedge clk or posedge getcode) begin
        if(getcode) begin
            instruction_memory[LoadPC] <= instruction_in;
            LoadPC <= LoadPC + 1;
        end
    end

    // run CPU
    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 0) begin
            PC <= 8'b0;
        end else if(!getcode) begin
            if(input_en) begin
                register_file[seltect_wr_back] <= data_in;
            end
            
            if(wr_back) begin
                register_file[seltect_wr_back] <= alu_result;
            end

            if(jump_immediate && equals_zero) begin
                PC <= jump_address;
            end
            else if(jump_link) begin
                PC <= register_file[jump_link_reg];
            end else if(PC + 1 < LoadPC)
                PC <= PC +1;


        end
    end

    assign data_out = output_en ? register_file[select_output_reg] : 8'bz;


endmodule