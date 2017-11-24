module esp_register(clock_5, reset,read_or_write, write_data, esp);
input wire clock_5;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
input wire clk1;
output reg [31:0]esp;

always @(posedge reset)begin
	if (reset == 1'b1) begin
		esp <= 32'hfffff;//�X�^�b�N�̍ő�A�h���X�B
	end
end
always @(posedge clock_5)begin//2�N���b�N�ڂ͂����ɑ���
	if (read_or_write == 4'h2) begin
		esp <= write_data;
	end
end
endmodule

