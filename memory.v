module program_memory(reset, addr, ope);
input wire reset;
input wire [31:0]addr;
output wire [31:0]ope;
reg [7:0]mem[0:255];//8bit 256ŒÂ

assign ope = {mem[addr+0], mem[addr+1], mem[addr+2], mem[addr+3]};

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
		mem[19] <= 8'hFF;
		mem[19] <= 8'h83;
		mem[19] <= 8'hC4;
		mem[19] <= 8'h04;
		mem[19] <= 8'hC9;
		mem[19] <= 8'hC3;
	end
end

endmodule

