module zero_register(clock_4, clock_6,reset, read_or_write, write_data, zero);
input wire clock_4;
input wire clock_6;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]zero;

always @(*)begin
	if (reset == 1'b1) begin
		zero <= 32'h0000_0999;//デバッグで999にしてる。
	end
end
always @(posedge clock_4)begin
	if (write_data == 4'h0) begin
		zero <= 1'b1;
	end else begin
		zero <= 1'b0;
	end
end
always @(clock_6)begin
	if (write_data == 4'h0) begin
		zero <= 1'b1;
	end else begin
		zero <= 1'b0;
	end
end


endmodule
