module cpu_clock(input clk, input reset,
	output clock_1, output clock_2, output clock_3, output clock_4,
	output clock_5, output clock_6, output clock_7, output clock_8);
wire clk;
wire reset;
reg clock_1;
reg clock_2;
reg clock_3;
reg clock_4;
reg clock_5;
reg clock_6;
reg clock_7;
reg clock_8;
reg [3:0]count;


always @(posedge clk or posedge reset) begin
	if (reset == 1'b1)  begin
		count <= 4'h0;
		clock_1 <= 1'b0;
		clock_2 <= 1'b0;
		clock_3 <= 1'b0;
		clock_4 <= 1'b0;
		clock_5 <= 1'b0;
		clock_6 <= 1'b0;
		clock_7 <= 1'b0;
		clock_8 <= 1'b0;
	end
	else  begin
		if (count == 4'h8)
			count <= 4'h1;
		else 
			count <= count + 4'h1;
	
		if (count == 4'h8)
			clock_1 <= 1'b1;
		else
			clock_1 <= 1'b0;
	end
end

always @(posedge clk) begin
	clock_8 <= clock_7;
	clock_7 <= clock_6;
	clock_6 <= clock_5;
	clock_5 <= clock_4;
	clock_4 <= clock_3;
	clock_3 <= clock_2;
	clock_2 <= clock_1;
end

endmodule
