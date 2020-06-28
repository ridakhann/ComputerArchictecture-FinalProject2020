module forwarding(
input [63:0] MEM_WB_RegWrite, MEM_WEB_RegisterRd, EX_MEM_RegWrite, EX_MEM_RegisterRd,
ID_EX_RegisterRs1, ID_EX_RegisterRs2, 
output [1:0] Forward_A, Forward_B;
);

always @(*)
if (EX_MEM_RegisterRd == ID_EX_RegisterRs1 && EX_MEM_RegWrite == 1 && EX_MEM_RegisterRd != 0)
			begin
				Forward_A = 2'b10;
			end
		
		// MEM Hazard (a)
		else if (MEM_WB_RegisterRd == ID_EX_RegisterRs1 && MEM_WB_RegWrite == 1 && MEM_WB_RegisterRd != 0 
				&&
				!(EX_MEM_RegWrite == 1 && EX_MEM_RegisterRd != 0 && EX_MEM_RegisterRd == ID_EX_RegisterRs1)
				)
			begin
				Forward_A = 2'b01;
			end
		
		// No Hazard at mux A
		else
			begin
				Forward_A = 2'b00;
			end
		
		
		//FORWARD B LOGIC

		// EX Hazard (b)
		if (EX_MEM_RegisterRd == ID_EX_RegisterRs2 && EX_MEM_RegWrite == 1 && EX_MEM_RegisterRd != 0)
			begin
				Forward_B = 2'b10;
			end
		
		// MEM Hazard (b)
		else if (MEM_WB_RegisterRd == ID_EX_RegisterRs2 && MEM_WB_RegWrite == 1 && MEM_WB_RegisterRd != 0 
				&&
				!(EX_MEM_RegWrite == 1 && EX_MEM_RegisterRd != 0 && EX_MEM_RegisterRd == ID_EX_RegisterRs2)
				)
			begin
				Forward_B = 2'b01;
			end
		
		// No Hazard at mux B
		else 
			begin
				Forward_B = 2'b00;
			end
		
		end
endmodule


