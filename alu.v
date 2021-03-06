module alu(clock_4, clock_6, clock_8, ope, immidiate_data, registor_in, num_of_ope,  alu_result_bus, zero, eax);
input clock_4;
input clock_6;
input clock_8;
input [31:0]ope;
input [31:0]immidiate_data;
input [31:0]registor_in;
input [3:0]num_of_ope;
input [31:0]zero;
input [31:0]eax;
output reg [31:0]alu_result_bus;
wire [31:0]ope_31_24;
wire [31:0]ope_23_16;
wire [31:0]ope_15_08;
wire [31:0]ope_07_00;
wire [31:0]debug3;
wire [31:0]debug3a;
wire [31:0]debug2;
wire [31:0]debug2a;
wire [7:0]debug1;
wire [31:0]debug1a;
wire [31:0]a;

assign ope_31_24 = ope[31:24];
assign ope_23_16 = ope[23:16];
assign ope_15_08 = ope[15:8];
assign ope_07_00 = ope[7:1];


always @(posedge clock_4 or posedge clock_6 or posedge clock_8) begin
	if (clock_4) begin
		if (ope_31_24 == 8'h55) begin 
			//1回目の命令sub esp, 0xZZ
			//espのアドレスを１バイト上に移動させる
			alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
		end
		if (ope_31_24 == 8'h50) begin 
			//1回目の命令sub esp, 0xZZ
			//espのアドレスを１バイト上に移動させる
			alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
		end
		if (ope_31_24 == 8'h53) begin 
			alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
		end
		if (ope_31_24 == 8'h85) begin 
			alu_result_bus <= registor_in & registor_in;//AND演算
		end
		if (ope_31_24 == 8'h89) begin 
			if (ope_23_16 == 8'he5) begin
				alu_result_bus <= registor_in;
			end else if (ope_23_16 == 8'hc3) begin
				alu_result_bus <= registor_in;
			end else if (ope_23_16 == 8'h45) begin
	
				if(ope[15:15] == 1'b1) begin
						alu_result_bus <= registor_in + {8'h00,8'h00,8'h00, (~ope[15:8] + 8'h01)};
				end else begin
						alu_result_bus <= registor_in - (ope_15_08);
				end
			end else  begin
				//なし
			end
		end
		if (ope_31_24 == 8'hb8) begin 
			alu_result_bus <= {8'h00, ope[7:0], ope[15:8], ope[23:16]};
		end
		if (ope_31_24 == 8'h5d) begin 
			alu_result_bus <= registor_in;
			//popの1サイクル目 mov ebp, [esp]
		end
		if (ope_31_24 == 8'hc3) begin 
			alu_result_bus <= registor_in - 32'h1;//eipがインクリされるので-1しておく
			//ret (pop.eip)。
		end
		if (ope_31_24 == 8'he8) begin 
			alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
		end
		if (ope_31_24 == 8'h6a) begin 
			alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
		end
		if (ope_31_24 == 8'h8b) begin 
			if(ope[15:15] == 1'b1) begin
					alu_result_bus <= registor_in + {8'h00,8'h00,8'h00, (~ope[15:8] + 8'h01)}; //4:4で32bit//ebpの値に移動するポインタの値を引く。足す。
			end else begin
					alu_result_bus <= registor_in - (ope_15_08); //4:4で32bit//ebpの値に移動するポインタの値を引く。足す。
			end
		end
		if (ope_31_24 == 8'h83) begin 
			if (ope_23_16 == 8'he8) begin
				alu_result_bus <= registor_in - ope[15:8];
			end
			if (ope_23_16 == 8'hc4) begin
				alu_result_bus <= registor_in - (ope[15:8]);//espへの代入は4でわる。しかもスタックがーと＋がちがうので逆にする。
			end
			if (ope_23_16 == 8'hec) begin
				alu_result_bus <= registor_in + (ope[15:8]);//espへの代入は4でわる。しかもスタックがーと＋がちがうので逆にする。
			end
			if (ope_23_16 == 8'h7d) begin
				alu_result_bus <= registor_in - (ope[15:8]);//espへの代入は4でわる。しかもスタックがーと＋がちがうので逆にする。
			end
			if (ope_23_16 == 8'hf8) begin
				alu_result_bus <= registor_in - (ope[15:8]);
			end
		end
		if (ope_31_24 == 8'hc9) begin 
			alu_result_bus <= registor_in;
		end
		if (ope_31_24 == 8'h75) begin 
			if (zero == 8'h00) begin
				alu_result_bus <= registor_in + ope_23_16;
			end else begin
				alu_result_bus <= registor_in;
			end
		end
		if (ope_31_24 == 8'h74) begin 
			if (zero == 8'h01) begin
				alu_result_bus <= registor_in + ope_23_16;
			end else begin
				alu_result_bus <= registor_in;
			end
		end
		if (ope_31_24 == 8'heb) begin
			alu_result_bus <= registor_in + ope_23_16;
		end
		if (ope_31_24 == 8'h01) begin 
			alu_result_bus <= registor_in + eax;
		end
	end else if (clock_6) begin
		if (ope_31_24 == 8'h55) begin 
			alu_result_bus <= registor_in;
		end
		if (ope_31_24 == 8'h50) begin 
			alu_result_bus <= registor_in;
		end
		if (ope_31_24 == 8'h53) begin 
			alu_result_bus <= registor_in;
		end
		if (ope_31_24 == 8'h89) begin
			if (ope_23_16 == 8'h45) begin
				alu_result_bus <= registor_in;
			end
			//2サイクル目なし
		end
		if (ope_31_24 == 8'h5d) begin 
			alu_result_bus <= registor_in - 32'h4;
			//pop.ebp。
		end
		if (ope_31_24 == 8'h85) begin 
			alu_result_bus <= registor_in & registor_in;//不要だがzeroフラグが落ちるので同じ2回目も演算をする。
		end
		if (ope_31_24 == 8'hc3) begin 
			alu_result_bus <= registor_in - 32'h4;
			//ret (pop.eip)。
		end
		if (ope_31_24 == 8'he8) begin 
			//alu_result_bus <= registor_in;//←現在のeipをpushするでもこ
			//れだと戻ってきたときにcallのところに戻ってくるなのでopeのな
			//がさだけ足しておく。
			alu_result_bus <= registor_in + num_of_ope;
		end
		if (ope_31_24 == 8'h6a) begin 
			alu_result_bus <= {8'h00, 8'h00, 8'h00, ope[23:16]};
		end
		if (ope_31_24 == 8'h8b) begin 
			alu_result_bus <= registor_in;//Mod/Rmでとれた値をそのまま出力。
		end
		if (ope_31_24 == 8'hc9) begin 
			alu_result_bus <= registor_in;
		end
		if (ope_31_24 == 8'h83) begin 
			if (ope_23_16 == 8'h7d) begin
				alu_result_bus <= registor_in - ope_07_00;
			end
		end
	end else if (clock_8) begin
		if (ope_31_24 == 8'he8) begin 
			alu_result_bus <= (registor_in + num_of_ope) - ({8'h00 , ~ope[7:0], ~ope[15:8], ~ope[23:16]} + 1) -5;
			//プログラムの2の歩数と現在のregistor_in(eip)の値を足してどうこうしたやつをここに入れる。と;
			//eeff->ffee->ee->1110,1110->2の補数->00010010->0x12。0x12はcallの次の
			//命令。なのでcallの次の命令とこれを引き算して0番地に飛ぶこと
			//register_in eip
			//-5はcall命令が5なので5分引いておく。
			//
		end
		if (ope_31_24 == 8'hc9) begin 
			alu_result_bus <= registor_in - 32'h4;
		end
	end
end



//--------------


//
//always @(posedge clock_4) begin
//	if (ope_31_24 == 8'h55) begin 
//		//1回目の命令sub esp, 0xZZ
//		//espのアドレスを１バイト上に移動させる
//		alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
//	end
//	if (ope_31_24 == 8'h50) begin 
//		//1回目の命令sub esp, 0xZZ
//		//espのアドレスを１バイト上に移動させる
//		alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
//	end
//	if (ope_31_24 == 8'h53) begin 
//		alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
//	end
//	if (ope_31_24 == 8'h85) begin 
//		alu_result_bus <= registor_in & registor_in;//AND演算
//	end
//	if (ope_31_24 == 8'h89) begin 
//		if (ope_23_16 == 8'he5) begin
//			alu_result_bus <= registor_in;
//		end else if (ope_23_16 == 8'hc3) begin
//			alu_result_bus <= registor_in;
//		end else if (ope_23_16 == 8'h45) begin
//
//			if(ope[15:15] == 1'b1) begin
//					alu_result_bus <= registor_in + {8'h00,8'h00,8'h00, (~ope[15:8] + 8'h01)};
//			end else begin
//					alu_result_bus <= registor_in - (ope_15_08);
//			end
//		end else  begin
//			//なし
//		end
//	end
//	if (ope_31_24 == 8'hb8) begin 
//		alu_result_bus <= {8'h00, ope[7:0], ope[15:8], ope[23:16]};
//	end
//	if (ope_31_24 == 8'h5d) begin 
//		alu_result_bus <= registor_in;
//		//popの1サイクル目 mov ebp, [esp]
//	end
//	if (ope_31_24 == 8'hc3) begin 
//		alu_result_bus <= registor_in - 32'h1;//eipがインクリされるので-1しておく
//		//ret (pop.eip)。
//	end
//	if (ope_31_24 == 8'he8) begin 
//		alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
//	end
//	if (ope_31_24 == 8'h6a) begin 
//		alu_result_bus <= registor_in + 32'h4;//本当はマイナスだがプラスで実装。
//	end
//	if (ope_31_24 == 8'h8b) begin 
//		if(ope[15:15] == 1'b1) begin
//				alu_result_bus <= registor_in + {8'h00,8'h00,8'h00, (~ope[15:8] + 8'h01)}; //4:4で32bit//ebpの値に移動するポインタの値を引く。足す。
//		end else begin
//				alu_result_bus <= registor_in - (ope_15_08); //4:4で32bit//ebpの値に移動するポインタの値を引く。足す。
//		end
//	end
//	if (ope_31_24 == 8'h83) begin 
//		if (ope_23_16 == 8'he8) begin
//			alu_result_bus <= registor_in - ope[15:8];
//		end
//		if (ope_23_16 == 8'hc4) begin
//			alu_result_bus <= registor_in - (ope[15:8]);//espへの代入は4でわる。しかもスタックがーと＋がちがうので逆にする。
//		end
//		if (ope_23_16 == 8'hec) begin
//			alu_result_bus <= registor_in + (ope[15:8]);//espへの代入は4でわる。しかもスタックがーと＋がちがうので逆にする。
//		end
//		if (ope_23_16 == 8'h7d) begin
//			alu_result_bus <= registor_in - (ope[15:8]);//espへの代入は4でわる。しかもスタックがーと＋がちがうので逆にする。
//		end
//		if (ope_23_16 == 8'hf8) begin
//			alu_result_bus <= registor_in - (ope[15:8]);
//		end
//	end
//	if (ope_31_24 == 8'hc9) begin 
//		alu_result_bus <= registor_in;
//	end
//	if (ope_31_24 == 8'h75) begin 
//		if (zero == 8'h00) begin
//			alu_result_bus <= registor_in + ope_23_16;
//		end else begin
//			alu_result_bus <= registor_in;
//		end
//	end
//	if (ope_31_24 == 8'h74) begin 
//		if (zero == 8'h01) begin
//			alu_result_bus <= registor_in + ope_23_16;
//		end else begin
//			alu_result_bus <= registor_in;
//		end
//	end
//	if (ope_31_24 == 8'heb) begin
//		alu_result_bus <= registor_in + ope_23_16;
//	end
//	if (ope_31_24 == 8'h01) begin 
//		alu_result_bus <= registor_in + eax;
//	end
//end
//
//always @(posedge clock_6) begin
//	if (ope_31_24 == 8'h55) begin 
//		alu_result_bus <= registor_in;
//	end
//	if (ope_31_24 == 8'h50) begin 
//		alu_result_bus <= registor_in;
//	end
//	if (ope_31_24 == 8'h53) begin 
//		alu_result_bus <= registor_in;
//	end
//	if (ope_31_24 == 8'h89) begin
//		if (ope_23_16 == 8'h45) begin
//			alu_result_bus <= registor_in;
//		end
//		//2サイクル目なし
//	end
//	if (ope_31_24 == 8'h5d) begin 
//		alu_result_bus <= registor_in - 32'h4;
//		//pop.ebp。
//	end
//	if (ope_31_24 == 8'h85) begin 
//		alu_result_bus <= registor_in & registor_in;//不要だがzeroフラグが落ちるので同じ2回目も演算をする。
//	end
//	if (ope_31_24 == 8'hc3) begin 
//		alu_result_bus <= registor_in - 32'h4;
//		//ret (pop.eip)。
//	end
//	if (ope_31_24 == 8'he8) begin 
//		//alu_result_bus <= registor_in;//←現在のeipをpushするでもこ
//		//れだと戻ってきたときにcallのところに戻ってくるなのでopeのな
//		//がさだけ足しておく。
//		alu_result_bus <= registor_in + num_of_ope;
//	end
//	if (ope_31_24 == 8'h6a) begin 
//		alu_result_bus <= {8'h00, 8'h00, 8'h00, ope[23:16]};
//	end
//	if (ope_31_24 == 8'h8b) begin 
//		alu_result_bus <= registor_in;//Mod/Rmでとれた値をそのまま出力。
//	end
//	if (ope_31_24 == 8'hc9) begin 
//		alu_result_bus <= registor_in;
//	end
//	if (ope_31_24 == 8'h83) begin 
//		if (ope_23_16 == 8'h7d) begin
//			alu_result_bus <= registor_in - ope_07_00;
//		end
//	end
//end
//
//always @(posedge clock_8) begin
//	if (ope_31_24 == 8'he8) begin 
//		alu_result_bus <= (registor_in + num_of_ope) - ({8'h00 , ~ope[7:0], ~ope[15:8], ~ope[23:16]} + 1) -5;
//		//プログラムの2の歩数と現在のregistor_in(eip)の値を足してどうこうしたやつをここに入れる。と;
//		//eeff->ffee->ee->1110,1110->2の補数->00010010->0x12。0x12はcallの次の
//		//命令。なのでcallの次の命令とこれを引き算して0番地に飛ぶこと
//		//register_in eip
//		//-5はcall命令が5なので5分引いておく。
//		//
//	end
//	if (ope_31_24 == 8'hc9) begin 
//		alu_result_bus <= registor_in - 32'h4;
//	end
//end
assign debug2 = alu_result_bus;
assign debug2a = registor_in;
assign debug1 =  ope_15_08;
assign debug1a = {8'h00,8'h00,8'h00, (~ope[15:8] + 8'h01)};//ope_15_08};//((~ope_15_08) + 8'h01)};
assign a = registor_in - {8'h00,8'h00,8'h00, (~ope[15:8] + 8'h01)};
//00000015,00000010,00000006,00000014,0000000f
endmodule
