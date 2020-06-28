// module data_extractor( input [31:0] instruction, 
// output reg [63:0] immdata ); 

// wire [6:0]opcode; 
// assign opcode= instruction[6:0];

// always @ * 
// begin 
// if (opcode[6:5]==00)//load 
// begin immdata = {{52{instruction[31]}},instruction[31:20]}; 
// end

// else if (opcode[6:5]==01)//load 
// begin immdata = {{52{instruction[31]}},instruction[31:25], instruction[11:7]}; end
// else if (opcode[6] == 1) 
// begin 
// immdata = {{53{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8]}; 
// end 
// end 
// endmodule
module data_extractor(
input [31:0]instruction,
output reg [63:0] immdata);

wire [63:0]immdata1, immdata2, immdata3;

assign imm_data1 = {{52{instruction[31]}}, instruction[31:20]};
assign imm_data2 = {{52{instruction[31]}}, instruction[31:25], instruction[11:7]};
assign imm_data3 = {{52{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};

always@(*)
begin
  if(instruction[5] == 1'b0 && instruction[6] == 1'b0)
    immdata = imm_data1;
  else if (instruction[5] == 1'b1 && instruction[6] == 1'b0)
    immdata = imm_data2;
  else if (instruction[6] == 1'b1)
    immdata = imm_data3;
end

endmodule
