module eip_register(clock_5, reset, read_or_write, write_data, eip);
input wire clock_5;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]eip;
//�N���b�N�����Ȃ��ƁAread_or_write���؂�ւ�����珟��ɏ��������Ă��܂��B

always @(*)begin
	if (reset == 1'b1) begin
		eip <= 32'h00000000;//�����ŏ����l�̃A�h���X������B
	end
end

always @(clock_5)begin//2�N���b�N�ڂ͂����ɑ���
	if (read_or_write == 4'h4) begin
		eip <= write_data;
	end
end



endmodule

