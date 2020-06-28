module data_extractor( input [31:0] instruction, 
output reg [63:0] immdata ); 

wire [6:0]opcode; 
assign opcode= instruction[6:0];

always @ * 
begin 
if (opcode[6:5]==00)//load 
begin immdata = {{52{instruction[31]}},instruction[31:20]}; 
end

else if (opcode[6:5]==01)//load 
begin immdata = {{52{instruction[31]}},instruction[31:25], instruction[11:7]}; end
else if (opcode[6] == 1) 
begin 
immdata = {{53{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8]}; 
end 
end 
endmodule