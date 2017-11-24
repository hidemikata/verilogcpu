module ebp_register(reset, read_or_write, write_data, ebp);
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]ebp;

always @(*)begin
	if (reset == 1'b1) begin
		ebp <= 0;
	end
	else begin
		if (read_or_write == 4'h2) begin
			ebp <= write_data;
		end
	end
end

endmodule
