module fetch(reset, clk1, ope_data);
input wire reset;
input wire clk1;
output reg [31:0]ope_data;
wire [31:0]eip;
wire [31:0]data;

eip_register eip_register(reset, 4'h0, 32'h0000, eip);

program_memory program_memory (reset, eip, data);

always @(posedge reset or posedge clk1) begin
	if (reset) 
		ope_data <= 0;
	else 
		ope_data <= data;
end

endmodule

