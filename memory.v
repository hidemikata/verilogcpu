module program_memory(reset, addr, ope);
input wire reset;
input wire [31:0]addr;
output wire [31:0]ope;
reg [7:0]mem[0:255];//8bit 256個

assign ope = {mem[addr+0], mem[addr+1], mem[addr+2], mem[addr+3]};

always @(posedge reset)begin
	if (reset == 1'b1) begin
		mem[0] <= 8'h55;//適当
		mem[1] <= 8'h89;//適当89
		mem[2] <= 8'he5;//適当
		mem[3] <= 8'hb8;//適当
		mem[4] <= 8'h02;//適当
		mem[5] <= 8'h00;//適当
		mem[6] <= 8'h00;//適当
		mem[7] <= 8'h00;//適当
		mem[8] <= 8'h5d;//適当
		                      
		mem[9] <= 8'hc3;//適当
		mem[10] <= 8'h55;//適当
		mem[11] <= 8'h89;
		mem[12] <= 8'he5;
		         
		mem[13] <= 8'he2;
		mem[14] <= 8'h18;
		mem[15] <= 8'hee;
		mem[16] <= 8'hff;
		         
		mem[17] <= 8'hff;
		mem[18] <= 8'hff;
		mem[19] <= 8'h5d;
		mem[20] <= 8'hc3;
	end
end

endmodule

