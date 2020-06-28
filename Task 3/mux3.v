module mux3(
input a,b,c,
input  [1:0] sel,
output reg out1

);
always @(*)
   if (sel==2’b00)
		  out1 = a;
   else if (sel == 2’b01)
		  out1 = b;
   else if (sel == 2’b10)
		  out1 = c;
endmodule


