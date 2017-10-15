module selector(select_1, select_2, eip, ebp, esp, registor_output);
input [3:0]select_1;
input [3:0]select_2;//2はいつ使うのかよくわからん。selectorを2個に分けたらいいかも。も。
input [7:0]eip;
input [7:0]ebp;
input [7:0]esp;
output [7:0]registor_output;

assign registor_output = select(select_1, eip, ebp);

function [7:0] select;
input [7:0] eip, ebp;
input [3:0] select_1;
	case(select_1)
		4'h1:select = 4'h4;
		4'h2:select = esp;
		4'h3:select = 4'h0;//出力なし（immidiate_data使用のため）;
		4'h4:select = esp;
	endcase	 
endfunction

endmodule
