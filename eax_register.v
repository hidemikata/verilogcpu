module eax_register(clock_4, clock_6,reset, read_or_write, write_data, eax);
input wire clock_4;
input wire clock_6;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]eax;


always @(posedge reset or posedge clock_4 or posedge clock_6)begin
	if (reset == 1'b1) begin
		eax <= 32'h0000_0999;//デバッグで999にしてる。
	end else if (clock_4) begin
		if (read_or_write == 4'h3) begin
			eax <= write_data;
		end
	end else if (clock_6) begin
		if (read_or_write == 4'h3) begin
			eax <= write_data;
		end
	end
end


//always @(*)begin
//	if (reset == 1'b1) begin
//		eax <= 32'h0000_0999;//デバッグで999にしてる。
//	end
//end
//always @(posedge clock_4)begin
//	if (read_or_write == 4'h3) begin
//		eax <= write_data;
//	end
//end
//always @(clock_6)begin
//	if (read_or_write == 4'h3) begin
//		eax <= write_data;
//	end
//end
//

endmodule
