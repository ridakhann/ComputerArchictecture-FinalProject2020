module ALU_64_bit(
        input [63:0] a,b,
        input carryin,
        input [3:0] ALUop,
        output [63:0] result,
        output carryout 
);

wire abar = ~a;
wire bbar = ~b;

wire mux1out,mux2out;

assign mux1out = ALUop[3] ? abar : a;
assign mux2out = ALUop[2] ? bbar : b;

wire and_result, or_result, add_result;

assign and_result = mux1out & mux2out;
assign or_result = mux1out | mux2out;
assign add_result = carryin + mux1out + mux2out;

assign carryout = (a&carryin) + (b&carryin) + (a&b);

reg temp_result; 
assign result = temp_result;

always @(*)
begin
  if (ALUop[1:0] == 2'b00)
    temp_result = and_result;
    
  else if (ALUop[1:0] == 2'b01)
    temp_result = or_result;
    
  else
    temp_result = add_result;
end 

endmodule 
