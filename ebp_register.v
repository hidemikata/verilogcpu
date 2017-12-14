module ebp_register(clock_5, reset, read_or_write, write_data, ebp);
input wire clock_5;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]ebp;

always @(*)begin
	if (reset == 1'b1) begin
		ebp <= 32'h0000_0000;
	end
end
always @(clock_5)begin//2クロック目はここに足す
	if (read_or_write == 4'h2) begin
		ebp <= write_data;
	end
end

endmodule
