module top(
input clk, reset
);

wire [63:0] PC_in, PC_out;
wire [31:0] Instruction;
wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] funct7;
wire [63:0] immdata, out, WriteData;
wire RegWrite;
wire [63:0]ReadData1, ReadData2;
wire ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch;
wire [1:0] ALUop;
wire [3:0] operation;
wire [63:0]dataout;
wire [63:0] result;
wire [63:0] readdatadm;
wire [63:0] add_out;
wire write_data;
wire zero;

program_counter pc(.PC_in(PC_in), .clk(clk), .reset(reset), .PC_out(PC_out));

Instruction_memory im(.Instruction_address(PC_out), .Instruction(Instruction));

data_extractor de(.instruction(Instruction), .immdata(immdata)); 

ID_IF idif(.reset(reset), .clk(clk), 
.PC_out(PC_out), .Instruction(Instruction), 
.instruction_address(PC_out), .Instruction_out(Instruction));

//module 1 ka output will go in instruction_parser

instruction_parser ip(.inst(Instruction), .opcode(opcode),.rd(write_data),.funct3(funct3),.rs1(rs1),.rs2(rs2),.funct7(funct7));

registerFile rf(.WriteData(WriteData), .RS1(rs1), .RS2(rs2), .RD(write_register),.RegWrite(RegWrite), .clk(clk), .reset(reset), .ReadData1(ReadData1), .ReadData2(ReadData2));

control_unit cu(.opcode(opcode), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch));\

//module 2
wire ALU_c_input; 


wire ALU_c_input; 
wire MEM_WB_RegWrite;
wire MEM_WEB_RegisterRd; 
wire EX_MEM_RegWrite; 
wire EX_MEM_RegisterRd;
wire ID_EX_RegisterRs1;
wire ID_EX_RegisterRs2; 


//write_back_register of exmem will become exmemregrd: done
//write_back_register of memweb will become memwebregrd : done
//rs1 and rs2 of IDex : done
// wb of memweb will become mem_web_regwrite
//wb of exmem will become ex_mem_regwrite

//module2

ID_EX idex(.reset(reset), .clk(clk), .Instruction_address(PC_out), 
.ALUSrc(ALUsrc), .MemToReg(MemToReg), .RegWrite(RegWrite), 
.MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUop(ALUop),// from cu 
.readdata1(ReadData1), .readdata2(ReadData2) // from reg file
.Immidiate(immdata), .Instruction(Instruction), 
.write_register_in(write_register),
.rsin(ID_EX_RegisterRs1), .rsout(ID_EX_RegisterRs2),// 

.instruction_address_out(PC_out),
.ALU_input(ReadData1), .mux_input1(ReadData2), .mux_input2(immdata), .ALU_control_input(ALU_c_input), 
.write_register_out(write_register), .wb(RegWrite), .m(MemWrite), .ex(ALUop), .Instruction(Instruction)
.rs1(ID_EX_RegisterRs1), rs2(ID_EX_RegisterRs2)
);

wire select_a, select_b;
forwarding forw(
.MEM_WB_RegWrite(MEM_WEB_RegWrite), .MEM_WEB_RegisterRd(MEM_WEB_RegisterRd), .EX_MEM_RegWrite(EX_MEM_RegWrite), 
.EX_MEM_RegisterRd(EX_MEM_RegisterRd), .ID_EX_RegisterRs1(ID_EX_RegisterRs1), .ID_EX_RegisterRs2(ID_EX_RegisterRs1), 
forwardA(select_a), forwardB(select_b);
);

wire data_memory_input;
wire result1, result2;

mux3 a(
.a(ID_EX_RegisterRs1),.b(Writedata),.c(data_memory_input),.sel(select_a),
.out1(result1) //mux output
);

mux3 b(
.a(ID_EX_RegisterRs2),.b(Writedata),.c(data_memory_input),.sel(select_b),
.out1(result2)
);

adder a(.A(PC_out), .B(64'd4), .C(PC_in)); //Add sum

ALU_control alc(.ALUop(ALUop),.funct(ALU_c_input), .operation(operation));

mux mx1(.a(ReadData2), .b(immdata), .sel(ALUSrc),.dataout(dataout));

ALU_64_bit Alu(.a(result1),.b(result2),.ALUop(ALUop), .result(result), .zero(zero));

adder b(.A(PC_out), .B(immdata<<1), .C(add_out));

//module3
EX_MEM exmem(

.reset(reset), .clk(clk),
.output_adder(add_out), //from adder
.output_ALU(result),	//from 64 bit alu result
.instruction(Instruction), // from last module
.readdata2(ReadData2), // from register file
.WBin(RegWrite), .Min(MemWrite), // regwrite nd memwrite
.zero(zero), //from aLU
.write_register_in(write_register)

.input_mux(add_out), //to mux before PC
.WriteData(ReadData2), .Mem_Addr(data_memory_input), //to data memory
.instruction_out(Instruction), // from last module
.write_register_out(EX_MEM_RegisterRd) //from last module
.WB(EX_MEM_RegWrite), .M(MemWrite)
);


Data_memory dm(.WriteData(ReadData2), .Mem_Addr(data_memory_input), .MemWrite(MemWrite), .clk(clk), .MemRead(MemRead), .ReadData1(readdatadm));

//module 4
MEM_WEB memweb(
.readdata(readdatadm), 	//from data memory
.output_ALU(data_memory_input), //from last module
.write_register_in(EX_MEM_RegisterRd),
.wbin(EX_MEM_RegWrite),
 
.input_mux1(readdatadm),
.input_mux2(result), 
.write_data_out(MEM_WEB_RegisterRd),
.instruction_out(Instruction),
.wb(MEM_WB_RegWrite)
);


mux mx2(.a(readdatadm), .b(result), .sel(MemToReg),.dataout(WriteData));



mux mx3(.a(out), .b(add_out), .sel(Branch && zero),.dataout(PC_in));

endmodule
