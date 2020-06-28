module ALU_6_bit(
input [5:0] A, B,
input C, //C=carry in
input [3:0]D1,
output [5:0]result,
output carryout
);
wire carry1, carry2, carry3, carry4, carry5;
ALU_1_bit tasbiha1(.result(result[0]), .carryout(carry1), .a(A[0]), .b(B[0]), .carryin(C), .ALUop(D1));
ALU_1_bit tasbiha2(.result(result[1]), .carryout(carry2), .a(A[1]), .b(B[1]), .carryin(carry1), .ALUop(D1));
ALU_1_bit tasbiha3(.result(result[2]), .carryout(carry3), .a(A[2]), .b(B[2]), .carryin(carry2), .ALUop(D1));
ALU_1_bit tasbiha4(.result(result[3]), .carryout(carry4), .a(A[3]), .b(B[3]), .carryin(carry3), .ALUop(D1));
ALU_1_bit tasbiha5(.result(result[4]), .carryout(carry5), .a(A[4]), .b(B[4]), .carryin(carry4), .ALUop(D1));
ALU_1_bit tasbiha6(.result(result[5]), .carryout(carryout), .a(A[5]), .b(B[5]), .carryin(carry5), .ALUop(D1));
Endmodule