module stack_addr_register(clock_4, reset, read_or_write, write_data, stack_addr);
input wire clock_4;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]stack_addr;

always @(*)begin
	if (reset == 1'b1) begin
		stack_addr <= 32'h0000_0999;//デバッグで999にしてる。
	end
end
always @(posedge clock_4)begin
	if (read_or_write == 4'h5) begin
		stack_addr <= write_data;
	end
end

endmodule
