module fetch(reset, clk1, ope_data, eip);
input wire reset;
input wire clk1;
input wire [31:0]eip;
output reg [31:0]ope_data;
wire [31:0]data;

program_memory program_memory (reset, eip, data);

always @(posedge reset or posedge clk1) begin
	if (reset) 
		ope_data <= 0;
	else 
		ope_data <= data;
end

endmodule

