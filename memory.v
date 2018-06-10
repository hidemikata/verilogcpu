module program_memory(reset, addr, ope);
input wire reset;
input wire [31:0]addr;
output wire [31:0]ope;
reg [7:0]mem[0:128];//8bit 256個

assign ope = {mem[addr+0], mem[addr+1], mem[addr+2], mem[addr+3]};

//int fib(){
//	return 2;
//}
//int func(){
//	fib();
//}


//eip <= 32'h0000000a;//ここで初期値のアドレスを入れる。
//always @(posedge reset)begin
//	if (reset == 1'b1) begin
//		mem[0]  <= 8'h55;
//		mem[1]  <= 8'h89;
//		mem[2]  <= 8'hE5;
//		mem[3]  <= 8'hB8;
//		mem[4]  <= 8'h02;
//		mem[5]  <= 8'h00;
//		mem[6]  <= 8'h00;
//		mem[7]  <= 8'h00;
//		mem[8]  <= 8'h5D;
//		mem[9]  <= 8'hC3;
//		mem[10] <= 8'h55;
//		mem[11] <= 8'h89;
//		mem[12] <= 8'hE5;
//		mem[13] <= 8'hE8;
//		mem[14] <= 8'hEE;
//		mem[15] <= 8'hFF;
//		mem[16] <= 8'hFF;
//		mem[17] <= 8'h5D;
//		mem[18] <= 8'hC3;
//	end          
//end

//int fib(int n){
//return n-1;
//}
//int func() {
//	return fib(10);
//}
//
//eip <= 32'h0000000b;//ここで初期値のアドレスを入れる。
//always @(posedge reset)begin
//	if (reset == 1'b1) begin
//		mem[0]  <= 8'h55;
//		mem[1]  <= 8'h89;
//		mem[2]  <= 8'hE5;
//		mem[3]  <= 8'h8B;
//		mem[4]  <= 8'h45;
//		mem[5]  <= 8'h08;
//		mem[6]  <= 8'h83;
//		mem[7]  <= 8'hE8;
//		mem[8]  <= 8'h01;
//		mem[9]  <= 8'h5D;
//		mem[10] <= 8'hC3;
//		mem[11] <= 8'h55;
//		mem[12] <= 8'h89;
//		mem[13] <= 8'hE5;
//		mem[14] <= 8'h6A;
//		mem[15] <= 8'h0A;
//		mem[16] <= 8'hE8;
//		mem[17] <= 8'hEB;
//		mem[18] <= 8'hFF;
//		mem[19] <= 8'hFF;
//		mem[20] <= 8'hFF;
//		mem[21] <= 8'h83;
//		mem[22] <= 8'hC4;
//		mem[23] <= 8'h04;
//		mem[24] <= 8'hC9;
//		mem[25] <= 8'hC3;
//	end
//end
//
//
//int fib(int n){
//if(n == 0){
//	return 1;
//}
//return fib(n-1) + fib(n-1);
//}
//int func() {
//	return fib(5);
//}
//		eip <= 32'h00000041;//ここで初期値のアドレスを入れる。
//always @(posedge reset)begin
//	if (reset == 1'b1) begin
//mem[0] <=8'h55;
//mem[1] <=8'h89;
//mem[2] <=8'hE5;
//mem[3] <=8'h53;
//mem[4] <=8'h83;
//mem[5] <=8'hEC;
//mem[6] <=8'h04;
//mem[7] <=8'h83;
//mem[8] <=8'h7D;
//mem[9] <=8'h08;
//mem[10] <=8'h00;
//mem[11] <=8'h75;
//mem[12] <=8'h07;
//mem[13] <=8'hB8;
//mem[14] <=8'h01;
//mem[15] <=8'h00;
//mem[16] <=8'h00;
//mem[17] <=8'h00;
//mem[18] <=8'hEB;
//mem[19] <=8'h28;
//mem[20] <=8'h8B;
//mem[21] <=8'h45;
//mem[22] <=8'h08;
//mem[23] <=8'h83;
//mem[24] <=8'hE8;
//mem[25] <=8'h01;
//mem[26] <=8'h83;
//mem[27] <=8'hEC;
//mem[28] <=8'h0C;
//mem[29] <=8'h50;
//mem[30] <=8'hE8;
//mem[31] <=8'hDD;
//mem[32] <=8'hFF;
//mem[33] <=8'hFF;
//mem[34] <=8'hFF;
//mem[35] <=8'h83;
//mem[36] <=8'hC4;
//mem[37] <=8'h10;
//mem[38] <=8'h89;
//mem[39] <=8'hC3;
//mem[40] <=8'h8B;
//mem[41] <=8'h45;
//mem[42] <=8'h08;
//mem[43] <=8'h83;
//mem[44] <=8'hE8;
//mem[45] <=8'h01;
//mem[46] <=8'h83;
//mem[47] <=8'hEC;
//mem[48] <=8'h0C;
//mem[49] <=8'h50;
//mem[50] <=8'hE8;
//mem[51] <=8'hC9;
//mem[52] <=8'hFF;
//mem[53] <=8'hFF;
//mem[54] <=8'hFF;
//mem[55] <=8'h83;
//mem[56] <=8'hC4;
//mem[57] <=8'h10;
//mem[58] <=8'h01;
//mem[59] <=8'hD8;
//mem[60] <=8'h8B;
//mem[61] <=8'h5D;
//mem[62] <=8'hFC;
//mem[63] <=8'hC9;
//mem[64] <=8'hC3;
//mem[65] <=8'h55;
//mem[66] <=8'h89;
//mem[67] <=8'hE5;
//mem[68] <=8'h83;
//mem[69] <=8'hEC;
//mem[70] <=8'h08;
//mem[71] <=8'h83;
//mem[72] <=8'hEC;
//mem[73] <=8'h0C;
//mem[74] <=8'h6A;
//mem[75] <=8'h05;
//mem[76] <=8'hE8;
//mem[77] <=8'hAF;
//mem[78] <=8'hFF;
//mem[79] <=8'hFF;
//mem[80] <=8'hFF;
//mem[81] <=8'h83;
//mem[82] <=8'hC4;
//mem[83] <=8'h10;
//mem[84] <=8'hC9;
//mem[85] <=8'hC3;
//
//
//	end
//end
//
//int fib(int n){
//if(n == 0){
//	return 5;
//}
//return fib(n-1);
//}
//int func() {
//	return fib(3);
//}
////答え5
//}
//eip <= 32'h0000000b;//ここで初期値のアドレスを入れる。
//		eip <= 32'h00000027;//ここで初期値のアドレスを入れる。
//always @(posedge reset)begin
//	if (reset == 1'b1) begin
//mem[0] <=8'h55;        
//mem[1] <=8'h89;
//mem[2] <=8'hE5;      
//mem[3] <=8'h83;
//mem[4] <=8'hEC;
//mem[5] <=8'h08;    
//mem[6] <=8'h83;
//mem[7] <=8'h7D;
//mem[8] <=8'h08;
//mem[9] <=8'h00;  
//mem[10] <=8'h75;
//mem[11] <=8'h07;      
//mem[12] <=8'hB8;
//mem[13] <=8'h05;
//mem[14] <=8'h00;
//mem[15] <=8'h00;
//mem[16] <=8'h00;
//mem[17] <=8'hEB;
//mem[18] <=8'h12;      
//mem[19] <=8'h8B;
//mem[20] <=8'h45;
//mem[21] <=8'h08;    
//mem[22] <=8'h83;
//mem[23] <=8'hE8;
//mem[24] <=8'h01;    
//mem[25] <=8'h83;
//mem[26] <=8'hEC;
//mem[27] <=8'h0C;    
//mem[28] <=8'h50;        
//mem[29] <=8'hE8;
//mem[30] <=8'hDE;
//mem[31] <=8'hFF;
//mem[32] <=8'hFF;
//mem[33] <=8'hFF;
//mem[34] <=8'h83;
//mem[35] <=8'hC4;
//mem[36] <=8'h10;    
//mem[37] <=8'hC9;        
//mem[38] <=8'hC3;        
//mem[39] <=8'h55;        
//mem[40] <=8'h89;
//mem[41] <=8'hE5;      
//mem[42] <=8'h83;
//mem[43] <=8'hEC;
//mem[44] <=8'h08;    
//mem[45] <=8'h83;
//mem[46] <=8'hEC;
//mem[47] <=8'h0C;    
//mem[48] <=8'h6A;
//mem[49] <=8'h03;      
//mem[50] <=8'hE8;
//mem[51] <=8'hC9;
//mem[52] <=8'hFF;
//mem[53] <=8'hFF;
//mem[54] <=8'hFF;
//mem[55] <=8'h83;
//mem[56] <=8'hC4;
//mem[57] <=8'h10;    
//mem[58] <=8'hC9;        
//mem[59] <=8'hC3;        
//	end
//end

//
//int fib(int n){
//	switch(n){
//		case 0: return 0;
//		case 1: return 1;
//		default:
//			return fib(n-2)+fib(n-1);
//	}
//}
//int func() {
//	int ans = fib(20);
//	return ans;
//}
//
//eip <= 32'h00000050;//ここで初期値のアドレスを入れる。
always @(posedge reset)begin
	if (reset == 1'b1) begin

mem[0] <=8'h55;
mem[1] <=8'h89;
mem[2] <=8'hE5;
mem[3] <=8'h53;
mem[4] <=8'h83;
mem[5] <=8'hEC;
mem[6] <=8'h04;
mem[7] <=8'h8B;
mem[8] <=8'h45;
mem[9] <=8'h08;
mem[10] <=8'h85;
mem[11] <=8'hC0;
mem[12] <=8'h74;
mem[13] <=8'h07;
mem[14] <=8'h83;
mem[15] <=8'hF8;
mem[16] <=8'h01;
mem[17] <=8'h74;
mem[18] <=8'h09;
mem[19] <=8'hEB;
mem[20] <=8'h0E;
mem[21] <=8'hB8;
mem[22] <=8'h00;
mem[23] <=8'h00;
mem[24] <=8'h00;
mem[25] <=8'h00;
mem[26] <=8'hEB;
mem[27] <=8'h2F;
mem[28] <=8'hB8;
mem[29] <=8'h01;
mem[30] <=8'h00;
mem[31] <=8'h00;
mem[32] <=8'h00;
mem[33] <=8'hEB;
mem[34] <=8'h28;
mem[35] <=8'h8B;
mem[36] <=8'h45;
mem[37] <=8'h08;
mem[38] <=8'h83;
mem[39] <=8'hE8;
mem[40] <=8'h02;
mem[41] <=8'h83;
mem[42] <=8'hEC;
mem[43] <=8'h0C;
mem[44] <=8'h50;
mem[45] <=8'hE8;
mem[46] <=8'hCE;
mem[47] <=8'hFF;
mem[48] <=8'hFF;
mem[49] <=8'hFF;
mem[50] <=8'h83;
mem[51] <=8'hC4;
mem[52] <=8'h10;
mem[53] <=8'h89;
mem[54] <=8'hC3;
mem[55] <=8'h8B;
mem[56] <=8'h45;
mem[57] <=8'h08;
mem[58] <=8'h83;
mem[59] <=8'hE8;
mem[60] <=8'h01;
mem[61] <=8'h83;
mem[62] <=8'hEC;
mem[63] <=8'h0C;
mem[64] <=8'h50;
mem[65] <=8'hE8;
mem[66] <=8'hBA;
mem[67] <=8'hFF;
mem[68] <=8'hFF;
mem[69] <=8'hFF;
mem[70] <=8'h83;
mem[71] <=8'hC4;
mem[72] <=8'h10;
mem[73] <=8'h01;
mem[74] <=8'hD8;
mem[75] <=8'h8B;
mem[76] <=8'h5D;
mem[77] <=8'hFC;
mem[78] <=8'hC9;
mem[79] <=8'hC3;
mem[80] <=8'h55;
mem[81] <=8'h89;
mem[82] <=8'hE5;
mem[83] <=8'h83;
mem[84] <=8'hEC;
mem[85] <=8'h18;
mem[86] <=8'h83;
mem[87] <=8'hEC;
mem[88] <=8'h0C;
mem[89] <=8'h6A;
mem[90] <=8'h07;//初期値16進数
mem[91] <=8'hE8;
mem[92] <=8'hA0;
mem[93] <=8'hFF;
mem[94] <=8'hFF;
mem[95] <=8'hFF;
mem[96] <=8'h83;
mem[97] <=8'hC4;
mem[98] <=8'h10;
mem[99] <=8'h89;
mem[100] <=8'h45;
mem[101] <=8'hF4;
mem[102] <=8'h8B;
mem[103] <=8'h45;
mem[104] <=8'hF4;
mem[105] <=8'hC9;
mem[106] <=8'hC3;

end
end
endmodule


