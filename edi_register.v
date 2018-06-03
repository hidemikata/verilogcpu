module edi_register(clock_4, clock_6, reset, read_or_write, write_data, edi);
input wire clock_4;
input wire clock_6;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]edi;

always @(*)begin
	if (reset == 1'b1) begin
		edi <= 32'h0000_0888;
	end
end
always @(posedge clock_6)begin
	if (read_or_write == 4'h6) begin
		edi <= write_data;
	end
end

endmodule
