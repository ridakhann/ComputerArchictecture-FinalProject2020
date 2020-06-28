module registerFile(
input [63:0] WriteData,
input [4:0]RS1,RS2, RD,
input RegWrite, clk, reset,


output reg[63:0]ReadData1, ReadData2
);
reg [63:0] Registers [31:0];
integer seed, i,j;
initial begin
for (i=0; i<32; i=i+1)
begin
j=i;
Registers[i]= j;
end
end
always @(*)
begin
if (reset)
begin
ReadData1 = 64'b0;
ReadData2 = 64'b0;
end
else
begin
ReadData1 = Registers[RS1];
ReadData2 = Registers[RS2];
end
end
always @ (posedge clk)
begin
	if (RegWrite)
	begin
		Registers[RD] = WriteData;
	end
		
end
endmodule