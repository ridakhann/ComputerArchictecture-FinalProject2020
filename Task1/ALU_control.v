module ALU_control(
input [1:0] ALUop,
input [3:0] funct,
output reg [1:0] Branchcontrol,
output reg [3:0] operation
);
always @(*)
begin
case (ALUop)
2'b00: operation <= 0010;
2'b01: 
begin
case(funct[2:0])
3'b000: 
begin
operation <= 4'b0110;
Branchcontrol <= 2'b00;
end
3'b001: 
begin
operation <= 4'b0110;
Branchcontrol <= 2'b01;
end
3'b100: 
begin
operation <= 4'b0110;
Branchcontrol <= 2'b10;
end

3'b101: 
begin
operation <= 4'b0110;
Branchcontrol <= 2'b11;
end
endcase
end 
  
2'b10:
begin
case(funct)
4'b0000: operation <= 4'b0010;
4'b1000: operation <= 4'b0110;
4'b0111: operation <= 4'b0000;
4'b0110: operation <= 4'b0001;
endcase
end
endcase
end
endmodule
