module cpu_clock(input clk, output clock_1, output clock_2, output clock_3, output clock_4);
wire clk;
reg clock_1;
reg clock_2;
reg clock_3;
reg clock_4;
reg [3:0]count;


always @(posedge clk) begin

	count <= count + 1'b1;

	if (count == 4'b1001) begin
		count = 4'b0000;
	end

	if (count == 4'b1000)
		clock_1 <= 1'b1;
	else
		clock_1 <= 1'b0;
end

always @(posedge clk) begin
	clock_4 <= clock_3;
	clock_3 <= clock_2;
	clock_2 <= clock_1;
end

endmodule
