module test(clk, reset, switch, out_led, seg7_1FPGA, seg7_2FPGA, seg7_3FPGA, seg7_4FPGA);
input wire clk;
input wire reset;
input wire switch;
output wire out_led;
output wire[7:0]seg7_1FPGA;
output wire[7:0]seg7_2FPGA;
output wire[7:0]seg7_3FPGA;
output wire[7:0]seg7_4FPGA;

wire clock_1;
wire clock_2;
wire clock_3;
wire clock_4;
wire clock_4_2;
wire clock_5;
wire clock_6;
wire clock_6_2;
wire clock_7;
wire clock_8;
wire clock_8_2;
wire clock_9;
wire clock_10;
wire clock_11;
wire clock_12;

wire [3:0]reg_load_1; //LOAD1,LOAD2,LOAD3,LOAD4��1�T�C�N���ڂ̖��ߗp
wire [3:0]select_1;
wire [3:0]reg_load_2;
wire [3:0]select_2;
wire [3:0]reg_load_3;
wire [3:0]select_3;

//reg clk;
//reg reset;
wire [31:0]ope;
wire [31:0]eip;
wire [3:0]selected_reg_load;
wire [31:0]alu_result_bus;
wire [31:0]ebp;
wire [31:0]esp;
wire [31:0]eax;
wire [31:0]edi;
wire [31:0]ebx;
wire [31:0]zero;
wire [31:0]stack_current;
wire [31:0]stack_addr_access;
wire [31:0]stack_esp;
wire [31:0]selected_registor_output;
wire [31:0]stack_addr;//stack�ɃA�N�Z�X�����ۂ�esp���炽�ǂ��Ȃ��ꍇ�Ɏg�p�����B

parameter STEP = 2;

//always begin
//	clk = 0;#(STEP/2);
//	clk = 1;#(STEP/2);
//end

cpu_clock clock(clk, reset, 
	clock_1, clock_2, clock_3, clock_4,clock_4_2,
	clock_5, clock_6, clock_6_2, clock_7, clock_8, clock_8_2,
	clock_9, clock_10, clock_11, clock_12);

fetch fetch(reset, clock_1, ope, eip);//32bit��ope�����ɓ���
wire [3:0]num_of_ope;
decode decode(reset, clock_2, ope, reg_load_1, select_1, reg_load_2, select_2, reg_load_3, select_3, num_of_ope);

eip_register eip_register(clock_4_2, clock_6_2, clock_8_2, clock_12, num_of_ope, reset, selected_reg_load, alu_result_bus, eip);
ebp_register ebp_register(clock_4_2, clock_6_2, reset, selected_reg_load, alu_result_bus, ebp);
stack_addr_register stack_addr_register(clock_4_2, reset, selected_reg_load, alu_result_bus, stack_addr);
esp_register esp_register(clock_4_2, clock_6_2, clock_8_2, reset, selected_reg_load, alu_result_bus, esp);
eax_register eax_register(clock_4_2, clock_6_2, reset, selected_reg_load, alu_result_bus, eax);
edi_register edi_register(clock_4_2, clock_6_2, reset, selected_reg_load, alu_result_bus, edi);
ebx_register ebx_register(clock_4_2, clock_6_2, reset, selected_reg_load, alu_result_bus, ebx);
zero_register zero_register(clock_4_2, clock_6_2, reset, selected_reg_load, alu_result_bus, zero);
stack_memory stack_memory(clock_4_2, clock_6_2, reset, selected_reg_load, alu_result_bus, esp, stack_addr, stack_current, stack_addr_access, stack_esp);
selector selector(clock_3, clock_5, clock_7, select_1, select_2, select_3, eip, ebp,esp, eax, edi,ebx, zero, stack_esp, stack_addr_access, selected_registor_output);//alu�ɓ��͂��郌�W�X�^���I����B

alu alu(clock_4, clock_6, clock_8, ope, 32'h0000, selected_registor_output, num_of_ope, alu_result_bus, zero, eax);
alu_result_selector alu_result_selector(clock_4, clock_6, clock_8, reg_load_1, reg_load_2, reg_load_3, selected_reg_load);


SevenSegmentDec seg7_1(eax[3:0], seg7_1FPGA);//�E��7seg
SevenSegmentDec seg7_2(eax[7:4], seg7_2FPGA);
SevenSegmentDec seg7_3(eax[11:8], seg7_3FPGA);
SevenSegmentDec seg7_4(eax[15:12], seg7_4FPGA);//��
assign out_led=reset;
//assign seg7_1FPGA = 8'b1111_1110;
//assign seg7_2FPGA = 8'b1111_1110;
//assign seg7_3FPGA = 8'b1111_1110;
//assign seg7_4FPGA = 8'b1111_1110;

//initial begin
//	$dumpfile("test.vcd");
//	$dumpvars(0, test);
//	#(STEP);
//	reset = 1;
//	#(STEP);
//	reset = 0;
//	#(STEP*50000);
//	$finish;
//end

initial $monitor("%d%d%d%d%d_%d%d%d%d%d%d_%d%d%d%deip[%h]ope[%h]sel1[%d]sel2[%d]sel3[%d]reg_l1[%d]reg_l2[%d]reg_l3[%d]ali[%h]alo[%h]ret[%h]sp[%h]bp[%h]ax[%h]bx[%h]di[%h]z[%h]st_cur[%h]st_esp[%h]st_acc[%h]",//%h,%h,%h,%h,%h",
	clock_1, clock_2, clock_3, clock_4, clock_4_2,clock_5, clock_6,clock_6_2, clock_7, clock_8,clock_8_2,
	clock_9, clock_10, clock_11, clock_12,
	fetch.eip,  ope, 
	select_1,
	select_2,
	select_3,
	reg_load_1,
	reg_load_2,
	reg_load_3,
	selected_registor_output,
	selected_reg_load,alu_result_bus,esp, ebp,eax,ebx,edi,zero,
	stack_current,stack_esp,stack_addr_access,//alu.debug2, alu.debug2a, alu.debug1, alu.debug1a,alu.a
);
endmodule

// 2018/03/11
// stack�̓A�h���X�������Ă��������ɂȂ�Ă����B
//   iverilog.exe .\test.v .\cpu_clock.v .\eip_register.v .\fetch.v .\memory.v .\decode.v .\ebp_register.v .\selector.v .\alu.v alu_result_selector.v .\esp_register.v .\stack_memory.v .\eax_register.v .\stack_addr_register.v .\ebx_register.v .\edi_register.v .\zero_register.v
//  vvp .\a.out
//gtkwave.exe .\test.vcd
//�g�`�͈���vvp�Ŏ�s������vcd���o�Ă����B
//
//8b5d������B
////���ƁA�X�^�b�N��낻���グ�Ă��������ɒ����Ȃ��Ƃ��܂������񂭂Ȃ��B
//�t�B�{�i�b�`���Ƃ肠�����ł����B
