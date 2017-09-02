module decode(reset, clk2, ope, reg_load_1, select_1, reg_load_2, select_2, num_of_ope);
input wire reset;
input wire clk2;
input wire [31:0]ope;
output wire [3:0]reg_load_1;//どのレジスタに入力するか1命令目
output wire [3:0]reg_load_2;//どのレジスタに入力するか2命令目
output wire [3:0]select_1;//どのレジスタの出力を使うか1命令目
output wire [3:0]select_2;//どのレジスタの出力を使うか2命令目
output reg [3:0]num_of_ope;//eipに足し算する値
wire [7:0]ope1;//opecode1バイト目

assign ope1 = ope[31:24];//上位

 
assign reg_load_1 = load_reg_1(ope1);
assign reg_load_2 = load_reg_2(ope1);
assign select_1 = select_input_1(ope1);
assign select_2 = select_input_2(ope1);

function [3:0] load_reg_1;
input [7:0]ope;
begin
	case(ope)
		8'h55: load_reg_1 = 4'h1;//esp
		8'h89: load_reg_1 = 4'h2;//ebp
		8'hb8: load_reg_1 = 4'h3;//eax
		8'h5d: load_reg_1 = 4'h2;//ebp
		8'hc3: load_reg_1 = 4'h4;//eip
		8'he8: load_reg_1 = 4'h1;//esp
		default load_reg_1 = 4'hx;
	endcase
end
endfunction


function [3:0] load_reg_2;
input [7:0]ope;
begin
	case(ope)
		8'h55: load_reg_2 = 4'h1;//espの指すアドレスバス
		8'h89: load_reg_2 = 4'hx;//
		8'hb8: load_reg_2 = 4'hx;//
		8'h5d: load_reg_2 = 4'h2;//esp
		8'hc3: load_reg_2 = 4'h3;//eip
		8'he8: load_reg_2 = 4'h1;//espの指すアドレスバス
		default load_reg_2 = 4'hx;
	endcase
end
endfunction

function [3:0] select_input_1;
input [7:0]ope;
begin
	case(ope)
		8'h55: select_input_1 = 4'h1;//固定値？(スタック移動分かアドレス)
		8'h89: select_input_1 = 4'h2;//esp
		8'hb8: select_input_1 = 4'h3;//immidiate data
		8'h5d: select_input_1 = 4'h4;//espの指すアドレスバス
		8'hc3: select_input_1 = 4'h4;//espの指すアドレスバス
		8'he8: select_input_1 = 4'h1;//固定値？(スタック移動分かアドレス)
		default select_input_1 = 4'hx;
	endcase
end
endfunction

function [3:0] select_input_2;
input [7:0]ope;
begin
	case(ope)
		8'h55: select_input_2 = 4'h1;//ebp
		8'h89: select_input_2 = 4'hx;//
		8'hb8: select_input_2 = 4'hx;//
		8'h5d: select_input_2 = 4'h2;//固定値？(スタック移動分かアドレス)
		8'hc3: select_input_2 = 4'h2;//固定値？(スタック移動分かアドレス)
		8'he8: select_input_2 = 4'h3;//eip
		default select_input_2 = 4'hx;
	endcase
end
endfunction

always @(posedge reset or posedge clk2) begin
	if (reset == 1'b1) begin
		num_of_ope <= 4'h0;
	end 
	else begin
		num_of_ope <= calc_ope(ope1);
	end 
end

function [3:0] calc_ope;
input [7:0]ope;
begin
	case(ope)
		8'h55: calc_ope = 4'h1;
		8'h89: calc_ope = 4'h2;
		8'hb8: calc_ope = 4'h5;
		8'h5d: calc_ope = 4'h1;
		8'hc3: calc_ope = 4'h1;
		8'he8: calc_ope = 4'h5;
		default calc_ope = 4'hx;
	endcase
end
endfunction
endmodule
