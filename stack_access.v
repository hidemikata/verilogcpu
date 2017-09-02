module stack_reader_writer(reset, read_or_write, write_data, stack_connect_address, clock_6, stack_data);
input reset;
input read_or_write;
input write_data;
input stack_connect_address,
input clock_6
output wire [31:0]stack_data;

stack_memory stack_memory(1'h0, read_or_write, stack_connect_address, write_data, stack_data, clock_6);


//always @(posedge reset or posedge clk1)begin
//	if (reset == 1'b1) begin
//		eip <= 8'b0000_0000;
//	end
//	else begin
//		if (read_or_write == 1'b1) begin
//			eip <= write_data;
//		end
//	end
//	
//end


endmodule
