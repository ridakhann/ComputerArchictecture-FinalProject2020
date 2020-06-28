// module Instruction_memory(
// input [63:0] Instruction_address,
// output reg[31:0] Instruction
//  );
// reg [7:0] memory [63:0];
// initial begin
//   //0x01600bb3	add x23 x0 x22
//   memory[0] <= 8'b10110011;
//   memory[1] <= 8'b00001011;
//   memory[2] <= 8'b01100000;
//   memory[3] <= 8'b00000001;
//   //0x00a10633	add x12 x2 x10
//   memory[4] <= 8'b00110011;
//   memory[5] <= 8'b00000110;
//   memory[6] <= 8'b10100001;
//   memory[7] <= 8'b00000000; 
//   //0x00062783	ld x15 0(x12)
//   memory[8] <= 8'b10000011;
//   memory[9] <= 8'b00110111;
//   memory[10] <= 8'b00000110;
//   memory[11] <= 8'b00000000;
//   //0x002b9193	addi x3, x23, 8
//   memory[12] <= 8'b10010011;
//   memory[13] <= 8'b10000001;
//   memory[14] <= 8'b10001011;
//   memory[15] <= 8'b00000000;
//   //0x00a186b3	add x13 x3 x10
//   memory[16] <= 8'b10110011;
//   memory[17] <= 8'b10000110;
//   memory[18] <= 8'b10100001;
//   memory[19] <= 8'b00000000;
//   //0x0006a803	ld x16 0(x13)
//   memory[20] <= 8'b00000011;
//   memory[21] <= 8'b10111000;
//   memory[22] <= 8'b00000110;
//   memory[23] <= 8'b00000000;
//   //0x0107c463	bgt x16, x15, 8
//   memory[24] <= 8'b01100011;
//   memory[25] <= 8'b01000100;
//   memory[26] <= 8'b11111000;
//   memory[27] <= 8'b00000001;
//   //0x00000863	beq x0 x0 16
//   memory[28] <= 8'b01100011;
//   memory[29] <= 8'b00001000;
//   memory[30] <= 8'b00000000;
//   memory[31] <= 8'b00000000;
//   //0x00f002b3	add x5 x0 x15
//   memory[32] <= 8'b10110011;
//   memory[33] <= 8'b00000010;
//   memory[34] <= 8'b11110000;
//   memory[35] <= 8'b00000000;
//   //0x01062023	sd x16 0(x12)
//   memory[36] <= 8'b00100011;
//   memory[37] <= 8'b00110000;
//   memory[38] <= 8'b00000110;
//   memory[39] <= 8'b00000001;
//   //0x0056a023	sd x5 0(x13)
//   memory[40] <= 8'b00100011;
//   memory[41] <= 8'b10110000;
//   memory[42] <= 8'b01010110;
//   memory[43] <= 8'b00000000;
//   //0x001b8b93	addi x23 x23 1
//  memory[44] <= 8'b10010011;
//   memory[45] <= 8'b10001011;
//   memory[46] <= 8'b00011011;
//   memory[47] <= 8'b00000000;
//   //0xfcbb9ae3	bne x23 x11 -44
//   memory[48] <= 8'b11100011;
//   memory[49] <= 8'b10011010;
//   memory[50] <= 8'b10111011;
//   memory[51] <= 8'b11111100;
//   //0x001b0b13	addi x22 x22 1
//   memory[52] <= 8'b00010011;
//   memory[53] <= 8'b00001011;
//   memory[54] <= 8'b00011011;
//   memory[55] <= 8'b00000000;
//   //0x00410113	addi x2 x2 4
//   memory[56] <= 8'b00010011;
//   memory[57] <= 8'b00000001;
//   memory[58] <= 8'b01000001;
//   memory[59] <= 8'b00000000;
//   //0xfcbb12e3	bne x22 x11 -60
//   memory[60] <= 8'b11100011;
//   memory[61] <= 8'b00010010;
//   memory[62] <= 8'b10111011;
//   memory[63] <= 8'b11111100;


// end


// always @(*)
// 	begin
// 		// ORIGINAL 
// 		//Instruction = {inst_memory[Inst_Address + 3], inst_memory[Inst_Address + 2], inst_memory[Inst_Address + 1], inst_memory[Inst_Address]};
// 		// MODIFICATION to wrap
// 		Instruction = {memory[Instruction_address[3:0] + 3], memory[Instruction_address[3:0] + 2], memory[Instruction_address[3:0] + 1], memory[Instruction_address[3:0]]};
// 		// Finally
// 		//Instruction = {inst_memory[Inst_Address + 0], inst_memory[Inst_Address + 1], inst_memory[Inst_Address + 2], inst_memory[Inst_Address + 3]};
// 	end
// endmodule
module Instruction_memory
(
    input [63:0]Instruction_address,
    output [31:0]Instruction
);


// reg [7:0] inst_mem [7:0];
// initial {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h016bd463;
// initial {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00d00733;
// initial {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00508093;
// initial {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h00608093;


reg [7:0]inst_mem[79:0];

initial {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h20000513;

initial {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00400593; // done

initial {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h04b68463; // done
initial {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h00d00733; // done
initial {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'h01400ab3;
initial {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h02b70863;
initial {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h00aa0c33;
initial {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h00aa8cb3;

initial {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h000C3b03; // ld
initial {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h000CBB83; // ld

initial {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h008a8a93;
initial {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h00170713;
initial {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'hff6bd2e3;
initial {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h016007b3;

initial {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h017c3023; // sd
initial {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h00FCB023; // sd

initial {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'hfc000ae3;
initial {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'h008a0a13;
initial {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'h00168693;
initial {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'hfa000ee3;

assign Instruction = {inst_mem[Instruction_address + 3], inst_mem[Instruction_address + 2], inst_mem[Instruction_address + 1], inst_mem[Instruction_address]};

endmodule // Instruction_Memory
