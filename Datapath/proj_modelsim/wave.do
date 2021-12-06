onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /TB_Datapath/clk_tb
add wave -noupdate -radix binary /TB_Datapath/reset_tb
add wave -noupdate -radix binary /TB_Datapath/enable_PC_tb
add wave -noupdate -radix binary /TB_Datapath/Selector_Addr_tb
add wave -noupdate -radix binary /TB_Datapath/enable_MemSys_tb
add wave -noupdate -radix binary /TB_Datapath/enable_RegIns_tb
add wave -noupdate -radix binary /TB_Datapath/enable_RF_tb
add wave -noupdate -radix binary /TB_Datapath/Selector_RF_WR_tb
add wave -noupdate -radix binary /TB_Datapath/Selector_ALU_Src_A_tb
add wave -noupdate -radix binary /TB_Datapath/Selector_PC_Source_tb
add wave -noupdate -radix binary /TB_Datapath/Selector_RF_WD_tb
add wave -noupdate -radix binary /TB_Datapath/Selector_ALU_Src_B_tb
add wave -noupdate -radix binary /TB_Datapath/Selector_ALU_Op_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/GPIO_o_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/Program_Counter_o_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/Reg_Inst_o_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/RegFile_A_o_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/RegFile_B_o_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/Sign_Ext_o_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/Mux_A_o_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/Mux_B_o_tb
add wave -noupdate -radix hexadecimal /TB_Datapath/ALU_Result_o_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 185
configure wave -valuecolwidth 110
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {23 ps}
