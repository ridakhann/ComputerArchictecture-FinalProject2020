module Instruction_memory(
input [63:0] Instruction_address,
output reg[31:0] Instruction
 );
reg [7:0] memory [63:0];
initial begin
  //0x01600bb3	add x23 x0 x22
  memory[0] <= 8'b10110011;
  memory[1] <= 8'b00001011;
  memory[2] <= 8'b01100000;
  memory[3] <= 8'b00000001;
  //0x00a10633	add x12 x2 x10
  memory[4] <= 8'b00110011;
  memory[5] <= 8'b00000110;
  memory[6] <= 8'b10100001;
  memory[7] <= 8'b00000000; 
  //0x00062783	ld x15 0(x12)
  memory[8] <= 8'b10000011;
  memory[9] <= 8'b00110111;
  memory[10] <= 8'b00000110;
  memory[11] <= 8'b00000000;
  //0x002b9193	addi x3, x23, 8
  memory[12] <= 8'b10010011;
  memory[13] <= 8'b10000001;
  memory[14] <= 8'b10001011;
  memory[15] <= 8'b00000000;
  //0x00a186b3	add x13 x3 x10
  memory[16] <= 8'b10110011;
  memory[17] <= 8'b10000110;
  memory[18] <= 8'b10100001;
  memory[19] <= 8'b00000000;
  //0x0006a803	ld x16 0(x13)
  memory[20] <= 8'b00000011;
  memory[21] <= 8'b10111000;
  memory[22] <= 8'b00000110;
  memory[23] <= 8'b00000000;
  //0x0107c463	bgt x16, x15, 8
  memory[24] <= 8'b01100011;
  memory[25] <= 8'b01000100;
  memory[26] <= 8'b11111000;
  memory[27] <= 8'b00000001;
  //0x00000863	beq x0 x0 16
  memory[28] <= 8'b01100011;
  memory[29] <= 8'b00001000;
  memory[30] <= 8'b00000000;
  memory[31] <= 8'b00000000;
  //0x00f002b3	add x5 x0 x15
  memory[32] <= 8'b10110011;
  memory[33] <= 8'b00000010;
  memory[34] <= 8'b11110000;
  memory[35] <= 8'b00000000;
  //0x01062023	sd x16 0(x12)
  memory[36] <= 8'b00100011;
  memory[37] <= 8'b00110000;
  memory[38] <= 8'b00000110;
  memory[39] <= 8'b00000001;
  //0x0056a023	sd x5 0(x13)
  memory[40] <= 8'b00100011;
  memory[41] <= 8'b10110000;
  memory[42] <= 8'b01010110;
  memory[43] <= 8'b00000000;
  //0x001b8b93	addi x23 x23 1
 memory[44] <= 8'b10010011;
  memory[45] <= 8'b10001011;
  memory[46] <= 8'b00011011;
  memory[47] <= 8'b00000000;
  //0xfcbb9ae3	bne x23 x11 -44
  memory[48] <= 8'b11100011;
  memory[49] <= 8'b10011010;
  memory[50] <= 8'b10111011;
  memory[51] <= 8'b11111100;
  //0x001b0b13	addi x22 x22 1
  memory[52] <= 8'b00010011;
  memory[53] <= 8'b00001011;
  memory[54] <= 8'b00011011;
  memory[55] <= 8'b00000000;
  //0x00410113	addi x2 x2 4
  memory[56] <= 8'b00010011;
  memory[57] <= 8'b00000001;
  memory[58] <= 8'b01000001;
  memory[59] <= 8'b00000000;
  //0xfcbb12e3	bne x22 x11 -60
  memory[60] <= 8'b11100011;
  memory[61] <= 8'b00010010;
  memory[62] <= 8'b10111011;
  memory[63] <= 8'b11111100;


end


always @(*)
	begin
		Instruction = {memory[Instruction_address[3:0] + 3], memory[Instruction_address[3:0] + 2], memory[Instruction_address[3:0] + 1], memory[Instruction_address[3:0]]};
	end
endmodule
