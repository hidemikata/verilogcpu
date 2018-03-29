module stack_memory(clock_4, clock_6, reset, read_or_write, write_data, esp, stack_addr, stack_current, stack_addr_access,stack_esp);
input wire clock_4;
input wire clock_6;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
input wire [31:0]esp;//アドレス
input wire [31:0]stack_addr;//アドレス
output reg [31:0]stack_current;
output reg [31:0]stack_addr_access;
output wire [31:0]stack_esp;
reg [7:0]mem[0:255];//8bit 256個

always @(*)begin
	if (reset == 1'b1) begin
		stack_current <= 32'h0000_0000;
		stack_addr_access <= 32'h0000_0000;
	end
end

always @(negedge clock_4)begin//1クロック目
//	if (read_or_write == 4'h2) begin
//		//espのアドレスのところに書く。
//		stack_current <= write_data;
//		mem[esp] <= write_data;
//	end
end

always @(negedge clock_6)begin//2クロック目
	if (read_or_write == 4'h1) begin
		//espのアドレスのところに書く。
		stack_current <= write_data;
//		mem[esp] <= write_data;
		{mem[esp + 3],mem[esp + 2], mem[esp + 1],mem[esp]} <= write_data;
	end
end

assign stack_esp = {mem[esp+3],mem[esp+2],mem[esp+1],mem[esp]};

always @(*)begin
	stack_addr_access <= {mem[stack_addr+3], mem[stack_addr+2], mem[stack_addr+1], mem[stack_addr]};
end

always @(posedge reset)begin
	if (reset == 1'b1) begin
		mem[0] <= 8'h1;
		mem[1] <= 8'h0;
		mem[2] <= 8'h0;
		mem[3] <= 8'h0;
		mem[4] <= 8'h2;
		mem[5] <= 8'h0;
		mem[6] <= 8'h0;
		mem[7] <= 8'h0;
		mem[8] <= 8'h3;
		mem[9] <= 8'h0;
		mem[10] <= 8'h0;
		mem[11] <= 8'h0;
		mem[12] <= 8'h4;
		mem[13] <= 8'h0;
		mem[14] <= 8'h0;
		mem[15] <= 8'h0;
		mem[16] <= 8'h5;
		mem[17] <= 8'h0;
		mem[18] <= 8'h0;
		mem[19] <= 8'h0;
		mem[20] <= 8'h6;
		mem[21] <= 8'h0;
		mem[22] <= 8'h0;
		mem[23] <= 8'h0;
		mem[24] <= 8'h7;
		mem[25] <= 8'h0;
		mem[26] <= 8'h0;
		mem[27] <= 8'h0;
		mem[28] <= 8'h8;
		mem[29] <= 8'h0;
		mem[30] <= 8'h0;
		mem[31] <= 8'h0;
		mem[32] <= 8'h9;
		mem[33] <= 8'h0;
		mem[34] <= 8'h0;
		mem[35] <= 8'h0;
		mem[36] <= 8'ha;
		mem[37] <= 8'h0;
		mem[38] <= 8'h0;
		mem[39] <= 8'h0;
		mem[40] <= 8'hb;
		mem[41] <= 8'h0;
		mem[42] <= 8'h0;
		mem[43] <= 8'h0;
		mem[44] <= 8'hc;
		mem[45] <= 8'h0;
		mem[46] <= 8'h0;
		mem[47] <= 8'h0;
		mem[48] <= 8'hd;
		mem[49] <= 8'h0;
		mem[50] <= 8'h0;
		mem[51] <= 8'h0;
		mem[52] <= 8'he;
		mem[53] <= 8'h0;
		mem[54] <= 8'h0;
		mem[55] <= 8'h0;
		mem[56] <= 8'hf;
		mem[57] <= 8'h0;
		mem[58] <= 8'h0;
		mem[59] <= 8'h0;
		mem[60] <= 8'h0;
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
