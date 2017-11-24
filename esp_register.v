module esp_register(reset,read_or_write, write_data, esp);
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
input wire clk1;
output reg [31:0]esp;

always @(posedge reset)begin
	if (reset == 1'b1) begin
		esp <= 32'hfffff;//スタックの最大アドレス。
	end
	else begin
		if (read_or_write == 4'h2) begin
			esp <= write_data;
		end
	end
end



endmodule

