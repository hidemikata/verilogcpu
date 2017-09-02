module eip_register(reset,read_or_write, write_data, eip);
input wire reset;
input wire read_or_write;
input wire [7:0]write_data;
output reg [7:0]eip;

always @(*)begin
	if (reset == 1'b1) begin
		eip <= 8'b0000_0000;
	end
	else begin
		if (read_or_write == 1'b1) begin
			eip <= write_data;
		end
	end
end
endmodule

