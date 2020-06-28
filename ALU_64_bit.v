module ALU_64_bit(
        input [63:0] a,b,
        input [3:0] ALUop,
        output [63:0] result, 
		output reg zero,
		output reg bgt, bne
      //give func3 as input from instruction parser
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
  begin
    temp_result = a - b;
  end
  else
    temp_result = ~(a | b); //nor
	
if (temp_result == 64'b0) 
begin

	 zero = 1'b1;
   bne = 0;
   end
else if (temp_result !=64'b0)
begin
	 zero = 1'b0;
   bne = 1;
   end
	
if (a>b)
   bgt = 1'b1;
else if (a<b)
   bgt = 1'b0;
end
  
endmodule 
