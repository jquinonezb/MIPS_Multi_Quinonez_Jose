module Data_Path
(
	//Inputs
	input clk,
	input reset,
	
	/********* SEÑALES DE CONTROL *********/
	/*********                    *********/
	input enable_PC, Selector_Addr, enable_MemSys, enable_RegIns,
	input enable_RF, Selector_RF_WR, Selector_ALU_Src_A, Selector_PC_Source,
	input Selector_RF_WD,
	input [1:0] Selector_ALU_Src_B,
	input [2:0] Selector_ALU_Op,
	
	//Output
	output [31:0] Reg_Inst_o,
		      Program_Counter_o,
		      RegFile_A_o,
		      RegFile_B_o,
		      Sign_Ext_o,
		      Mux_WD_o,
		      Mux_A_o,
		      Mux_B_o,
		      ALU_Result_o,
	output [4:0]  Mux_WR_o,
	output [7:0] GPIO_o
);

wire [31:0]	PC_o, 
				Mux1_o, 
				Mem_o, 
				Ins_Reg_o,
				Data_Reg_o,
				Mux_RF_WD,
				Data1_o, 
				Data2_o,
				Reg_A_o,
				Reg_B_o,
				Src_A,
				Src_B,
				ALU_o,
				Reg_ALU_o,
				PC_source_o,
				Sign_Extend_o;
				
wire [4:0]	Mux2_o;

// PROGRAM COUNTER
Program_counter 	PC(.D(PC_source_o), .clk(clk), .reset(reset), .enable(enable_PC), .Q(PC_o));

//MUX TO CHOOSE WHICH DATA IS GOING TO BE GIVEN TO THE MEMORY SYSTEM
MUX2_1		Address_MUX(.data_1(ALU_o), .data_2(PC_o), .selector(Selector_Addr), .data_o(Mux1_o));

//MEMORY SYSTEM
Memory_system	Memories(.write_enable_i(enable_MemSys), .clock(clk), .Write_Data(Reg_B_o), .Address_i(Mux1_o), .Instruction_o(Mem_o)); 

//REGISTER CONTAINS THE INSTRUCTION OF THE MEMORY SYSTEM
Register 	Inst_Reg(.Rd(Mem_o), .clk(clk), .reset(reset), .enable(enable_RegIns), .Q1(Ins_Reg_o));

//DATA REGISTER
Register_W_en 	Data(.D(Mem_o), .clk(clk), .reset(reset), .Q(Data_Reg_o));

//REGISTER FILE
Register_File	RF(
	.clk(clk),
	.reset(reset),
	.Reg_Write_i(enable_RF), 	
	.Read_Register_1_i(Ins_Reg_o[25:21]),
	.Read_Register_2_i(Ins_Reg_o[20:16]),
	.Write_Register_i(Mux2_o),
	.Write_Data_i(Mux_RF_WD),
	.Read_Data_1_i(Data1_o),
	.Read_Data_2_i(Data2_o)
);

//MUX WRITE_REGISTER -> REG_FILE
MUX2_1	#(.WIDTH(5))	MUX_IR(.data_1(Ins_Reg_o[15:11]), .data_2(Ins_Reg_o[20:16]), .selector(Selector_RF_WR), .data_o(Mux2_o));

//MUX WRITE_DATA -> REG_FILE
MUX2_1		MUX_DATA(.data_1(Data_Reg_o), .data_2(Reg_ALU_o), .selector(Selector_RF_WD), .data_o(Mux_RF_WD));

// REGISTER A AND B FOR THE OUTPUT OF REGISTER FILE
Register_W_en 	Read_Data_A(.D(Data1_o), .clk(clk), .reset(reset), .Q(Reg_A_o));
Register_W_en 	Read_Data_B(.D(Data2_o), .clk(clk), .reset(reset), .Q(Reg_B_o));

//MUX2_1 TO CHOOSE INPUT DATA A TO ALU
MUX2_1		Source_A(.data_1(Reg_A_o), .data_2(PC_o), .selector(Selector_ALU_Src_A), .data_o(Src_A));

//MUX4_1 TO CHOOSE INPUT DATA B TO ALU
MUX4_1		Source_B(.data_1(Reg_B_o), .data_2(Sign_Extend_o), .dato_3(Sign_Extend_o << 2), .selector(Selector_ALU_Src_B), .data_o(Src_B));

//ALU
ALU		Alu_mod(.data_a(Src_A), .data_b(Src_B), .select(Selector_ALU_Op), .y(ALU_o));

//REGISTER ALU OUT
Register_W_en 	Read_ALU_Output(.D(ALU_o), .clk(clk), .reset(reset), .Q(Reg_ALU_o));

//MUX TO DECIDE PROGRAMM COUNTER SOURCE
MUX2_1		PC_Source(.data_1(Reg_ALU_o), .data_2(ALU_o), .selector(Selector_PC_Source), .data_o(PC_source_o));

//SIGN_EXTEND
Sign_Extend		SE(.Sign_Ext_i(Ins_Reg_o[15:0]), .Sign_Ext_o(Sign_Extend_o));

//Datapath Output to GPIO
assign GPIO_o = ALU_o[7:0];
assign Program_Counter_o = PC_o;
assign Reg_Inst_o = Ins_Reg_o;
assign RegFile_A_o = Data1_o;
assign RegFile_B_o = Data2_o;
assign Sign_Ext_o = Sign_Extend_o;
assign Mux_WR_o = Mux2_o;
assign Mux_WD_o = Mux_RF_WD;
assign Mux_A_o = Src_A;
assign Mux_B_o = Src_B;
assign ALU_Result_o = ALU_o;

endmodule 