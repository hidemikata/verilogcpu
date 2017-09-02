module esp_register(reset,read_or_write, write_data, esp);
input wire reset;
input wire read_or_write;
input wire [7:0]write_data;
input wire clk1;
output reg [7:0]esp;

always @(posedge reset)begin
	if (reset == 1'b1) begin
		esp <= 8'b1111_11111;//スタックの最大アドレス。
	end
	else begin
		if (read_or_write == 1'b1) begin
			esp <= write_data;
		end
	end
end



endmodule

