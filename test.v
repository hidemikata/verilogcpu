module test;
wire clock_1;
wire clock_2;
wire clock_3;
wire clock_4;
wire clock_5;
wire clock_6;
wire clock_7;
wire clock_8;

wire [3:0]reg_load_1; //LOAD1,LOAD2,LOAD3,LOAD4の1サイクル目の命令用
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
wire [31:0]selected_registor_output;

parameter STEP = 1000;

always begin
	clk = 0;#(STEP/2);
	clk = 1;#(STEP/2);
end

cpu_clock clock(clk, reset, clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8);

fetch fetch(reset, clock_1, ope, eip);//32bitのopeが手に入る
wire [3:0]num_of_ope;
decode decode(reset, clock_2, ope, reg_load_1, select_1, reg_load_2, select_2, num_of_ope);

eip_register eip_register(clock_5, reset, selected_reg_load, alu_result_bus, eip);
ebp_register ebp_register(clock_5, reset, selected_reg_load, alu_result_bus, ebp);
esp_register esp_register(clock_5, reset, selected_reg_load, alu_result_bus, esp);
selector selector(clock_5, clock_7, select_1, select_2, eip, ebp, esp, selected_registor_output);//aluに入力するレジスタを選択する。

//wire immidiate_data;
//immidiator(ope, eip,immidiate_data);//こいつはもしかしたら2クロック目かもしれん。eipはすすんだらだめ。
alu alu(clock_5, clock_7, ope, 32'h0000, selected_registor_output, alu_result_bus);
alu_result_selector alu_result_selector(clock_5, 1'b0, reg_load_1, reg_load_2, selected_reg_load);//1命令目か2命令目かで入力先レジスタがちがうのでセレクタをかます。
//第2引数は2命令目。aluとクロックを合わすこと。




////addressに書き込むやつ。
//wire [7:0]stack_connect_address;
//esp_register(reset, 8'h0, stack_connect_address, clock_6);//6? 8'h0でつないでるとずっとreadでアドレスとれてるのか.
//stack_reader_writer(reset, stack_load_switch, alu_result_bus, stack_connect_address, clock_6);//6?//stackにアクセスするレジスタ的なもの
//


initial begin
	#(STEP);
	reset = 1;
	#(STEP);
	reset = 0;
	#(STEP*40);
	$finish;
end
//initial $monitor("1:[%d],2:[%d],3:[%d],4:[%d],5:[%d],6:[%d],7:[%d],8:[%d]fetch.eip[%h]fetch.data[%h], ope[%h], numope[%d]",
//	clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8,
//	fetch.eip, fetch.data[31:24], ope, num_of_ope);
initial $monitor("%d%d%d%d%d%d%d%d,fetch.eip[%h]fetch.data[%h],ope[%h],numope[%d],select_1[%d]sel_reg_out[%h],alu_result_bus[%h],sel_reg_load[%d],esp[%h],ebp[%h]",
	clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8,
	fetch.eip, fetch.data[31:24], ope, num_of_ope,select_1,selected_registor_output, alu_result_bus,
	selected_reg_load,esp, ebp,);


//initial $monitor("reg_load_1[%h], select_1[%h], reg_load_2[%h], select_2[%h]",reg_load_1, select_1, reg_load_2, select_2);
endmodule

// 2017/12/14
//iverilog.exe .\test.v .\cpu_clock.v .\eip_register.v .\fetch.v .\memory.v .\decode.v .\ebp_register.v .\selector.v .\alu.v alu_result_selector.v .\esp_register.v
//vvp .\a.out
//それができたら2サイクル目の実装中selectorのNIYから。
//
//
