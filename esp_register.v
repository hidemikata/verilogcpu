module esp_register(clock_4, reset,read_or_write, alu_result_bus, esp);
input wire clock_4;
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
always @(negedge clock_4)begin//2クロック目はここに足す
	if (read_or_write == 4'h1) begin
		esp <= alu_result_bus;
	end
end

//NIY
//always @(clock_7)begin
//	if (read_or_write == 4'h1) begin
//		esp <= alu_result_bus;
//	end
//end


endmodule

