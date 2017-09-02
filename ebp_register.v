module ebp_register(reset, read_or_write, write_data, ebp);
input wire reset;
input wire read_or_write;
input wire [7:0]write_data;
output reg [7:0]ebp;

always @(*)begin
	if (reset == 1'b1) begin
		ebp <= 8'b0000_0000;
	end
	else begin
		if (read_or_write == 1'b1) begin
			ebp <= write_data;
		end
	end
end

endmodule
