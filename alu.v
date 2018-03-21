module alu(clock_4, clock_6, clock_8, ope, immidiate_data, registor_in, num_of_ope,  alu_result_bus);
input clock_4;
input clock_6;
input clock_8;
input [31:0]ope;
input [31:0]immidiate_data;
input [31:0]registor_in;
input [3:0]num_of_ope;
output reg [31:0]alu_result_bus;
wire [31:0]ope_31_24;
wire [31:0]ope_23_16;
wire [31:0]ope_15_08;
wire [31:0]ope_07_00;
wire [31:0]debug3;
wire [31:0]debug3a;
wire [31:0]debug2;
wire [31:0]debug2a;
wire [31:0]debug1;
wire [31:0]debug1a;
wire [31:0]a;

assign ope_31_24 = ope[31:24];
assign ope_23_16 = ope[23:16];
assign ope_15_08 = ope[15:8];
assign ope_07_00 = ope[7:1];
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
	if (ope_31_24 == 8'he2) begin 
		alu_result_bus <= registor_in + 32'h1;//�{���̓}�C�i�X�����v���X�Ŏ����B
	end
	if (ope_31_24 == 8'he8) begin 
		alu_result_bus <= registor_in + 32'h1;//�{���̓}�C�i�X�����v���X�Ŏ����B
	end
	if (ope_31_24 == 8'h6a) begin 
		alu_result_bus <= registor_in + 32'h1;//�{���̓}�C�i�X�����v���X�Ŏ����B
	end
	if (ope_31_24 == 8'h8b) begin 
		alu_result_bus <= registor_in - (ope_15_08/4); //4:4��32bit//ebp�̒l�Ɉړ�����|�C���^�̒l�������B�����B
	end
	if (ope_31_24 == 8'h83) begin 
		if (ope_23_16 == 8'he8) begin
			alu_result_bus <= registor_in - ope[15:8];
		end
		if (ope_23_16 == 8'hc4) begin
			alu_result_bus <= registor_in + (ope[15:8]/4);//esp�ւ̑����4�ł��B
		end
	end
end

always @(posedge clock_6) begin
	if (ope_31_24 == 8'h55) begin 
		alu_result_bus <= registor_in;
	end
	if (ope_31_24 == 8'h89) begin 
		//2�T�C�N���ڂȂ�
	end
	if (ope_31_24 == 8'h5d) begin 
		alu_result_bus <= registor_in - 32'h1;
		//pop.ebp�B
	end
	if (ope_31_24 == 8'hc3) begin 
		alu_result_bus <= registor_in - 32'h1;
		//ret (pop.eip)�B
	end
	if (ope_31_24 == 8'he2) begin 
		//alu_result_bus <= registor_in;//�����݂�eip��push����ł���
		//�ꂾ�Ɩ߂��Ă����Ƃ���call�̂Ƃ���ɖ߂��Ă���Ȃ̂�ope�̂�
		//�������������Ă����B
		alu_result_bus <= registor_in + num_of_ope;
	end
	if (ope_31_24 == 8'he8) begin 
		//alu_result_bus <= registor_in;//�����݂�eip��push����ł���
		//�ꂾ�Ɩ߂��Ă����Ƃ���call�̂Ƃ���ɖ߂��Ă���Ȃ̂�ope�̂�
		//�������������Ă����B
		alu_result_bus <= registor_in + num_of_ope;
	end
	if (ope_31_24 == 8'h6a) begin 
		alu_result_bus <= {8'h00, 8'h00, 8'h00, ope[23:16]};
	end
	if (ope_31_24 == 8'h8b) begin 
		alu_result_bus <= registor_in;//Mod/Rm�łƂꂽ�l�����̂܂܏o�́B
	end
end

always @(posedge clock_8) begin
	if (ope_31_24 == 8'he2) begin 
		alu_result_bus <= (registor_in + num_of_ope) - ({8'h00 , ~ope[7:0], ~ope[15:8], ~ope[23:16]} + 1) -5;
		//�v���O������2�̕����ƌ��݂�registor_in(eip)�̒l�𑫂��Ăǂ�����������������ɓ����B��;
		//eeff->ffee->ee->1110,1110->2�̕␔->00010010->0x12�B0x12��call�̎���
		//���߁B�Ȃ̂�call�̎��̖��߂Ƃ���������Z����0�Ԓn�ɔ�Ԃ���
		//register_in eip
		//-5��call���߂�5�Ȃ̂�5�������Ă����B
		//
	end
	if (ope_31_24 == 8'he8) begin 
		alu_result_bus <= (registor_in + num_of_ope) - ({8'h00 , ~ope[7:0], ~ope[15:8], ~ope[23:16]} + 1) -5;
		//�v���O������2�̕����ƌ��݂�registor_in(eip)�̒l�𑫂��Ăǂ�����������������ɓ����B��;
		//eeff->ffee->ee->1110,1110->2�̕␔->00010010->0x12�B0x12��call�̎���
		//���߁B�Ȃ̂�call�̎��̖��߂Ƃ���������Z����0�Ԓn�ɔ�Ԃ���
		//register_in eip
		//-5��call���߂�5�Ȃ̂�5�������Ă����B
		//
	end
end
assign debug2 = ({8'h00 , ~ope[7:0], ~ope[15:8], ~ope[23:16]} + 1);
assign debug2a = registor_in;
assign debug1 =  num_of_ope + ({8'h00 , ~ope[7:0], ~ope[15:8], ~ope[23:16]} + 1);
assign debug1a = (registor_in + num_of_ope) - ({8'h00 , ~ope[7:0], ~ope[15:8], ~ope[23:16]} + 1);
assign a = alu_result_bus;
//00000015,00000010,00000006,00000014,0000000f
endmodule
