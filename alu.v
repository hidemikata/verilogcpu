module alu(clock_4, clock_6, clock_8, ope, immidiate_data, registor_in, num_of_ope,  alu_result_bus);
input clock_4;
input clock_6;
input clock_8;
input [31:0]ope;
input [31:0]immidiate_data;
input [31:0]registor_in;
input [3:0]num_of_ope;
output reg [31:0]alu_result_bus;
wire [31:0]ope_31_24;
wire [31:0]debug3;
wire [31:0]debug3a;
wire [31:0]debug2;
wire [31:0]debug2a;
wire [31:0]debug1;
wire [31:0]debug1a;
wire [31:0]a;

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
	if (ope_31_24 == 8'h6a) begin 
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
	if (ope_31_24 == 8'h5d) begin 
		alu_result_bus <= registor_in - 32'h1;
		//pop.ebp。
	end
	if (ope_31_24 == 8'hc3) begin 
		alu_result_bus <= registor_in - 32'h1;
		//ret (pop.eip)。
	end
	if (ope_31_24 == 8'he2) begin 
		//alu_result_bus <= registor_in;//←現在のeipをpushするでもこ
		//れだと戻ってきたときにcallのところに戻ってくるなのでopeのな
		//がさだけ足しておく。
		alu_result_bus <= registor_in + num_of_ope;
	end
	if (ope_31_24 == 8'h6a) begin 
		alu_result_bus <= {8'h00, 8'h00, 8'h00, ope[23:16]};
	end
end

always @(posedge clock_8) begin
	if (ope_31_24 == 8'he2) begin 
		alu_result_bus <= (registor_in + num_of_ope) - ({8'h00, 8'h00, ~ope[7:0], ~ope[15:8]} + 1) -5;
		//プログラムの2の歩数と現在のregistor_in(eip)の値を足してどうこうしたやつをここに入れる。と;
		//eeff->ffee->ee->1110,1110->2の補数->00010010->0x12。0x12はcallの次の
		//命令。なのでcallの次の命令とこれを引き算して0番地に飛ぶこと
		//register_in eip
		//-5はcall命令が5なので5分引いておく。
		//
	end
end
assign debug2 = ({8'h00, 8'h00, ~ope[7:0], ~ope[15:8]} + 1);
assign debug2a = registor_in;
assign debug1 =  num_of_ope + ({8'h00, 8'h00, ~ope[7:0], ~ope[15:8]} + 1);
assign debug1a = (registor_in + num_of_ope) - ({8'h00, 8'h00, ~ope[7:0], ~ope[15:8]} + 1);
assign a = alu_result_bus;

endmodule
