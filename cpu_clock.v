module cpu_clock(input clk, input reset,
	output clock_1, output clock_2, output clock_3, output clock_4,clock_4_2,
	output clock_5, output clock_6, clock_6_2, output clock_7, output clock_8, clock_8_2,
	output clock_9, output clock_10, output clock_11, output clock_12);
wire clk;
wire reset;
reg clock_1;
reg clock_2;
reg clock_3;
reg clock_4;
reg clock_4_2;
reg clock_5;
reg clock_6;
reg clock_6_2;
reg clock_7;
reg clock_8;
reg clock_8_2;
reg clock_9;
reg clock_10;
reg clock_11;
reg clock_12;
reg clock_1_t;
reg clock_2_t;
reg clock_3_t;
reg clock_4_t;
reg clock_4_2_t;
reg clock_5_t;
reg clock_6_t;
reg clock_6_2_t;
reg clock_7_t;
reg clock_8_t;
reg clock_8_2_t;
reg clock_9_t;
reg clock_10_t;
reg clock_11_t;
reg clock_12_t;

reg [7:0]count;


always @(posedge clk or posedge reset) begin
	if (reset == 1'b1)  begin
		count <= 8'h00;
		clock_1 <= 1'b0;
		clock_2 <= 1'b0;
		clock_3 <= 1'b0;
		clock_4 <= 1'b0;
		clock_4_2 <= 1'b0;
		clock_5 <= 1'b0;
		clock_6 <= 1'b0;
		clock_6_2 <= 1'b0;
		clock_7 <= 1'b0;
		clock_8 <= 1'b0;
		clock_8_2 <= 1'b0;
		clock_9 <= 1'b0;
		clock_10 <= 1'b0;
		clock_11 <= 1'b0;
		clock_12 <= 1'b0;
		clock_1_t <= 1'b0;
		clock_2_t <= 1'b0;
		clock_3_t <= 1'b0;
		clock_4_t <= 1'b0;
		clock_5_t <= 1'b0;
		clock_6_t <= 1'b0;
		clock_7_t <= 1'b0;
		clock_8_t <= 1'b0;
		clock_9_t <= 1'b0;
		clock_10_t <= 1'b0;
		clock_11_t <= 1'b0;
		clock_12_t <= 1'b0;
	end
	else  begin
		if (count == 8'h1e)
			count <= 8'h01;
		else 
			count <= count + 8'h01;
	
		if (count == 8'h1e)
			clock_1 <= 8'b0000_0001;
		else
			clock_1 <= 8'b0000_0000;

		clock_12_t <= clock_12;
		clock_12 <= clock_11_t;
		clock_11_t <= clock_11;
		clock_11 <= clock_10_t;
		clock_10_t <= clock_10;
		clock_10 <= clock_9_t;
		clock_9_t <= clock_9;
		clock_9 <= clock_8_2_t;
		clock_8_2_t <= clock_8_2;
		clock_8_2 <= clock_8_t;
		clock_8_t <= clock_8;
		clock_8 <= clock_7_t;
		clock_7_t <= clock_7;
		clock_7 <= clock_6_2_t;
		clock_6_2_t <= clock_6_2;
		clock_6_2 <= clock_6_t;
		clock_6_t <= clock_6;
		clock_6 <= clock_5_t;
		clock_5_t <= clock_5;
		clock_5 <= clock_4_2_t;
		clock_4_2_t <= clock_4_2;
		clock_4_2 <= clock_4_t;
		clock_4_t <= clock_4;
		clock_4 <= clock_3_t;
		clock_3_t <= clock_3;
		clock_3 <= clock_2_t;
		clock_2_t <= clock_2;
		clock_2 <= clock_1_t;
		clock_1_t <= clock_1;
	end
end

//always @(posedge clk) begin
//	clock_12_t <= clock_12;
//	clock_12 <= clock_11_t;
//	clock_11_t <= clock_11;
//	clock_11 <= clock_10_t;
//	clock_10_t <= clock_10;
//	clock_10 <= clock_9_t;
//	clock_9_t <= clock_9;
//	clock_9 <= clock_8_2_t;
//	clock_8_2_t <= clock_8_2;
//	clock_8_2 <= clock_8_t;
//	clock_8_t <= clock_8;
//	clock_8 <= clock_7_t;
//	clock_7_t <= clock_7;
//	clock_7 <= clock_6_2_t;
//	clock_6_2_t <= clock_6_2;
//	clock_6_2 <= clock_6_t;
//	clock_6_t <= clock_6;
//	clock_6 <= clock_5_t;
//	clock_5_t <= clock_5;
//	clock_5 <= clock_4_2_t;
//	clock_4_2_t <= clock_4_2;
//	clock_4_2 <= clock_4_t;
//	clock_4_t <= clock_4;
//	clock_4 <= clock_3_t;
//	clock_3_t <= clock_3;
//	clock_3 <= clock_2_t;
//	clock_2_t <= clock_2;
//	clock_2 <= clock_1_t;
//	clock_1_t <= clock_1;
//end

endmodule

