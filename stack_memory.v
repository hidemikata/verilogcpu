module stack_memory(clock_5, clock_7, reset, read_or_write, write_data, esp, stack);
input wire clock_5;
input wire clock_7;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
input wire [31:0]esp;//アドレス
output reg [31:0]stack;
reg [31:0]mem[0:31];//8bit 256個

always @(*)begin
	if (reset == 1'b1) begin
		stack <= 32'h0000_0000;
	end
end
always @(clock_5)begin//1クロック目
//	if (read_or_write == 4'h2) begin
//		//espのアドレスのところに書く。
//		stack <= write_data;
//		mem[esp] <= write_data;
//	end
end

always @(clock_7)begin//2クロック目
	if (read_or_write == 4'h1) begin
		//espのアドレスのところに書く。
		stack <= write_data;
		mem[esp] <= write_data;
	end
end



always @(posedge reset)begin
	if (reset == 1'b1) begin
		mem[0] <= 32'h00;
		mem[1] <= 32'h00;
		mem[2] <= 32'h00;
		mem[3] <= 32'h00;
		mem[4] <= 32'h00;
		mem[5] <= 32'h00;
		mem[6] <= 32'h00;
		mem[7] <= 32'h00;
		mem[8] <= 32'h00;
		mem[9] <= 32'h00;
		mem[10] <= 32'h00;
		mem[11] <= 32'h00;
		mem[12] <= 32'h00;
		mem[13] <= 32'h00;
		mem[14] <= 32'h00;
		mem[15] <= 32'h00;
		mem[16] <= 32'h00;
		mem[17] <= 32'h00;
		mem[18] <= 32'h00;
		mem[19] <= 32'h00;
		mem[20] <= 32'h00;
		mem[21] <= 32'h00;
		mem[22] <= 32'h00;
		mem[23] <= 32'h00;
		mem[24] <= 32'h00;
		mem[25] <= 32'h00;
		mem[26] <= 32'h00;
		mem[27] <= 32'h00;
		mem[28] <= 32'h00;
		mem[29] <= 32'h00;
		mem[30] <= 32'h00;
		mem[31] <= 32'h00;
	end
end

endmodule

//module stack_memory(reset, read_or_write, addr, data, clock_6);
//input wire reset;
//input wire read_or_write;
//input wire [7:0]addr;
//input wire [31:0]data;
//output wire [31:0]out_data;
//reg [7:0]mem[0:255];//8bit 256個
//
////read
//assign out_data = {mem[addr+0], mem[addr+1], mem[addr+2], mem[addr+3]};
//
//always @(*)begin
//	if (read_or_write == 1'b1) begin
//		//write
//		mem[addr+0] <= [0:7]data;
//		mem[addr+1] <= [8:15]data;
//		mem[addr+2] <= [16:23]data;
//		mem[addr+3] <= [24:31]data;
//	end
//end
//
//always @(posedge reset)begin
//	if (reset == 1'b1) begin
//		mem[0] <= 8'h00;
//		mem[1] <= 8'h00;
//		mem[2] <= 8'h00;
//		mem[3] <= 8'h00;
//		mem[4] <= 8'h00;
//		mem[5] <= 8'h00;
//		mem[6] <= 8'h00;
//		mem[7] <= 8'h00;
//		                      
//		mem[8] <= 8'h00;
//		mem[9] <= 8'h00;
//		mem[10] <= 8'h00;
//		mem[11] <= 8'h00;
//		          
//		mem[12] <= 8'h00;
//		mem[13] <= 8'h00;
//		mem[14] <= 8'h00;
//		mem[15] <= 8'h00;
//		          
//		mem[16] <= 8'h00;
//		mem[17] <= 8'h00;
//		mem[18] <= 8'h00;
//		mem[19] <= 8'h00;
//	end
//end
//
//endmodule
//
