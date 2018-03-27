module selector(clock_3, clock_5, clock_7, select_1, select_2, select_3, eip, ebp, esp,eax, edi, ebx,zero, stack, stack_addr_access, registor_output);
input clock_3;
input clock_5;
input clock_7;
input [3:0]select_1;
input [3:0]select_2;
input [3:0]select_3;
input [31:0]eip;
input [31:0]ebp;
input [31:0]esp;
input [31:0]eax;
input [31:0]edi;
input [31:0]ebx;
input [31:0]zero;
input [31:0]stack;
input [31:0]stack_addr_access;
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
		4'h3:select = 4'h0;//出力なし（immidiate_data使用のため）;
		4'h4:select = stack;//これ、esp指すところの値になってないきがする。
		4'h5:select = ebp;
		4'h6:select = eax;
		4'h7:select = eip;
	endcase	 
end else if (clock_5 == 1)begin//2クロック目
	case(sel2)
		4'h1:select = ebp;
		4'h2:select = esp;
		4'h3:select = eip;//NIY
		4'h4:select = esp;//NIY
		4'h5:select = stack;
		4'h6:select = stack_addr_access;
		4'h7:select = ebx;
	endcase
end else if (clock_7 == 1)begin//3クロック目
	case(sel3)
		4'h1:select = esp;
		4'h2:select = eip;
	endcase
end
endfunction


endmodule
