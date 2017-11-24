module alu(clock_5, ope, immidiate_data, registor_in, alu_result_bus);
//clock_5でいいか不明。
input clock_5;
input [31:0]ope;
input [31:0]immidiate_data;
input [7:0]registor_in;
output reg [31:0]alu_result_bus;

always @(posedge clock_5) begin
	if (ope == 8'h55) begin 
		//1回目の命令sub esp, 0xZZ
		alu_result_bus <= 32'h1;//registor_in - 8'h01;//addressの値を1引く。1は8bit
	end
	if (ope == 8'h89) begin 
		alu_result_bus <= 32'h2;//registor_in;
	end
	if (ope == 8'hb8) begin 
		alu_result_bus <= 32'h3;
	end
	if (ope == 8'h5d) begin 
		alu_result_bus <= 32'h4;
		//pop.ebp。
	end
	if (ope == 8'hc3) begin 
		alu_result_bus <= 32'h5;
		//ret (pop.eip)。
	end
	if (ope == 8'he8) begin 
		alu_result_bus <= 32'h6;
		//call xxx pop.eip。
	end
end


endmodule
