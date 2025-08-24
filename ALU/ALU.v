// 0000: add
// 0001: add 1
// 0010: sub
// 0011: sub 1
// 0100: and
// 0101: or
// 0110: xor
// 0111: nand
// 1000: shift left 1 bit
// 1001: shift left 2 bits
// 1010: shift left 3 bits
// 1011: shift left 4 bits
// 1100: shift right 1 bit
// 1101: shift right 2 bits
// 1110: shift right 3 bits
// 1111: shift right 4 bits
module ALU #(
    parameter WIDTH = 8
)(
    input [3:0] opcode,
    input signed [WIDTH-1:0] op1,
    input signed [WIDTH-1:0] op2,
    output wire signed [WIDTH-1:0] result,
    output wire equals_zero,
    output wire overflow
);
    // define wire
    wire [WIDTH-1:0] AU_result;
    wire AU_overflow;

    wire [WIDTH-1:0] add_result;
    wire [WIDTH-1:0] sub_result;
    wire [WIDTH-1:0] add1_result;
    wire [WIDTH-1:0] sub1_result;

    wire LU_result;

    wire [WIDTH-1:0] and_result;
    wire [WIDTH-1:0] or_result;
    wire [WIDTH-1:0] xor_result;
    wire [WIDTH-1:0] nand_result;

    wire [WIDTH-1:0] shift_left1_result;
    wire [WIDTH-1:0] shift_left2_result;
    wire [WIDTH-1:0] shift_left3_result;
    wire [WIDTH-1:0] shift_left4_result;

    wire [WIDTH-1:0] shift_right1_result;
    wire [WIDTH-1:0] shift_right2_result;
    wire [WIDTH-1:0] shift_right3_result;
    wire [WIDTH-1:0] shift_right4_result;




    wire sign_op1 = op1[WIDTH-1];
    wire sign_op2 = op2[WIDTH-1];
    wire sign_result;


    // assign result

    assign add_result = op1 + op2;
    assign sub_result = op1 - op2;
    assign add1_result = op1 + 1;
    assign sub1_result = op1 - 1;

    assign and_result = op1 & op2;
    assign or_result = op1 | op2;
    assign xor_result = op1 ^ op2;
    assign nand_result = ~(op1 & op2);

    assign shift_left1_result = op1 << 1;
    assign shift_left2_result = op1 << 2; 
    assign shift_left3_result = op1 << 3;
    assign shift_left4_result = op1 << 4;

    assign shift_right1_result = op1 >> 1;
    assign shift_right2_result = op1 >> 2;
    assign shift_right3_result = op1 >> 3;
    assign shift_right4_result = op1 >> 4;



    // assign result based on opcode
    assign result = (opcode == 4'b0000) ? add_result :
                   (opcode == 4'b0001) ? add1_result :
                   (opcode == 4'b0010) ? sub_result :
                   (opcode == 4'b0011) ? sub1_result :
                   (opcode == 4'b0100) ? and_result :
                   (opcode == 4'b0101) ? or_result :
                   (opcode == 4'b0110) ? xor_result :
                   (opcode == 4'b0111) ? nand_result :
                   (opcode == 4'b1000) ? shift_left1_result :
                   (opcode == 4'b1001) ? shift_left2_result :
                   (opcode == 4'b1010) ? shift_left3_result :
                   (opcode == 4'b1011) ? shift_left4_result :
                   (opcode == 4'b1100) ? shift_right1_result :
                   (opcode == 4'b1101) ? shift_right2_result :
                   (opcode == 4'b1110) ? shift_right3_result :
                   (opcode == 4'b1111) ? shift_right4_result : {WIDTH{1'bz}};
    
    assign sign_result = result[WIDTH-1];

    // check if equals zero
    assign equals_zero = (result == {WIDTH{1'b0}});
    // check for overflow
    assign overflow = (opcode[2] | opcode[3])? 0:
                        ((opcode == 3'b000) && (~sign_op1 & ~sign_op2 & sign_result | sign_op1 & sign_op2 & ~sign_result)) ||
                        ((opcode == 3'b001) && (~sign_op1 & sign_result)) ||
                        ((opcode == 3'b010) && (~sign_op1 & ~ sign_op2 & sign_result | sign_op1 & ~sign_op2 & ~sign_result)) ||
                        ((opcode == 3'b011) && (sign_op1 & ~sign_result));






endmodule