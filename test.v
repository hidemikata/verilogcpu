module test;
wire clock_1;
wire clock_2;
wire clock_3;
wire clock_4;
wire clock_5;
wire clock_6;
wire clock_7;
wire clock_8;
wire clock_9;
wire clock_10;
wire clock_11;
wire clock_12;

wire [3:0]reg_load_1; //LOAD1,LOAD2,LOAD3,LOAD4の1サイクル目の命令用
wire [3:0]select_1;
wire [3:0]reg_load_2;
wire [3:0]select_2;
wire [3:0]reg_load_3;
wire [3:0]select_3;

reg clk;
reg reset;
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
wire [31:0]stack_addr;//stackにアクセスする際にespからたどらない場合に使用する。

parameter STEP = 1000;

always begin
	clk = 0;#(STEP/2);
	clk = 1;#(STEP/2);
end

cpu_clock clock(clk, reset, 
	clock_1, clock_2, clock_3, clock_4,
	clock_5, clock_6, clock_7, clock_8,
	clock_9, clock_10, clock_11, clock_12);

fetch fetch(reset, clock_1, ope, eip);//32bitのopeが手に入る
wire [3:0]num_of_ope;
decode decode(reset, clock_2, ope, reg_load_1, select_1, reg_load_2, select_2, reg_load_3, select_3, num_of_ope);

eip_register eip_register(clock_4, clock_6, clock_8, clock_12, num_of_ope, reset, selected_reg_load, alu_result_bus, eip);
ebp_register ebp_register(clock_4, clock_6, reset, selected_reg_load, alu_result_bus, ebp);
stack_addr_register stack_addr_register(clock_4, reset, selected_reg_load, alu_result_bus, stack_addr);
esp_register esp_register(clock_4, clock_6, clock_8, reset, selected_reg_load, alu_result_bus, esp);
eax_register eax_register(clock_4, clock_6, reset, selected_reg_load, alu_result_bus, eax);
edi_register edi_register(clock_4, clock_6, reset, selected_reg_load, alu_result_bus, edi);
ebx_register ebx_register(clock_4, clock_6, reset, selected_reg_load, alu_result_bus, ebx);
zero_register zero_register(clock_4, clock_6, reset, selected_reg_load, alu_result_bus, zero);
stack_memory stack_memory(clock_4, clock_6, reset, selected_reg_load, alu_result_bus, esp, stack_addr, stack_current, stack_addr_access, stack_esp);
selector selector(clock_3, clock_5, clock_7, select_1, select_2, select_3, eip, ebp,esp, eax, edi,ebx, zero, stack_esp, stack_addr_access, selected_registor_output);//aluに入力するレジスタを選択する。

alu alu(clock_4, clock_6, clock_8, ope, 32'h0000, selected_registor_output, num_of_ope, alu_result_bus, zero);
alu_result_selector alu_result_selector(clock_4, clock_6, clock_8, reg_load_1, reg_load_2, reg_load_3, selected_reg_load);


initial begin
	#(STEP);
	reset = 1;
	#(STEP);
	reset = 0;
	#(STEP*2000);
	$finish;
end

initial $monitor("%d%d%d%d_%d%d%d%d_%d%d%d%deip[%h]ope[%h]sel1[%d]sel2[%d]sel3[%d]reg_l1[%d]reg_l2[%d]reg_l3[%d]ali[%h]alo[%h]ret[%h]sp[%h]bp[%h]ax[%h]bx[%h]di[%h]z[%h]st_cur[%h]st_esp[%h]st_acc[%h]",//%h,%h,%h,%h,%h",
	clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8,
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
// stackはアドレスが増えていく感じになっている。
//   iverilog.exe .\test.v .\cpu_clock.v .\eip_register.v .\fetch.v .\memory.v .\decode.v .\ebp_register.v .\selector.v .\alu.v alu_result_selector.v .\esp_register.v .\stack_memory.v .\eax_register.v .\stack_addr_register.v .\ebx_register.v .\edi_register.v
//  vvp .\a.out
//8b5d実装中。
////あと、スタックをそろそろ上げていく感じに直さないとつじつまがあわんくなる。
//動確から。ジャンプがうまくいっとらん。
//なんか知らんけどうまくいってる。
//
