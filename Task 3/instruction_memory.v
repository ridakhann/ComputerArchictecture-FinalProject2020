module Instruction_memory(
input [63:0] Instruction_address,
output reg[31:0] Instruction
 );
reg [7:0] memory [15:0];
integer seed, i,j;
initial begin
	
	memory[0] = 8'b10000011;
  memory[1] = 8'b00110100;
  memory[2] = 8'b10000101;
  memory[3] = 8'b00000010;
  memory[4] = 8'b10110011;
  memory[5] = 8'b10000100;
  memory[6] = 8'b10011010;
  memory[7] = 8'b00000000;
  memory[8] = 8'b10010011;
  memory[9] = 8'b10000100;
  memory[10] = 8'b00010100;
  memory[11] = 8'b00000000;
  memory[12] = 8'b00100011;
  memory[13] = 8'b00110100;
  memory[14] = 8'b10010101;
  memory[15] = 8'b00000010;
  

end


always @(Instruction_address)
begin
	Instruction[7:0] = memory[Instruction_address];
	Instruction[15: 8] = memory[Instruction_address +1];
	Instruction[23:16] = memory[Instruction_address+2];
	Instruction[31:24] = memory[Instruction_address+3];
end




endmodule
