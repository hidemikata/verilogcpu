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
reg [7:0]mem[0:256];//8bit 512個

always @(*)begin
	stack_addr_access <= {mem[stack_addr+3], mem[stack_addr+2], mem[stack_addr+1], mem[stack_addr]};
	if (reset == 1'b1) begin
		stack_current <= 32'h0000_0000;
		stack_addr_access <= 32'h0000_0000;
		mem[0] <= 8'hx;
		mem[1] <= 8'hx;
		mem[2] <= 8'hx;
		mem[3] <= 8'hx;
		mem[4] <= 8'hx;
		mem[5] <= 8'hx;
		mem[6] <= 8'hx;
		mem[7] <= 8'hx;
		mem[8] <= 8'hx;
		mem[9] <= 8'hx;
		mem[10] <= 8'hx;
		mem[11] <= 8'hx;
		mem[12] <= 8'hx;
		mem[13] <= 8'hx;
		mem[14] <= 8'hx;
		mem[15] <= 8'hx;
		mem[16] <= 8'hx;
		mem[17] <= 8'hx;
		mem[18] <= 8'hx;
		mem[19] <= 8'hx;
		mem[20] <= 8'hx;
		mem[21] <= 8'hx;
		mem[22] <= 8'hx;
		mem[23] <= 8'hx;
		mem[24] <= 8'hx;
		mem[25] <= 8'hx;
		mem[26] <= 8'hx;
		mem[27] <= 8'hx;
		mem[28] <= 8'hx;
		mem[29] <= 8'hx;
		mem[30] <= 8'hx;
		mem[31] <= 8'hx;
		mem[32] <= 8'hx;
		mem[33] <= 8'hx;
		mem[34] <= 8'hx;
		mem[35] <= 8'hx;
		mem[36] <= 8'hx;
		mem[37] <= 8'hx;
		mem[38] <= 8'hx;
		mem[39] <= 8'hx;
		mem[40] <= 8'hx;
		mem[41] <= 8'hx;
		mem[42] <= 8'hx;
		mem[43] <= 8'hx;
		mem[44] <= 8'hx;
		mem[45] <= 8'hx;
		mem[46] <= 8'hx;
		mem[47] <= 8'hx;
		mem[48] <= 8'hx;
		mem[49] <= 8'hx;
		mem[50] <= 8'hx;
		mem[51] <= 8'hx;
		mem[52] <= 8'hx;
		mem[53] <= 8'hx;
		mem[54] <= 8'hx;
		mem[55] <= 8'hx;
		mem[56] <= 8'hx;
		mem[57] <= 8'hx;
		mem[58] <= 8'hx;
		mem[59] <= 8'hx;
		mem[60] <= 8'hx;
		mem[61] <= 8'hx;
		mem[62] <= 8'hx;
		mem[63] <= 8'hx;
		mem[64] <= 8'hx;
		mem[65] <= 8'hx;
		mem[66] <= 8'hx;
		mem[67] <= 8'hx;
		mem[68] <= 8'hx;
		mem[69] <= 8'hx;
		mem[70] <= 8'hx;
		mem[71] <= 8'hx;
		mem[72] <= 8'hx;
		mem[73] <= 8'hx;
		mem[74] <= 8'hx;
		mem[75] <= 8'hx;
		mem[76] <= 8'hx;
		mem[77] <= 8'hx;
		mem[78] <= 8'hx;
		mem[79] <= 8'hx;
		mem[80] <= 8'hx;
		mem[81] <= 8'hx;
		mem[82] <= 8'hx;
		mem[83] <= 8'hx;
		mem[84] <= 8'hx;
		mem[85] <= 8'hx;
		mem[86] <= 8'hx;
		mem[87] <= 8'hx;
		mem[88] <= 8'hx;
		mem[89] <= 8'hx;
		mem[90] <= 8'hx;
		mem[91] <= 8'hx;
		mem[92] <= 8'hx;
		mem[93] <= 8'hx;
		mem[94] <= 8'hx;
		mem[95] <= 8'hx;
		mem[96] <= 8'hx;
		mem[97] <= 8'hx;
		mem[98] <= 8'hx;
		mem[99] <= 8'hx;
		mem[100] <= 8'hx;
	end else if (clock_6) begin
		if (read_or_write == 4'h1) begin
			stack_current <= write_data;
			{mem[esp + 3],mem[esp + 2], mem[esp + 1],mem[esp]} <= write_data;
		end else if (read_or_write == 4'h8) begin
			{mem[stack_addr + 3],mem[stack_addr + 2], mem[stack_addr + 1],mem[stack_addr]} <= write_data;
		end
	end
end

assign stack_esp = {mem[esp+3],mem[esp+2],mem[esp+1],mem[esp]};
	
//always @(*)begin
//	if (reset == 1'b1) begin
//		stack_current <= 32'h0000_0000;
//		stack_addr_access <= 32'h0000_0000;
//	end
//end
//
//always @(posedge clock_6)begin//2クロック目
//	if (read_or_write == 4'h1) begin
//		stack_current <= write_data;
//		{mem[esp + 3],mem[esp + 2], mem[esp + 1],mem[esp]} <= write_data;
//	end else if (read_or_write == 4'h8) begin
//		{mem[stack_addr + 3],mem[stack_addr + 2], mem[stack_addr + 1],mem[stack_addr]} <= write_data;
//	end
//end


//always @(*)begin
//	stack_addr_access <= {mem[stack_addr+3], mem[stack_addr+2], mem[stack_addr+1], mem[stack_addr]};
//end

//always @(posedge reset)begin
//	if (reset == 1'b1) begin
//		mem[0] <= 8'hx;
//		mem[1] <= 8'hx;
//		mem[2] <= 8'hx;
//		mem[3] <= 8'hx;
//		mem[4] <= 8'hx;
//		mem[5] <= 8'hx;
//		mem[6] <= 8'hx;
//		mem[7] <= 8'hx;
//		mem[8] <= 8'hx;
//		mem[9] <= 8'hx;
//		mem[10] <= 8'hx;
//		mem[11] <= 8'hx;
//		mem[12] <= 8'hx;
//		mem[13] <= 8'hx;
//		mem[14] <= 8'hx;
//		mem[15] <= 8'hx;
//		mem[16] <= 8'hx;
//		mem[17] <= 8'hx;
//		mem[18] <= 8'hx;
//		mem[19] <= 8'hx;
//		mem[20] <= 8'hx;
//		mem[21] <= 8'hx;
//		mem[22] <= 8'hx;
//		mem[23] <= 8'hx;
//		mem[24] <= 8'hx;
//		mem[25] <= 8'hx;
//		mem[26] <= 8'hx;
//		mem[27] <= 8'hx;
//		mem[28] <= 8'hx;
//		mem[29] <= 8'hx;
//		mem[30] <= 8'hx;
//		mem[31] <= 8'hx;
//		mem[32] <= 8'hx;
//		mem[33] <= 8'hx;
//		mem[34] <= 8'hx;
//		mem[35] <= 8'hx;
//		mem[36] <= 8'hx;
//		mem[37] <= 8'hx;
//		mem[38] <= 8'hx;
//		mem[39] <= 8'hx;
//		mem[40] <= 8'hx;
//		mem[41] <= 8'hx;
//		mem[42] <= 8'hx;
//		mem[43] <= 8'hx;
//		mem[44] <= 8'hx;
//		mem[45] <= 8'hx;
//		mem[46] <= 8'hx;
//		mem[47] <= 8'hx;
//		mem[48] <= 8'hx;
//		mem[49] <= 8'hx;
//		mem[50] <= 8'hx;
//		mem[51] <= 8'hx;
//		mem[52] <= 8'hx;
//		mem[53] <= 8'hx;
//		mem[54] <= 8'hx;
//		mem[55] <= 8'hx;
//		mem[56] <= 8'hx;
//		mem[57] <= 8'hx;
//		mem[58] <= 8'hx;
//		mem[59] <= 8'hx;
//		mem[60] <= 8'hx;
//		mem[61] <= 8'hx;
//		mem[62] <= 8'hx;
//		mem[63] <= 8'hx;
//		mem[64] <= 8'hx;
//		mem[65] <= 8'hx;
//		mem[66] <= 8'hx;
//		mem[67] <= 8'hx;
//		mem[68] <= 8'hx;
//		mem[69] <= 8'hx;
//		mem[70] <= 8'hx;
//		mem[71] <= 8'hx;
//		mem[72] <= 8'hx;
//		mem[73] <= 8'hx;
//		mem[74] <= 8'hx;
//		mem[75] <= 8'hx;
//		mem[76] <= 8'hx;
//		mem[77] <= 8'hx;
//		mem[78] <= 8'hx;
//		mem[79] <= 8'hx;
//		mem[80] <= 8'hx;
//		mem[81] <= 8'hx;
//		mem[82] <= 8'hx;
//		mem[83] <= 8'hx;
//		mem[84] <= 8'hx;
//		mem[85] <= 8'hx;
//		mem[86] <= 8'hx;
//		mem[87] <= 8'hx;
//		mem[88] <= 8'hx;
//		mem[89] <= 8'hx;
//		mem[90] <= 8'hx;
//		mem[91] <= 8'hx;
//		mem[92] <= 8'hx;
//		mem[93] <= 8'hx;
//		mem[94] <= 8'hx;
//		mem[95] <= 8'hx;
//		mem[96] <= 8'hx;
//		mem[97] <= 8'hx;
//		mem[98] <= 8'hx;
//		mem[99] <= 8'hx;
//		mem[100] <= 8'hx;
//	end
//end
//
endmodule
