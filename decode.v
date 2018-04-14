module decode(reset, clk2, ope, reg_load_1, select_1, reg_load_2, select_2, reg_load_3, select_3, num_of_ope);
input wire reset;
input wire clk2;
input wire [31:0]ope;
output wire [3:0]reg_load_1;//ALUの出力をどのレジスタに入力するか1命令目
output wire [3:0]select_1;//ALUの入力にはどのレジスタの出力を使うか1命令目
output wire [3:0]reg_load_2;//ALUの出力をどのレジスタに入力するか2命令目
output wire [3:0]select_2;//ALUの入力にはどのレジスタの出力を使うか2命令目
output wire [3:0]reg_load_3;//ALUの出力をどのレジスタに入力するか3命令目
output wire [3:0]select_3;//ALUの入力にはどのレジスタの出力を使うか3命令目
output reg [3:0]num_of_ope;//eipに足し算する値//どこで足し算するか課題
wire [15:0]ope1;//opecode1バイト目//regはfetchが持ってる

assign ope1 = ope[31:16];//上位
 
assign reg_load_1 = load_reg_1(ope1);//ALUの出力先
assign select_1 = select_input_1(ope1);//ALUの入力元
assign reg_load_2 = load_reg_2(ope1);//ALUの出力先
assign select_2 = select_input_2(ope1);//ALUの入力元
assign reg_load_3 = load_reg_3(ope1);//ALUの出力先
assign select_3 = select_input_3(ope1);//ALUの入力元

function [3:0] load_reg_1;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		load_reg_1 = 4'h1;//esp
	end else if (ope[15:8] == 8'h50) begin
		load_reg_1 = 4'h1;//esp
	end else if (ope[15:8] == 8'h53) begin
		load_reg_1 = 4'h1;//esp
	end else if (ope[15:8] == 8'h85) begin
		load_reg_1 = 4'hx;//
        end else if (ope[15:8] == 8'h89) begin
		if ( 8'he5 == ope[7:0] ) begin//1byte
			load_reg_1 = 4'h2;//ebp
		end else if ( 8'hc3 == ope[7:0] )begin
			load_reg_1 = 4'h6;//ebx
		end else if ( 8'h45 == ope[7:0] )begin
			load_reg_1 = 4'h5;//stack_access register
		end 
        end else if (ope[15:8] == 8'hb8) begin
		load_reg_1 = 4'h3;//eax
        end else if (ope[15:8] == 8'h5d) begin
		load_reg_1 = 4'h2;//ebp
        end else if (ope[15:8] == 8'hc3) begin
		load_reg_1 = 4'h4;//eip
        end else if (ope[15:8] == 8'he8) begin
		load_reg_1 = 4'h1;//esp
        end else if (ope[15:8] == 8'h6a) begin
		load_reg_1 = 4'h1;//esp
        end else if (ope[15:8] == 8'h8b) begin
		if ( 8'h40 <=ope[7:0] && ope[7:0] <= 8'h47 ) begin//1byte
			load_reg_1 = 4'h5;//stack_accessレジスタ
		end else if (8'h80 <=ope[7:0] && ope[7:0] <= 8'h87 ) begin//4byte
			load_reg_1 = 4'h5;//stack_accessレジスタ
		end else if (8'h58 <=ope[7:0] && ope[7:0] <= 8'h5f ) begin//4byte
			load_reg_1 = 4'h5;//stack_accessレジスタ
		end else begin
			load_reg_1 = 4'hx;
		end
        end else if (ope[15:8] == 8'h83) begin//sub add
		if ( ope[7:0] == 8'he8) begin//sub
			load_reg_1 = 4'h3;//eax
		end else if ( ope[7:0] == 8'hc4) begin//add
			load_reg_1 = 4'h1;//esp
		end else if ( ope[7:0] == 8'hf8) begin//sub
			load_reg_1 = 4'h3;//eax
		end else if ( ope[7:0] == 8'hec) begin//sub
			load_reg_1 = 4'h1;//esp
		end else if (8'h78 <=ope[7:0] && ope[7:0] <= 8'h7f ) begin//4byte
			load_reg_1 = 4'h5;//stack_accessレジスタ
		end else begin
			load_reg_1 = 4'hx;
		end
        end else if (ope[15:8] == 8'hc9) begin
		load_reg_1 = 4'h1;//esp
        end else if (ope[15:8] == 8'h75) begin
		load_reg_1 = 4'h4;//eip
        end else if (ope[15:8] == 8'h74) begin
		load_reg_1 = 4'h4;//eip
        end else if (ope[15:8] == 8'heb) begin
		load_reg_1 = 4'h4;//eip
        end else if (ope[15:8] == 8'h01) begin
		load_reg_1 = 4'h3;//eax
        end else begin
		load_reg_1 = 4'hx;
        end;
end
endfunction

function [3:0] select_input_1;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		select_input_1 = 4'h2;//固定値？(スタック移動分かアドレス)
	end else if (ope[15:8] == 8'h50) begin
		select_input_1 = 4'h2;//固定値？(スタック移動分かアドレス)
	end else if (ope[15:8] == 8'h53) begin
		select_input_1 = 4'h2;//固定値？(スタック移動分かアドレス)
	end else if (ope[15:8] == 8'h85) begin
		select_input_1 = 4'h2;//eax
        end else if (ope[15:8] == 8'h89) begin
		if ( 8'he5 == ope[7:0] ) begin//1byte
			select_input_1 = 4'h2;//esp
		end else if ( 8'hc3 == ope[7:0] )begin
			select_input_1 = 4'h6;//eax
		end else if ( 8'h45 == ope[7:0] )begin
			select_input_1 = 4'h5;//ebp
		end
        end else if (ope[15:8] == 8'hb8) begin
		select_input_1 = 4'h3;//immidiate data
        end else if (ope[15:8] == 8'h5d) begin
		select_input_1 = 4'h4;//espの指すアドレスバス
        end else if (ope[15:8] == 8'hc3) begin
		select_input_1 = 4'h4;//espの指すアドレスバス
        end else if (ope[15:8] == 8'he8) begin
		select_input_1 = 4'h2;//固定値？(スタック移動分かアドレス)
        end else if (ope[15:8] == 8'h6a) begin
		select_input_1 = 4'h2;//固定値？(スタック移動分かアドレス)
        end else if (ope[15:8] == 8'h8b) begin
		if (ope[7:0] == 8'h45) begin//1byte
			select_input_1 = 4'h5;//ebp
		end else if (ope[7:0] == 8'h5d) begin//1byte
			select_input_1 = 4'h5;//ebp
		end else begin
			select_input_1 = 4'hx;
		end
        end else if (ope[15:8] == 8'h83) begin
		if ( ope[7:0] == 8'he8) begin//sub
			select_input_1 = 4'h6;
		end else if ( ope[7:0] == 8'hc4) begin
			select_input_1 = 4'h2;//esp 
		end else if ( ope[7:0] == 8'hf8) begin
			select_input_1 = 4'h6;//eax
		end else if ( ope[7:0] == 8'hec) begin
			select_input_1 = 4'h2;//esp 
		end else if (8'h78 <=ope[7:0] && ope[7:0] <= 8'h7f ) begin//4byte
			select_input_1 = 4'h5;//ebp
		end else begin
			select_input_1 = 4'hx;
		end
        end else if (ope[15:8] == 8'hc9) begin
		select_input_1 = 4'h5;//ebp
        end else if (ope[15:8] == 8'h75) begin
		select_input_1 = 4'h7;//eip
        end else if (ope[15:8] == 8'h74) begin
		select_input_1 = 4'h7;//eip
        end else if (ope[15:8] == 8'heb) begin
		select_input_1 = 4'h7;//eip
        end else if (ope[15:8] == 8'h01) begin
		select_input_1 = 4'h8;//ebx
        end else begin
		select_input_1 = 4'hx;
        end;

end
endfunction

function [3:0] load_reg_2;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		load_reg_2 = 4'h1;//espの指すアドレスバス
	end else if (ope[15:8] == 8'h50) begin
		load_reg_2 = 4'h1;//espの指すアドレスバス
	end else if (ope[15:8] == 8'h85) begin
		load_reg_2 = 4'hx;//
	end else if (ope[15:8] == 8'h53) begin
		load_reg_2 = 4'h1;//espの指すアドレスバス
        end else if (ope[15:8] == 8'h5d) begin
		load_reg_2 = 4'h2;//esp
        end else if (ope[15:8] == 8'hc3) begin
		load_reg_2 = 4'h2;//esp
        end else if (ope[15:8] == 8'he8) begin
		load_reg_2 = 4'h1;//espの指すアドレスバス
        end else if (ope[15:8] == 8'h6a) begin
		load_reg_2 = 4'h1;//espの指すアドレスバス
        end else if (ope[15:8] == 8'h8b) begin
		if ( 8'h40 <=ope[7:0] && ope[7:0] <= 8'h47 ) begin//1byte
			load_reg_2 = 4'h3;//eax
		end else if (8'h80 <=ope[7:0] && ope[7:0] <= 8'h87 ) begin//4byte
			load_reg_2 = 4'h3;//eax
		end else if (8'h58 <=ope[7:0] && ope[7:0] <= 8'h5f ) begin//4byte
			load_reg_2 = 4'h7;//ebx
		end else begin
			load_reg_2 = 4'hx;
		end
        end else if (ope[15:8] == 8'hc9) begin
		load_reg_2 = 4'h5;//ebp
        end else if (ope[15:8] == 8'h83) begin
		if (8'h78 <=ope[7:0] && ope[7:0] <= 8'h7f ) begin
			load_reg_2 = 4'h6;//edi
		end else begin
			load_reg_2 = 4'hx;
		end
        end else if (ope[15:8] == 8'h89) begin
		if ( 8'h45 == ope[7:0] ) begin//1byte
			load_reg_2 = 4'h8; //stackaccessが指すところ
		end else begin
			load_reg_2 = 4'hx;
		end
        end else begin
		load_reg_2 = 4'hx;
        end;
end
endfunction

function [3:0] select_input_2;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		select_input_2 = 4'h1;//ebp
	end else if (ope[15:8] == 8'h50) begin
		select_input_2 = 4'h8;//eax
	end else if (ope[15:8] == 8'h53) begin
		select_input_2 = 4'h7;//ebx
	end else if (ope[15:8] == 8'h85) begin
		select_input_2 = 4'h8;//eax
        end else if (ope[15:8] == 8'h5d) begin
		select_input_2 = 4'h2;//固定値？(スタック移動分かアドレス)
        end else if (ope[15:8] == 8'hc3) begin
		select_input_2 = 4'h2;//固定値？(スタック移動分かアドレス)
        end else if (ope[15:8] == 8'he8) begin
		select_input_2 = 4'h3;//eip
        end else if (ope[15:8] == 8'h6a) begin
		select_input_2 = 4'h4;//immidiate data
        end else if (ope[15:8] == 8'h8b) begin
		if (ope[7:0] == 8'h45) begin//1byte
			select_input_2 = 4'h6;//stack_addr_access
		end else if (ope[7:0] == 8'h5d) begin//1byte
			select_input_2 = 4'h6;//stack_addr_access
		end else begin
			select_input_2 = 4'hx;
		end
        end else if (ope[15:8] == 8'hc9) begin
		select_input_2 = 4'h5;
        end else if (ope[15:8] == 8'h83) begin
		if (8'h78 <=ope[7:0] && ope[7:0] <= 8'h7f ) begin
			select_input_2 = 4'h6;//stack_addr_access
		end else  begin
			select_input_2 = 4'hx;
		end
	end else if (ope[15:8] == 8'h89) begin
		if (8'h45 ==ope[7:0]) begin
			select_input_2 = 4'h8;
		end else begin
			select_input_2 = 4'hx;
		end
        end else begin
		select_input_2 = 4'hx;
        end;
end
endfunction

function [3:0] load_reg_3;
input [15:0]ope;
begin
        if (ope[15:8] == 8'he8) begin
		load_reg_3 = 4'h4;
        end else if (ope[15:8] == 8'hc9) begin
		load_reg_3 = 4'h2;//esp
        end else begin
		load_reg_3 = 4'hx;
        end;

end
endfunction

function [3:0] select_input_3;
input [15:0]ope;
begin
        if (ope[15:8] == 8'he8) begin
		select_input_3 = 4'h2;//eip
        end else if (ope[15:8] == 8'hc9) begin
		select_input_3 = 4'h1;//esp
        end else begin
		select_input_3 = 4'hx;
        end;

end
endfunction


always @(posedge reset or posedge clk2) begin
	if (reset == 1'b1) begin
		num_of_ope <= 4'h0;
	end 
	else begin
		num_of_ope <= calc_ope(ope1);
	end 
end

function [3:0] calc_ope;
input [15:0]ope;
begin
	if (ope[15:8] == 8'h55) begin
		calc_ope = 4'h1;
	end else if (ope[15:8] == 8'h50) begin
		calc_ope = 4'h1;
	end else if (ope[15:8] == 8'h53) begin
		calc_ope = 4'h1;
	end else if (ope[15:8] == 8'h85) begin
		calc_ope = 4'h2;
        end else if (ope[15:8] == 8'h89) begin
		if ( 8'he5 ==ope[7:0] ) begin//1byte
			calc_ope = 4'h2;
		end else if ( 8'hc3 ==ope[7:0] )begin
			calc_ope = 4'h2;
		end else if ( 8'h45 ==ope[7:0] )begin
			calc_ope = 4'h3;
		end

        end else if (ope[15:8] == 8'hb8) begin
		calc_ope = 4'h5;
        end else if (ope[15:8] == 8'h5d) begin
		calc_ope = 4'h1;
        end else if (ope[15:8] == 8'hc3) begin
		calc_ope = 4'h1;
        end else if (ope[15:8] == 8'he8) begin
		calc_ope = 4'h5;
        end else if (ope[15:8] == 8'h6a) begin
		calc_ope = 4'h2;
        end else if (ope[15:8] == 8'h75) begin
		calc_ope = 4'h2;
        end else if (ope[15:8] == 8'h74) begin
		calc_ope = 4'h2;
        end else if (ope[15:8] == 8'h01) begin
		calc_ope = 4'h2;
        end else if (ope[15:8] == 8'h8b) begin
		if ( 8'h40 <=ope[7:0] && ope[7:0] <= 8'h47 ) begin//1byte
			calc_ope = 4'h3;//eax
		end else if (8'h80 <=ope[7:0] && ope[7:0] <= 8'h87 ) begin//4byte
			calc_ope = 4'h6;//eax
		end else if (8'h58 <=ope[7:0] && ope[7:0] <= 8'h5f ) begin//4byte
			calc_ope = 4'h3;
		end else begin
			calc_ope = 4'hx;
		end
        end else if (ope[15:8] == 8'h83) begin
		if ( ope[7:0] == 8'he8) begin//sub
			calc_ope = 4'h3;
		end else if ( ope[7:0] == 8'hc4) begin//add
			calc_ope = 4'h3;
		end else if ( ope[7:0] == 8'hec) begin//sub
			calc_ope = 4'h3;
		end else if ( ope[7:0] == 8'h7d) begin//sub
			calc_ope = 4'h4;
		end else if ( ope[7:0] == 8'hf8) begin//sub
			calc_ope = 4'h3;
		end else begin
			calc_ope = 4'hx;
		end
        end else if (ope[15:8] == 8'hc9) begin
		calc_ope = 4'h1;
        end else if (ope[15:8] == 8'heb) begin
		calc_ope = 4'h2;
        end else begin
		calc_ope = 4'hx;
        end;
end
endfunction
endmodule


