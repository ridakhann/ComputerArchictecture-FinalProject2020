module Data_memory(
input [63:0] WriteData, Mem_Addr,
input MemWrite, clk, MemRead,
output reg[63:0]ReadData1
 );

reg [7:0] memory [63:0];
integer seed, i,j;
initial begin
	for (i=0; i<32; i=i+1)
	begin 
		j=i;
		memory[i]= j;
	end
end


always @(*)
begin
	if (MemRead)
	begin
		ReadData1[7:0] = memory[Mem_Addr];
		ReadData1[15:8] = memory[Mem_Addr+1];
		ReadData1[23:16] = memory[Mem_Addr+2];
		ReadData1[31:24] = memory[Mem_Addr+3];
		ReadData1[39:32] = memory[Mem_Addr+4];
		ReadData1[47:40] = memory[Mem_Addr+5];
		ReadData1[55:48] = memory[Mem_Addr+6];
		ReadData1[63:56] = memory[Mem_Addr+7];
	end
end


always @ (posedge clk)
begin
	if (MemWrite)
	begin
	memory[Mem_Addr] = WriteData[7:0];
	memory[Mem_Addr+1] = WriteData[15:8];
	memory[Mem_Addr+2] = WriteData[23:16];
	memory[Mem_Addr+3] = WriteData[31:25];
	memory[Mem_Addr+4] = WriteData[39:32];
	memory[Mem_Addr+5] = WriteData[47:40];
	memory[Mem_Addr+6] = WriteData[55:48];
	memory[Mem_Addr+7] = WriteData[63:56];
	end
		
end
endmodule