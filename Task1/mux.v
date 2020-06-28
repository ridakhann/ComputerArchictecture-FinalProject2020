module mux(
input [63:0] a, b,
input sel,
output [63:0]dataout
);
assign dataout = sel ? a:b;

endmodule
