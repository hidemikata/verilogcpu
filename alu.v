module alu(clock_5, clock_7, ope, immidiate_data, registor_in, alu_result_bus);
input clock_5;
input clock_7;
input [31:0]ope;
input [31:0]immidiate_data;
input [31:0]registor_in;
output reg [31:0]alu_result_bus;
wire [7:0]ope_31_24;
assign ope_31_24 = ope[31:24];

always @(posedge clock_5) begin
	if (ope_31_24 == 8'h55) begin 
		//1回目の命令sub esp, 0xZZ
		//espのアドレスを１バイト上に移動させる
		alu_result_bus <= registor_in - 8'h01;
	end
	if (ope_31_24 == 8'h89) begin 
		alu_result_bus <= 32'h2;//registor_in;
	end
	if (ope_31_24 == 8'hb8) begin 
		alu_result_bus <= 32'h3;
	end
	if (ope_31_24 == 8'h5d) begin 
		alu_result_bus <= 32'h4;
		//pop.ebp。
	end
	if (ope_31_24 == 8'hc3) begin 
		alu_result_bus <= 32'h5;
		//ret (pop.eip)。
	end
	if (ope_31_24 == 8'he8) begin 
		alu_result_bus <= 32'h6;
		//call xxx pop.eip。
	end
end

always @(posedge clock_7) begin
	if (ope_31_24 == 8'h55) begin 
		//1回目の命令sub esp, 0xZZ
		//espのアドレスを１バイト上に移動させる
		alu_result_bus <= registor_in - 8'h01;
	end
	if (ope_31_24 == 8'h89) begin 
		alu_result_bus <= 32'h2;//registor_in;
	end
	if (ope_31_24 == 8'hb8) begin 
		alu_result_bus <= 32'h3;
	end
	if (ope_31_24 == 8'h5d) begin 
		alu_result_bus <= 32'h4;
		//pop.ebp。
	end
	if (ope_31_24 == 8'hc3) begin 
		alu_result_bus <= 32'h5;
		//ret (pop.eip)。
	end
	if (ope_31_24 == 8'he8) begin 
		alu_result_bus <= 32'h6;
		//call xxx pop.eip。
	end
end



endmodule
