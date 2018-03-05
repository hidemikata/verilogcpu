module alu(clock_4, clock_6, clock_8, ope, immidiate_data, registor_in, alu_result_bus);
input clock_4;
input clock_6;
input clock_8;
input [31:0]ope;
input [31:0]immidiate_data;
input [31:0]registor_in;
output reg [31:0]alu_result_bus;
wire [7:0]ope_31_24;
assign ope_31_24 = ope[31:24];

always @(posedge clock_4) begin
	if (ope_31_24 == 8'h55) begin 
		//1回目の命令sub esp, 0xZZ
		//espのアドレスを１バイト上に移動させる
		alu_result_bus <= registor_in + 32'h1;//本当はマイナスだがプラスで実装。
	end
	if (ope_31_24 == 8'h89) begin 
		alu_result_bus <= registor_in;
	end
	if (ope_31_24 == 8'hb8) begin 
		alu_result_bus <= {8'h00, ope[7:0], ope[15:8], ope[23:16]};
	end
	if (ope_31_24 == 8'h5d) begin 
		alu_result_bus <= registor_in;
		//popの1サイクル目 mov ebp, [esp]
	end
	if (ope_31_24 == 8'hc3) begin 
		alu_result_bus <= registor_in - 32'h1;//インクリされるので-1しておく
		//ret (pop.eip)。
	end
	if (ope_31_24 == 8'he2) begin 
		alu_result_bus <= registor_in + 32'h1;//本当はマイナスだがプラスで実装。
	end
end

always @(posedge clock_6) begin
	if (ope_31_24 == 8'h55) begin 
		alu_result_bus <= registor_in;
	end
	if (ope_31_24 == 8'h89) begin 
		//2サイクル目なし
	end
	if (ope_31_24 == 8'hb8) begin 
		alu_result_bus <= 32'h3;
	end
	if (ope_31_24 == 8'h5d) begin 
		alu_result_bus <= registor_in - 32'h1;
		//pop.ebp。
	end
	if (ope_31_24 == 8'hc3) begin 
		alu_result_bus <= registor_in - 32'h1;
		//ret (pop.eip)。
	end
	if (ope_31_24 == 8'he2) begin 
		alu_result_bus <= registor_in;
	end
end

always @(posedge clock_8) begin
	if (ope_31_24 == 8'he2) begin 
		alu_result_bus <= registor_in + {8'h00, ~ope[7:0], ~ope[15:8], ~ope[23:16]} + 1;
		//プログラムの2の歩数と現在のregistor_in(eip)の値を足してどうこうしたやつをここに入れる。と;
	end
end



endmodule
