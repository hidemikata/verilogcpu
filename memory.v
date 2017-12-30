module program_memory(reset, addr, ope);
input wire reset;
input wire [31:0]addr;
output wire [31:0]ope;
reg [7:0]mem[0:255];//8bit 256��

assign ope = {mem[addr+0], mem[addr+1], mem[addr+2], mem[addr+3]};

always @(posedge reset)begin
	if (reset == 1'b1) begin
		mem[0] <= 8'h55;//�K��
		mem[1] <= 8'h89;//�K��89
		mem[2] <= 8'hb8;//�K��
		mem[3] <= 8'h02;//�K��
		mem[4] <= 8'h00;//�K��
		mem[5] <= 8'h00;//�K��
		mem[6] <= 8'h00;//�K��
		mem[7] <= 8'h5d;//�K��
		                      
		mem[8] <= 8'hc3;//�K��
		mem[9] <= 8'he8;//�K��
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

