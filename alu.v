module alu(clock_4, clock_6, clock_8, ope, immidiate_data, registor_in, alu_result_bus);
input clock_4;
input clock_6;
input clock_8;
input [31:0]ope;
input [31:0]immidiate_data;
input [31:0]registor_in;
output reg [31:0]alu_result_bus;
wire [7:0]ope_31_24;
assign ope_31_24 = ope[31:24];

always @(posedge clock_4) begin
	if (ope_31_24 == 8'h55) begin 
		//1��ڂ̖���sub esp, 0xZZ
		//esp�̃A�h���X���P�o�C�g��Ɉړ�������
		alu_result_bus <= registor_in + 32'h1;//�{���̓}�C�i�X�����v���X�Ŏ����B
	end
	if (ope_31_24 == 8'h89) begin 
		alu_result_bus <= registor_in;
	end
	if (ope_31_24 == 8'hb8) begin 
		alu_result_bus <= {8'h00, ope[7:0], ope[15:8], ope[23:16]};
	end
	if (ope_31_24 == 8'h5d) begin 
		alu_result_bus <= registor_in;
		//pop��1�T�C�N���� mov ebp, [esp]
	end
	if (ope_31_24 == 8'hc3) begin 
		alu_result_bus <= registor_in - 32'h1;//�C���N�������̂�-1���Ă���
		//ret (pop.eip)�B
	end
	if (ope_31_24 == 8'he8) begin 
		alu_result_bus <= registor_in + 32'h1;//�{���̓}�C�i�X�����v���X�Ŏ����B
	end
end

always @(posedge clock_6) begin
	if (ope_31_24 == 8'h55) begin 
		alu_result_bus <= registor_in;
	end
	if (ope_31_24 == 8'h89) begin 
		//2�T�C�N���ڂȂ�
	end
	if (ope_31_24 == 8'hb8) begin 
		alu_result_bus <= 32'h3;
	end
	if (ope_31_24 == 8'h5d) begin 
		alu_result_bus <= registor_in - 32'h1;
		//pop.ebp�B
	end
	if (ope_31_24 == 8'hc3) begin 
		alu_result_bus <= registor_in - 32'h1;
		//ret (pop.eip)�B
	end
	if (ope_31_24 == 8'he8) begin 
		alu_result_bus <= registor_in;
	end
end

always @(posedge clock_8) begin
	if (ope_31_24 == 8'he8) begin 
		alu_result_bus <= 32'h0;//�v���O������2�̕����ƌ��݂�registor_in(eip)�̒l�𑫂��Ăǂ�����������������ɓ����B��{8'h00, ope[7:0], ope[15:8], ope[23:16]};
	end
end



endmodule
