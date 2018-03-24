module program_memory(reset, addr, ope);
input wire reset;
input wire [31:0]addr;
output wire [31:0]ope;
reg [7:0]mem[0:255];//8bit 256個

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
always @(posedge reset)begin
	if (reset == 1'b1) begin
		mem[0]  <= 8'h55;
		mem[1]  <= 8'h89;
		mem[2]  <= 8'hE5;
		mem[3]  <= 8'h8B;
		mem[4]  <= 8'h45;
		mem[5]  <= 8'h08;
		mem[6]  <= 8'h83;
		mem[7]  <= 8'hE8;
		mem[8]  <= 8'h01;
		mem[9]  <= 8'h5D;
		mem[10] <= 8'hC3;
		mem[11] <= 8'h55;
		mem[12] <= 8'h89;
		mem[13] <= 8'hE5;
		mem[14] <= 8'h6A;
		mem[15] <= 8'h0A;
		mem[16] <= 8'hE8;
		mem[17] <= 8'hEB;
		mem[18] <= 8'hFF;
		mem[19] <= 8'hFF;
		mem[20] <= 8'hFF;
		mem[21] <= 8'h83;
		mem[22] <= 8'hC4;
		mem[23] <= 8'h04;
		mem[24] <= 8'hC9;
		mem[25] <= 8'hC3;
	end
end

endmodule

