module selector(clock_3, clock_5, select_1, select_2, eip, ebp, esp, registor_output);
input clock_3;
input clock_5;
input [3:0]select_1;
input [3:0]select_2;
input [31:0]eip;
input [31:0]ebp;
input [31:0]esp;
output [31:0]registor_output;

assign registor_output = select(clock_3, clock_5,select_1, select_2, eip, ebp);
//assign registor_output = select2(select_2, eip, ebp);

function [31:0] select;
input clock_3;
input clock_5;
input [3:0] sel1;
input [3:0] sel2;
input [31:0] eip;
input [31:0] ebp;
if (clock_3 == 1)begin
	case(sel1)
		4'h1:select = esp;
		4'h2:select = ebp;
		4'h3:select = 4'h0;//出力なし（immidiate_data使用のため）;
		4'h4:select = esp;
	endcase	 
end else if (clock_5 == 1)begin//2クロック目
	case(sel2)
		4'h1:select = ebp;
		4'h2:select = ebp;//NIY
		4'h3:select = 4'h0;//NIY
		4'h4:select = esp;//NIY
	endcase
end

endfunction

//assign registor_output = select2(select_2, eip, ebp);
//function [31:0] select2;
//input [3:0] sel;
//input [31:0] eip;
//input [31:0] ebp;
//	case(sel)
//		4'h1:select2 = esp;//NIY
//		4'h2:select2 = ebp;//NIY
//		4'h3:select2 = 4'h0;//NIY
//		4'h4:select2 = esp;//NIY
//	endcase	 
//endfunction
//

endmodule
