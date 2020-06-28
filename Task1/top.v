module top(
input clk,
input reset);


wire [63:0] PC_in, PC_out;
wire [31:0] Instruction;
wire [6:0] opcode;
wire [4:0] rd;

wire [4:0] rs1;
wire [4:0] rs2;
wire [2:0] funct3;
wire [6:0] funct7;
wire [63:0] immdata, out, WriteData;
wire [63:0]ReadData1, ReadData2;
wire ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch;
wire [1:0] ALUop;
wire [3:0] operation;
wire [63:0]dataout;
wire [63:0] result1;
wire [63:0] result2;
wire [63:0] readdatadm;
wire [63:0] add_out;
wire [1:0] Branchcontrol;
wire final;
wire zero;
wire bgt;
wire bne;

wire [63:0] mx_Branch;
wire [63:0] mx_DM;
wire [63:0] mx_Offset;

wire [63:0] ALU_PC;
wire [63:0] ALU_shift;
wire [63:0] ALU_Main_result;


program_counter pc (.PC_in(mx_Branch), .clk(clk), .reset(reset), .PC_out(PC_out));

Instruction_memory im (.Instruction_address(PC_out), .Instruction(Instruction));

instruction_parser ip(.inst(Instruction), .opcode(opcode),.rd(rd),.funct3(funct3),.rs1(rs1),.rs2(rs2),.funct7(funct7));

registerFile rf(.WriteData(mx_DM), .RS1(rs1), .RS2(rs2), .RD(rd),.RegWrite(RegWrite), .clk(clk), 
.reset(reset), .ReadData1(ReadData1), .ReadData2(ReadData2));


data_extractor de(.instruction(Instruction), .immdata(immdata)); 

control_unit cu(.ALUop(ALUop), .opcode(opcode), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch) );

ALU_control alc(.ALUop(ALUop),.funct({Instruction[30], funct3}), .operation(operation), .Branchcontrol(Branchcontrol));

Data_memory dm(.WriteData(ReadData2), .Mem_Addr(ALU_Main_result), .MemWrite(MemWrite), .clk(clk), .MemRead(MemRead), .ReadData1(readdatadm));

ALU_64_bit Alu_PC (.a(PC_out), .b(64'b0100),.ALUop(4'b0010), .result(ALU_PC), .zero(zero), .bgt(bgt), .bne(bne));

ALU_64_bit Alu_shift (.a(PC_out), .b(immdata), .ALUop(4'b0010), .result(ALU_shift), .zero(zero), .bgt(bgt), .bne(bne) );

ALU_64_bit Alu (.a(ReadData1), .b(mx_Offset), .ALUop(operation), .result(ALU_Main_result), .zero(zero), .bgt(bgt), .bne(bne) );

mux mxbranch(.a(ALU_PC), .b(ALU_shift), .sel(Branch & (zero | bgt | bne)),.dataout(mx_Branch));

mux mxdm (.a(ALU_Main_result), .b(readdatadm), .sel(MemToReg), .dataout(mx_DM));

mux mxoffset (.a(ReadData2), .b(immdata), .sel(ALUSrc), .dataout(mx_Offset));
endmodule
