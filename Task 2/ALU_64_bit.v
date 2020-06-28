module ALU_64_bit(
        input [63:0] a,b,
        
        input [3:0] ALUop,
        output [63:0] result, 
		output reg zero
      
);

reg [63:0] temp_result; 
assign result = temp_result;

always @(*)
begin
  if (ALUop == 4'b0000) //and
    temp_result = a & b;
    
  else if (ALUop == 4'b0001)//or
    temp_result = a | b;
    
  else if (ALUop == 4'b0010)//add
    temp_result = a + b;  
    
  else if (ALUop == 4'b0110)//sub
    temp_result = a - b;
    
  else
    temp_result = ~(a | b); //nor
	
if (temp_result == 64'b0) 
	zero = 1'b1;
else if (temp_result !=64'b0)
	zero = 1'b0;
end 


	

endmodule 
