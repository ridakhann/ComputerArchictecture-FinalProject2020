module instruction_fetch(
input reset, clk,
output wire[31:0] instruction
);
wire [63:0] PC_out, out;

adder add(.A(PC_out), .B(64'd4), .C(out));
program_counter pc(.clk(clk), .reset(reset),.PC_in(out), .PC_out(PC_out));
Instruction_memory im(.Instruction_address(PC_out), .Instruction(instruction));

endmodule


