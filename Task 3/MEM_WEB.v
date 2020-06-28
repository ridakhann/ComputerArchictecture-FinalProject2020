module MEM_WEB(
input [63:0] readdata, 	//from data memory
input [63:0] output_ALU, //from last module
input [3:0] write_register_in,
input wbin,
 
output [63:0] input_mux1,
output [63:0] input_mux2, 
output [63:0] instruction_out,
output [3:0] write_register_out,
output wb
);

always @(posedge clk)

if (reset==0)
begin
input_mux1 = 63b'0;
input_mux2 = 63b'0;
write_register_out = 4b'0;
instruction_out = 63b'0;
wb = 1b'0
end
else
begin
input_mux1 = readdata;
input_mux2 = ouput_ALU;
write_register_out = write_register_in;
instruction_out = instruction;
wb = wbin;

end
end
endmodule
