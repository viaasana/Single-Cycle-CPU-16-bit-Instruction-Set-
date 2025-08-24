

module control_unit (
    input wire [15:0] instruction,
    output wire [3:0] alu_opcode,
    output wire [2:0] seltect_alu_inputA,
    output wire [2:0] seltect_alu_inputB,
    output wire wr_back,
    output wire [2:0] seltect_wr_back,
    output wire input_en,
    output wire output_en,
    output wire [2:0] select_output_reg,
    output [7:0] immediate,
    output jump_immediate,
    output wire [7:0] jump_address,
    output wire jump_link,
    output wire [2:0] jump_link_reg
);

    assign alu_opcode = (instruction[14] & ~instruction[13])?4'b0010:instruction[3:0];
    assign seltect_alu_inputA = instruction[12:10];
    assign seltect_alu_inputB = instruction[9:7];
    assign seltect_wr_back = instruction[15] ? instruction[12:10] : instruction[6:4];
    assign wr_back = ~instruction[15] & ~instruction[14];

    assign input_en = instruction[15] & ~instruction[13];
    assign output_en = instruction[15] & instruction[13];
    assign select_output_reg = instruction[12:10];

    assign immediate = instruction[6:0];

    assign jump_immediate = instruction[14] & ~instruction[13];
    assign jump_address = instruction[6:0];

    assign jump_link = ~instruction[15]&instruction[14] & instruction[13];
    assign jump_link_reg = instruction[12:10];

endmodule