module eip_register(clock_4, clock_8, clock_12, num_of_ope, reset, read_or_write, write_data, eip);
input wire clock_4;
input wire clock_8;
input wire clock_12;
input wire [3:0]num_of_ope;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]eip;
//�N���b�N�����Ȃ��ƁAread_or_write���؂�ւ�����珟��ɏ��������Ă��܂��B

always @(*)begin
	if (reset == 1'b1) begin
		eip <= 32'h0000000b;//�����ŏ����l�̃A�h���X������B
	end
end

always @(negedge clock_4)begin//2�N���b�N�ڂ͂����ɑ���
	if (read_or_write == 4'h4) begin
		eip <= write_data;
	end
end

//always @(negedge clock_6)begin
//	if (read_or_write == 4'h4) begin
//		eip <= write_data;
//	end
//end
always @(negedge clock_8)begin
	if (read_or_write == 4'h4) begin
		eip <= write_data;
	end
end


//���̖��ߗp�ɃC���N�������g���邯�ǂ����ł�邩�����B
always @(posedge clock_12)begin
	//�W�����v���߂̎��ǂ��Ȃ邩�l���邱�ƁB
	if (num_of_ope == 4'd1) begin
		eip <= eip + 1;
	end
	else if (num_of_ope == 4'd2) begin
		eip <= eip + 2;
	end
	else if (num_of_ope == 4'd4) begin
		eip <= eip + 4;
	end
	else if (num_of_ope == 4'd5) begin
		eip <= eip + 5;
	end
end




endmodule

