module test;
wire clock_1;
wire clock_2;
wire clock_3;
wire clock_4;
wire clock_5;
wire clock_6;
wire clock_7;
wire clock_8;

wire [3:0]reg_load_1;
wire [3:0]select_1;
wire [3:0]reg_load_2;
wire [3:0]select_2;

reg clk;
reg reset;
wire [31:0]ope;

parameter STEP = 1000;

always begin
	clk = 0;#(STEP/2);
	clk = 1;#(STEP/2);
end

cpu_clock clock(clk, reset, clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8);

fetch fetch(reset, clock_1, ope);
wire [3:0]num_of_ope;
decode decode(reset, clock_2, ope, reg_load_1, select_1, reg_load_2, select_2, num_of_ope);
//reg_load_1がclock_1が変わったタイミングで変わってしまう。これでいいのか？た
//ぶんだめ。あかんねやったら中でレジスタ持たせる
//
wire [7:0]registor_output;

wire [7:0]eip;
eip_register eip_register(1'b0, 1'b0, 8'h00, eip);
wire [7:0]ebp;
ebp_register ebp_register(1'b0, 1'b0, 8'h00, ebp);
selector selector(select_1, select_2, eip, ebp, registor_output);

////clockは何を入れたらいいのかわからん。2名命令目用でselectorをわけたらいいのか？
//
reg [7:0]alu_result_bus;
//wire immidiate_data;
//immidiator(ope, eip,immidiate_data);//こいつはもしかしたら2クロック目かもしれん。eipはすすんだらだめ。
alu alu(clock_5, ope, 32'h0000, registor_output, alu_result_bus);
//
//
//wire ebp_load_switch;
//wire eip_load_switch;
//wire stack_load_switch;
//assign ebp_load_switch = (reg_load_1 == 4'h2);
//assign eip_load_switch = (reg_load_1 == 4'h4 || 4'h3);
//assign stack_load_switch = (reg_load_1 == 4'h1);
//
//ebp_register(reset, ebp_load_switch, alu_result_bus, clock_5);
//eip_register(reset, eip_load_switch, alu_result_bus, clock_5);
//esp_register(reset, esp_load_switch, alu_result_bus, clock_5);
//
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

initial $monitor("1:[%d],2:[%d],3:[%d],4:[%d],5:[%d],6:[%d],7:[%d],8:[%d]llllfetch.eip[%h]fetch.data[%h], ope[%h], numope[%d]",
	clock_1, clock_2, clock_3, clock_4, clock_5, clock_6, clock_7, clock_8,
	fetch.eip, fetch.data[31:24], ope, num_of_ope);

//initial $monitor("reg_load_1[%h], select_1[%h], reg_load_2[%h], select_2[%h]",reg_load_1, select_1, reg_load_2, select_2);
endmodule

// 2017/08/21
// fetch ができた。
//iverilog.exe .\test.v .\cpu_clock.v .\eip_register.v .\fetch.v .\memory.v .\decode.v .\ebp_register.v .\sellector.v .\alu.v
//明日はaulコンパイルエラーから
