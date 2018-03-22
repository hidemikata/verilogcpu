module esp_register(clock_4, clock_6, clock_8, reset,read_or_write, alu_result_bus, esp);
input wire clock_4;
input wire clock_6;
input wire clock_8;
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
always @(negedge clock_4)begin
	if (read_or_write == 4'h1) begin
		esp <= alu_result_bus;
	end
end

always @(clock_6)begin
	if (read_or_write == 4'h2) begin
		esp <= alu_result_bus;
	end
end

always @(clock_8)begin
	if (read_or_write == 4'h2) begin
		esp <= alu_result_bus;
	end
end



endmodule

