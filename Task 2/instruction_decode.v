module ID_IF(
input reset, clk,
input [63:0] PC_out, //from PC
input [31:0] Instruction, //from instruction memory

output reg[63:0] instruction_address, //to adder
output reg [31:0] Instruction_out //to other modules
);

always @(posedge clk)


if (reset==1)
begin
Instruction_out = 31b'0;
instruction_address = 64b'0;

end
else
begin
Instruction_out = Instruction;
instruction_address = PC_out;

end

end

endmodule
