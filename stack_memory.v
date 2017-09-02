module stack_memory(reset, read_or_write, addr, data, clock_6);
input wire reset;
input wire read_or_write;
input wire [7:0]addr;
input wire [31:0]data;
output wire [31:0]out_data;
reg [7:0]mem[0:255];//8bit 256ŒÂ

//read
assign out_data = {mem[addr+0], mem[addr+1], mem[addr+2], mem[addr+3]};

always @(*)begin
	if (read_or_write == 1'b1) begin
		//write
		mem[addr+0] <= [0:7]data;
		mem[addr+1] <= [8:15]data;
		mem[addr+2] <= [16:23]data;
		mem[addr+3] <= [24:31]data;
	end
end

always @(posedge reset)begin
	if (reset == 1'b1) begin
		mem[0] <= 8'h00;
		mem[1] <= 8'h00;
		mem[2] <= 8'h00;
		mem[3] <= 8'h00;
		mem[4] <= 8'h00;
		mem[5] <= 8'h00;
		mem[6] <= 8'h00;
		mem[7] <= 8'h00;
		                      
		mem[8] <= 8'h00;
		mem[9] <= 8'h00;
		mem[10] <= 8'h00;
		mem[11] <= 8'h00;
		          
		mem[12] <= 8'h00;
		mem[13] <= 8'h00;
		mem[14] <= 8'h00;
		mem[15] <= 8'h00;
		          
		mem[16] <= 8'h00;
		mem[17] <= 8'h00;
		mem[18] <= 8'h00;
		mem[19] <= 8'h00;
	end
end

endmodule

