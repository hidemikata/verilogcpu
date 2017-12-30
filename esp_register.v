module esp_register(clock_5, reset,read_or_write, alu_result_bus, esp);
input wire clock_5;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]alu_result_bus;
input wire clk1;
output reg [31:0]esp;

always @(posedge reset)begin
	if (reset == 1'b1) begin
		esp <= 32'h00000000;//本当は全部fだが、0からインクリするようにする
	end
end
always @(clock_5)begin//2クロック目はここに足す
	if (read_or_write == 4'h1) begin
		esp <= alu_result_bus;
	end
end

//NIY
//always @(clock_5)begin
//	if (read_or_write == 4'h1) begin
//		esp <= alu_result_bus;
//	end
//end


endmodule

