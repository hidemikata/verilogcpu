module selector(clock_3, clock_5, clock_7, select_1, select_2, select_3, eip, ebp, esp, stack, registor_output);
input clock_3;
input clock_5;
input clock_7;
input [3:0]select_1;
input [3:0]select_2;
input [3:0]select_3;
input [31:0]eip;
input [31:0]ebp;
input [31:0]esp;
input [31:0]stack;
output [31:0]registor_output;

assign registor_output = select(clock_3, clock_5, clock_7, select_1, select_2, select_3, eip, ebp);

function [31:0] select;
input clock_3;
input clock_5;
input clock_7;
input [3:0] sel1;
input [3:0] sel2;
input [3:0] sel3;
input [31:0] eip;
input [31:0] ebp;

if (clock_3 == 1)begin
	case(sel1)
		4'h1:select = 4'h0;
		4'h2:select = esp;
		4'h3:select = 4'h0;//�o�͂Ȃ��iimmidiate_data�g�p�̂��߁j;
		4'h4:select = stack;//����Aesp�w���Ƃ���̒l�ɂȂ��ĂȂ���������B
	endcase	 
end else if (clock_5 == 1)begin//2�N���b�N��
	case(sel2)
		4'h1:select = ebp;
		4'h2:select = esp;
		4'h3:select = eip;//NIY
		4'h4:select = esp;//NIY
	endcase
end else if (clock_7 == 1)begin//3�N���b�N��
	case(sel3)
//		4'h1:select = ebp;//NIY
//		4'h2:select = esp;//NIY
		4'h2:select = eip;
//		4'h4:select = esp;//NIY
	endcase
end
endfunction


endmodule
