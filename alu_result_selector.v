module alu_result_selector(clock_1, clock_2, clock_3, reg_load_1, reg_load_2, reg_load_3, selected_reg_load);
input clock_1;
input clock_2;
input clock_3;
input [3:0]reg_load_1;
input [3:0]reg_load_2;
input [3:0]reg_load_3;
output [3:0]selected_reg_load;

assign selected_reg_load = select(clock_1, clock_2, clock_3, reg_load_1, reg_load_2, reg_load_3);

function [3:0]select;
input clock_1;
input clock_2;
input clock_3;
input [3:0]reg_load_1;
input [3:0]reg_load_2;
input [3:0]reg_load_3;
if (clock_1 == 1'b1) begin
	select = reg_load_1;
end
else if (clock_2 == 1'b1) begin
	select = reg_load_2;
end
else if (clock_3 == 1'b1) begin
	select = reg_load_3;
end

endfunction

endmodule



