module test;
wire clock_1;
wire clock_2;
wire clock_3;
wire clock_4;
wire clock_5;
wire clock_6;
wire clock_7;
wire clock_8;

wire [3:0]reg_load_1; //LOAD1,LOAD2,LOAD3,LOAD4��1�T�C�N���ڂ̖��ߗp
wire [3:0]select_1;
wire [3:0]reg_load_2;
wire [3:0]select_2;

reg clk;
reg reset;
wire [31:0]ope;
wire [31:0]eip;
wire [3:0]selected_reg_load;
wire [31:0]alu_result_bus;
wire [31:0]ebp;
wire [31:0]esp;
wire [31:0]eax;
wire [31:0]stack;
wire [31:0]selected_registor_output;

parameter STEP = 1000;

always begin
	clk = 0;#(STEP/2);
	clk = 1;#(STEP/2);
end

cpu_clock clock(clk, reset, clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8);

fetch fetch(reset, clock_1, ope, eip);//32bit��ope����ɓ���
wire [3:0]num_of_ope;
decode decode(reset, clock_2, ope, reg_load_1, select_1, reg_load_2, select_2, num_of_ope);

eip_register eip_register(clock_4, clock_8, num_of_ope, reset, selected_reg_load, alu_result_bus, eip);
ebp_register ebp_register(clock_4, reset, selected_reg_load, alu_result_bus, ebp);
esp_register esp_register(clock_4, reset, selected_reg_load, alu_result_bus, esp);
eax_register eax_register(clock_4, reset, selected_reg_load, alu_result_bus, eax);
stack_memory stack_memory(clock_4, clock_6, reset, selected_reg_load, alu_result_bus, esp, stack);
selector selector(clock_3, clock_5, select_1, select_2, eip, ebp, esp, selected_registor_output);//alu�ɓ��͂��郌�W�X�^��I������B

//wire immidiate_data;
//immidiator(ope, eip,immidiate_data);//�����͂�����������2�N���b�N�ڂ��������Beip�͂����񂾂炾�߁B
alu alu(clock_4, clock_6, ope, 32'h0000, selected_registor_output, alu_result_bus);
alu_result_selector alu_result_selector(clock_4, clock_6, reg_load_1, reg_load_2, selected_reg_load);//1���ߖڂ�2���ߖڂ���alu->�̃��W�X�^���������̂ŃZ���N�^�����܂��B


initial begin
	#(STEP);
	reset = 1;
	#(STEP);
	reset = 0;
	#(STEP*70);
	$finish;
end
//initial $monitor("1:[%d],2:[%d],3:[%d],4:[%d],5:[%d],6:[%d],7:[%d],8:[%d]fetch.eip[%h]fetch.data[%h], ope[%h], numope[%d]",
//	clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8,
//	fetch.eip, fetch.data[31:24], ope, num_of_ope);
initial $monitor("%d%d%d%d_%d%d%d%d,fetch.eip[%h]fetch.data[%h],ope[%h],numope[%d],select_1[%d],sel2[%d],reg_l1[%d],reg_l2[%d]sel_reg_out[%h],alu_result_bus[%h],sel_reg_load[%d],esp[%h],ebp[%h],eax,[%h],stack[%h]",
	clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8,
	fetch.eip, fetch.data[31:24], ope, num_of_ope,
	select_1,
	select_2,
	reg_load_1,
	reg_load_2,
	selected_registor_output, alu_result_bus,
	selected_reg_load,esp, ebp,eax,stack);


//initial $monitor("reg_load_1[%h], select_1[%h], reg_load_2[%h], select_2[%h]",reg_load_1, select_1, reg_load_2, select_2);
endmodule

// 2018/02/08
// stack�̓A�h���X�������Ă��������ɂȂ��Ă���B
// iverilog.exe .\test.v .\cpu_clock.v .\eip_register.v .\fetch.v .\memory.v .\decode.v .\ebp_register.v .\selector.v .\alu.v alu_result_selector.v .\esp_register.v .\stack_memory.v .\eax_register.v
//vvp .\a.out
//b802����B���̂܂���89e5��e5�͋@�\���Ă���̂�����ׂ�Be5����Ȃ�������ʂ̃��W�X�^�ɂ����Ƃ����̂��B
// ���ς��Ȃ��Bdecode��select_input_2��2�ڈႤ�������悤�ɂ��Ă����Ȃ��ƃ_���B�ł�
// fibondisasem���݂�ƒ�����3�̂������ȁB�B�B
// ���B
// ���̂܂���b8��������̂ł��̂��̂�����B5D���B�B�B
//
//
