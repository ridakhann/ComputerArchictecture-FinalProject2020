module program_counter(
input [63:0] PC_in,
input clk, reset,
output reg[63:0] PC_out
);
always @(posedge clk or posedge reset)
begin
if (reset)
begin
PC_out = 0;
end
else
begin
PC_out =PC_in;
end
end
endmodule