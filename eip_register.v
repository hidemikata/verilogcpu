module eip_register(clock_4, clock_6, clock_8, clock_12, num_of_ope, reset, read_or_write, write_data, eip);
input wire clock_4;
input wire clock_6;
input wire clock_8;
input wire clock_12;
input wire [3:0]num_of_ope;
input wire reset;
input wire [3:0]read_or_write;
input wire [31:0]write_data;
output reg [31:0]eip;
//クロックを入れないと、read_or_writeが切り替わったら勝手に書き換えてしまう。


always @(posedge reset or posedge clock_4 or posedge clock_6 or posedge clock_8 or posedge clock_12 )begin
	if (reset == 1'b1) begin
//		eip <= 32'h00000041;
//		eip <= 32'h00000027;
		eip <= 32'h00000050;
	end else if (clock_4) begin
		if (read_or_write == 4'h4) begin
			eip <= write_data;
		end
	end else if (clock_6) begin
		if (read_or_write == 4'h4) begin
			eip <= write_data;
		end
	end else if (clock_8) begin
		if (read_or_write == 4'h4) begin
			eip <= write_data;
		end
	end else if (clock_12) begin
		if (num_of_ope == 4'd1) begin
			eip <= eip + 1;
		end
		else if (num_of_ope == 4'd2) begin
			eip <= eip + 2;
		end
		else if (num_of_ope == 4'd3) begin
			eip <= eip + 3;
		end
		else if (num_of_ope == 4'd4) begin
			eip <= eip + 4;
		end
		else if (num_of_ope == 4'd5) begin
			eip <= eip + 5;
		end
		else if (num_of_ope == 4'd6) begin
			eip <= eip + 6;
		end
	end
end

//always @(*)begin
//	if (reset == 1'b1) begin
////		eip <= 32'h00000041;
////		eip <= 32'h00000027;
//		eip <= 32'h00000050;
//	end
//end
//
//always @(posedge clock_4)begin//2クロック目はここに足す
//	if (read_or_write == 4'h4) begin
//		eip <= write_data;
//	end
//end
//
//always @(posedge clock_6)begin
//	if (read_or_write == 4'h4) begin
//		eip <= write_data;
//	end
//end
//always @(posedge clock_8)begin
//	if (read_or_write == 4'h4) begin
//		eip <= write_data;
//	end
//end
//
//
////次の命令用にインクリメントするけどここでやるか微妙。
//always @(posedge clock_12)begin
//	//ジャンプ命令の時どうなるか考えること。
//	if (num_of_ope == 4'd1) begin
//		eip <= eip + 1;
//	end
//	else if (num_of_ope == 4'd2) begin
//		eip <= eip + 2;
//	end
//	else if (num_of_ope == 4'd3) begin
//		eip <= eip + 3;
//	end
//	else if (num_of_ope == 4'd4) begin
//		eip <= eip + 4;
//	end
//	else if (num_of_ope == 4'd5) begin
//		eip <= eip + 5;
//	end
//	else if (num_of_ope == 4'd6) begin
//		eip <= eip + 6;
//	end
//end
//



endmodule

