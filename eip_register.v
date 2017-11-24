module eip_register(reset,read_or_write, write_data, eip);
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]eip;

always @(*)begin
	if (reset == 1'b1) begin
		eip <= 0;
	end
	else begin
		if (read_or_write == 4'h3) begin
			eip <= write_data;
		end
	end
end
endmodule

