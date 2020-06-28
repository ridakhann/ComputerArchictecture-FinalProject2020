module ID_EX(

input reset, clk,
input [63:0] Instruction_address; //from PC
input ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, 
input [1:0] ALUop //control signals
input [63:0] readdata1, readdata2, //from register files
input [63:0] Immidiate,	//from immidiate generator
input [31:0] Instruction, 	//instruction memory, last module
input [3:0] write_register_in


output [63:0]instruction_address_out, //to adder
output [31:0] Instruction_out,
output [63:0] ALU_input,   //to 64 bit ALU
output [63:0] mux_input1,  //to input
output [63:0] mux_input2, //shifting ke bad into Adders
output [4:0] ALU_control_input, //from instruction specific index to ALU control
output [3:0] write_register_out, //instruction ka aik part, will directly go to the next module
output wb, m, ex, 
);

always @(posedge clk)

if (reset==1)
begin
Instruction_address_out = 63b'0;
ALU_input = 63b'0;
mux_input1 = 63b'0;
mux_input2 = 63b'0;
ALU_control_input = 4b'0;
write_register_out= 4b'0;
Instruction_out = 31b'0;
wb = 1b'0;
m = 1b'0;
ex = 2b'0;

end
else
begin


Instruction_address_out = Instruction_address;
ALU_input = readdata1;
mux_input1 = readdata2;
mux_input2 = Immidiate;
ALU_control_input = Instruction[30, 14, 13, 12];
write_register_out = write_register_in;
Instruction_out = Instruction;
wb = RegWrite;
m = MemWrite;
ex = ALUop;


end

end

endmodule


