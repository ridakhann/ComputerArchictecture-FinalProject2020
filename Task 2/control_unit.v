module control_unit(
input [6:0] opcode,
output reg ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch,
output reg [1:0] ALUop
);
always @(*)
begin
case (opcode)
7'b0110011:
begin
ALUSrc = 1'b0;
MemToReg = 1'b0;
RegWrite = 1'b1;
MemRead = 1'b0;
MemWrite = 1'b0;
Branch = 1'b0;
ALUop = 2'b10;
end
7'b0000011:
begin
ALUSrc = 1'b1;
MemToReg = 1'b1;
RegWrite= 1'b1;
MemRead = 1'b1;
MemWrite = 1'b0;
Branch = 1'b0;
ALUop = 2'b00;
end
7'b0100011:
begin
ALUSrc = 1'b1;
MemToReg = 1'bx;
RegWrite= 1'b0;
MemRead = 1'b0;
MemWrite = 1'b1;
Branch = 1'b0;
ALUop = 2'b00;
end
7'b1100011:
begin
ALUSrc = 1'b0;
MemToReg = 1'bx;
RegWrite= 1'b0;
MemRead = 1'b0;
MemWrite = 1'b0;
Branch = 1'b1;
ALUop = 2'b01;
end
endcase
end
endmodule