module immidiator(ope, eip, out_immidiate);
input [31:0]ope;
input [7:0]eip;
output [31:0]out_immidiate;

wire [31:0]data;
program_memory immidiate_getter1(1'b0, eip+8'h1, data);

always @(posedge clk2) begin
	if (data == 8'hb8)
		out_immidiate = data;
end


endmodule

