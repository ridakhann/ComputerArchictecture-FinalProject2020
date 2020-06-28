module EX_MEM(
input reset, clk,
input [63:0] output_adder, //from adder
input [63:0] output_ALU,	//from 64 bit alu result
input [63:0] instruction, // from last module
input [63:0] readdata2, // from register file
input WBin, Min, // regwrite nd memwrite
input zero, //from ALU
input [3:0] write_register_in

output [63:0] input_mux, //to mux before PC
output [63:0] WriteData, Mem_Addr, //to data memory
output [63:0] instruction_out, // from last module
output [3:0] write_register_out //from last module
output WB, M,
);

always @(posedge clk)

if (reset==1)
begin
input_mux = 63b'0;
WriteData = 63b'0;
Mem_Addr = 63b'0;
instruction_out = 63b'0;
write_register_out= 4b'0;
WB = 1b'0;
M = 1b'0;

end
else
begin
input_mux = output_adder;
WriteData = readdata2;
Mem_Addr = output_ALU;
instruction_out = instruction;
write_register_out = write_register_in;
WB = WBin;
M= Min;

end
end
endmodule
