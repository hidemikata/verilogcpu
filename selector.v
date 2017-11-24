module selector(select_1, select_2, eip, ebp, esp, registor_output);
input [3:0]select_1;
input [3:0]select_2;
input [31:0]eip;
input [31:0]ebp;
input [31:0]esp;
output [31:0]registor_output;

assign registor_output = select(select_1, eip, ebp);
//select_2�̎������K�v�B
function [31:0] select;
input [3:0] sel;
input [31:0] eip;
input [31:0] ebp;
	case(sel)
		4'h1:select = esp;
		4'h2:select = esp;
		4'h3:select = 4'h0;//�o�͂Ȃ��iimmidiate_data�g�p�̂��߁j;
		4'h4:select = esp;
	endcase	 
endfunction

endmodule
