module eip_register(clock_5, reset, read_or_write, write_data, eip);
input wire clock_5;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]eip;
//クロックを入れないと、read_or_writeが切り替わったら勝手に書き換えてしまう。

always @(*)begin
	if (reset == 1'b1) begin
		eip <= 32'h00000000;//ここで初期値のアドレスを入れる。
	end
end

always @(clock_5)begin//2クロック目はここに足す
	if (read_or_write == 4'h4) begin
		eip <= write_data;
	end
end



endmodule

