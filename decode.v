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
wire [15:0]ope1;//opecode1�o�C�g��//reg��fetch�������Ă�

assign ope1 = ope[31:16];//���
 
assign reg_load_1 = load_reg_1(ope1);//ALU�̏o�͐�
assign select_1 = select_input_1(ope1);//ALU�̓��͌�
assign reg_load_2 = load_reg_2(ope1);//ALU�̏o�͐�
assign select_2 = select_input_2(ope1);//ALU�̓��͌�
assign reg_load_3 = load_reg_3(ope1);//ALU�̏o�͐�
assign select_3 = select_input_3(ope1);//ALU�̓��͌�

function [3:0] load_reg_1;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		load_reg_1 = 4'h1;//esp
        end else if (ope[15:8] == 8'h89) begin
		load_reg_1 = 4'h2;//ebp
        end else if (ope[15:8] == 8'hb8) begin
		load_reg_1 = 4'h3;//eax
        end else if (ope[15:8] == 8'h5d) begin
		load_reg_1 = 4'h2;//ebp
        end else if (ope[15:8] == 8'hc3) begin
		load_reg_1 = 4'h4;//eip
        end else if (ope[15:8] == 8'he2) begin
		load_reg_1 = 4'h1;//esp
        end else if (ope[15:8] == 8'h6a) begin
		load_reg_1 = 4'h1;//esp
        end else begin
		load_reg_1 = 4'hx;
        end;
////	case(ope)//ALU�̏o�͂��ǂ̃��W�X�^�ɓ��͂��邩1���ߖ�
////		8'h55: load_reg_1 = 4'h1;//esp
////		8'h89: load_reg_1 = 4'h2;//ebp
////		8'hb8: load_reg_1 = 4'h3;//eax
////		8'h5d: load_reg_1 = 4'h2;//ebp
////		8'hc3: load_reg_1 = 4'h4;//eip
////		8'he2: load_reg_1 = 4'h1;//esp
////		8'h6a: load_reg_1 = 4'h1;//esp
//////		8'h8b: load_reg_1 = 4'h3;//eax
//		default load_reg_1 = 4'hx;
//	endcase
end
endfunction

function [3:0] select_input_1;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		select_input_1 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
        end else if (ope[15:8] == 8'h89) begin
		select_input_1 = 4'h2;//esp
        end else if (ope[15:8] == 8'hb8) begin
		select_input_1 = 4'h3;//immidiate data
        end else if (ope[15:8] == 8'h5d) begin
		select_input_1 = 4'h4;//esp�̎w���A�h���X�o�X
        end else if (ope[15:8] == 8'hc3) begin
		select_input_1 = 4'h4;//esp�̎w���A�h���X�o�X
        end else if (ope[15:8] == 8'he2) begin
		select_input_1 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
        end else if (ope[15:8] == 8'h6a) begin
		select_input_1 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
        end else begin
		select_input_1 = 4'hx;
        end;

//	case(ope)//ALU�̓��͂ɂ͂ǂ̃��W�X�^�̏o�͂��g����2���ߖ�
//		8'h55: select_input_1 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
//		8'h89: select_input_1 = 4'h2;//esp
//		8'hb8: select_input_1 = 4'h3;//immidiate data
//		8'h5d: select_input_1 = 4'h4;//esp�̎w���A�h���X�o�X
//		8'hc3: select_input_1 = 4'h4;//esp�̎w���A�h���X�o�X
//		8'he2: select_input_1 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
//		8'h6a: select_input_1 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
////		8'h8b: select_input_1 = 4'h3;
//		default select_input_1 = 4'hx;
//	endcase
end
endfunction

function [3:0] load_reg_2;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		load_reg_2 = 4'h1;//esp�̎w���A�h���X�o�X
        end else if (ope[15:8] == 8'h89) begin
		load_reg_2 = 4'hx;//
        end else if (ope[15:8] == 8'h5d) begin
		load_reg_2 = 4'h2;//esp
        end else if (ope[15:8] == 8'hc3) begin
		load_reg_2 = 4'h2;//eip
        end else if (ope[15:8] == 8'he2) begin
		load_reg_2 = 4'h1;//esp�̎w���A�h���X�o�X
        end else if (ope[15:8] == 8'h6a) begin
		load_reg_2 = 4'h1;//esp�̎w���A�h���X�o�X
        end else begin
		load_reg_2 = 4'hx;
        end;

//	case(ope)//ALU�̏o�͂��ǂ̃��W�X�^�ɓ��͂��邩2���ߖ�
//		8'h55: load_reg_2 = 4'h1;//esp�̎w���A�h���X�o�X
//		8'h89: load_reg_2 = 4'hx;//
//		8'h5d: load_reg_2 = 4'h2;//esp
//		8'hc3: load_reg_2 = 4'h2;//eip
//		8'he2: load_reg_2 = 4'h1;//esp�̎w���A�h���X�o�X
//		8'h6a: load_reg_2 = 4'h1;//esp�̎w���A�h���X�o�X
//		default load_reg_2 = 4'hx;
//	endcase
end
endfunction

function [3:0] select_input_2;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		select_input_2 = 4'h1;//ebp
        end else if (ope[15:8] == 8'h89) begin
		select_input_2 = 4'hx;//
        end else if (ope[15:8] == 8'h5d) begin
		select_input_2 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
        end else if (ope[15:8] == 8'hc3) begin
		select_input_2 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
        end else if (ope[15:8] == 8'he2) begin
		select_input_2 = 4'h3;//eip
        end else if (ope[15:8] == 8'h6a) begin
		select_input_2 = 4'h4;//immidiate data
        end else begin
		select_input_2 = 4'hx;
        end;


//	case(ope)//ALU�̓��͂ɂ͂ǂ̃��W�X�^�̏o�͂��g����2���ߖ�
//		8'h55: select_input_2 = 4'h1;//ebp
//		8'h89: select_input_2 = 4'hx;//
//		8'h5d: select_input_2 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
//		8'hc3: select_input_2 = 4'h2;//�Œ�l�H(�X�^�b�N�ړ������A�h���X)
//		8'he2: select_input_2 = 4'h3;//eip
//		8'h6a: select_input_2 = 4'h4;//immidiate data
//		default select_input_2 = 4'hx;
//	endcase
end
endfunction

function [3:0] load_reg_3;
input [15:0]ope;
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
input [15:0]ope;
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
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		calc_ope = 4'h1;
        end else if (ope[15:8] == 8'h89) begin
		calc_ope = 4'h2;
        end else if (ope[15:8] == 8'hb8) begin
		calc_ope = 4'h5;
        end else if (ope[15:8] == 8'h5d) begin
		calc_ope = 4'h1;
        end else if (ope[15:8] == 8'hc3) begin
		calc_ope = 4'h1;
        end else if (ope[15:8] == 8'he2) begin
		calc_ope = 4'h5;
        end else if (ope[15:8] == 8'h6a) begin
		calc_ope = 4'h2;
        end else begin
		calc_ope = 4'hx;
        end;
//	case(ope)
//		8'h55: calc_ope = 4'h1;
//		8'h89: calc_ope = 4'h2;
//		8'hb8: calc_ope = 4'h5;
//		8'h5d: calc_ope = 4'h1;
//		8'hc3: calc_ope = 4'h1;
//		8'he2: calc_ope = 4'h5;
//		8'h6a: calc_ope = 4'h2;
//		default calc_ope = 4'hx;
//	endcase
end
endfunction
endmodule


