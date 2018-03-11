module decode(reset, clk2, ope, reg_load_1, select_1, reg_load_2, select_2, reg_load_3, select_3, num_of_ope);
input wire reset;
input wire clk2;
input wire [31:0]ope;
output wire [3:0]reg_load_1;//ALU�̏o�͂��ǂ̃��W�X�^�ɓ��͂��邩1���ߖ�
output wire [3:0]select_1;//ALU�̓��͂ɂ͂ǂ̃��W�X�^�̏o�͂��g����1���ߖ�
output wire [3:0]reg_load_2;//ALU�̏o�͂��ǂ̃��W�X�^�ɓ��͂��邩2���ߖ�
output wire [3:0]select_2;//ALU�̓��͂ɂ͂ǂ̃��W�X�^�̏o�͂��g����2���ߖ�
output wire [3:0]reg_load_3;//ALU�̏o�͂��ǂ̃��W�X�^�ɓ��͂��邩3���ߖ�
output wire [3:0]select_3;//ALU�̓��͂ɂ͂ǂ̃��W�X�^�̏o�͂��g����3���ߖ�
output reg [3:0]num_of_ope;//eip�ɑ����Z����l//�ǂ��ő����Z���邩�ۑ�
wire [7:0]ope1;//opecode1�o�C�g��//reg��fetch�������Ă�

assign ope1 = ope[31:24];//���
 
assign reg_load_1 = load_reg_1(ope1);//ALU�̏o�͐�
assign select_1 = select_input_1(ope1);//ALU�̓��͌�
assign reg_load_2 = load_reg_2(ope1);//ALU�̏o�͐�
assign select_2 = select_input_2(ope1);//ALU�̓��͌�
assign reg_load_3 = load_reg_3(ope1);//ALU�̏o�͐�
assign select_3 = select_input_3(ope1);//ALU�̓��͌�

function [3:0] load_reg_1;
input [7:0]ope;
begin
	case(ope)//ALU�̏o�͂��ǂ̃��W�X�^�ɓ��͂��邩1���ߖ�
		8'h55: load_reg_1 = 4'h1;//esp
		8'h89: load_reg_1 = 4'h2;//ebp
		8'hb8: load_reg_1 = 4'h3;//eax
		8'h5d: load_reg_1 = 4'h2;//ebp
		8'hc3: load_reg_1 = 4'h4;//eip
		8'he2: load_reg_1 = 4'h1;//esp
		default load_reg_1 = 4'hx;
	endcase
end
endfunction

function [3:0] select_input_1;
input [7:0]ope;
begin
	case(ope)//ALU�̓��͂ɂ͂ǂ̃��W�X�^�̏o�͂��g����2���ߖ�
		8'h55: select_input_1 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
		8'h89: select_input_1 = 4'h2;//esp
		8'hb8: select_input_1 = 4'h3;//immidiate data
		8'h5d: select_input_1 = 4'h4;//esp�̎w���A�h���X�o�X
		8'hc3: select_input_1 = 4'h4;//esp�̎w���A�h���X�o�X
		8'he2: select_input_1 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
		default select_input_1 = 4'hx;
	endcase
end
endfunction

function [3:0] load_reg_2;
input [7:0]ope;
begin
	case(ope)//ALU�̏o�͂��ǂ̃��W�X�^�ɓ��͂��邩2���ߖ�
		8'h55: load_reg_2 = 4'h1;//esp�̎w���A�h���X�o�X
		8'h89: load_reg_2 = 4'hx;//
		8'hb8: load_reg_2 = 4'hx;//
		8'h5d: load_reg_2 = 4'h2;//esp
		8'hc3: load_reg_2 = 4'h2;//eip
		8'he2: load_reg_2 = 4'h1;//esp�̎w���A�h���X�o�X
		default load_reg_2 = 4'hx;
	endcase
end
endfunction

function [3:0] select_input_2;
input [7:0]ope;
begin
	case(ope)//ALU�̓��͂ɂ͂ǂ̃��W�X�^�̏o�͂��g����2���ߖ�
		8'h55: select_input_2 = 4'h1;//ebp
		8'h89: select_input_2 = 4'hx;//
		8'hb8: select_input_2 = 4'hx;//
		8'h5d: select_input_2 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
		8'hc3: select_input_2 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
		8'he2: select_input_2 = 4'h3;//eip
		default select_input_2 = 4'hx;
	endcase
end
endfunction

function [3:0] load_reg_3;
input [7:0]ope;
begin
	case(ope)//ALU�̏o�͂��ǂ̃��W�X�^�ɓ��͂��邩2���ߖ�
//		8'h55: load_reg_3 = 4'h1;//esp�̎w���A�h���X�o�X
//		8'h89: load_reg_3 = 4'hx;//
//		8'hb8: load_reg_3 = 4'hx;//
//		8'h5d: load_reg_3 = 4'h2;//esp
//		8'hc3: load_reg_3 = 4'h2;//eip
		8'he2: load_reg_3 = 4'h4;//esp�̎w���A�h���X�o�X
		default load_reg_3 = 4'hx;
	endcase
end
endfunction

function [3:0] select_input_3;
input [7:0]ope;
begin
	case(ope)//ALU�̓��͂ɂ͂ǂ̃��W�X�^�̏o�͂��g����2���ߖ�
//		8'h55: select_input_3 = 4'h1;//ebp
//		8'h89: select_input_3 = 4'hx;//
//		8'hb8: select_input_3 = 4'hx;//
//		8'h5d: select_input_3 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
//		8'hc3: select_input_3 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
		8'he2: select_input_3 = 4'h2;//eip���̒l���瑫���Z����
		default select_input_3 = 4'hx;
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
		8'he2: calc_ope = 4'h5;
		default calc_ope = 4'hx;
	endcase
end
endfunction
endmodule


