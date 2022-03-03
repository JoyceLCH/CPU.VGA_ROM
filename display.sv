module display
#(parameter addrSize = 16)
(
    input logic clk_25M,
	input logic [9:0] V_Count_Value,
    input logic [9:0] H_Count_Value,
	input logic [23:0] colour_data,
	input logic enable_horizontal,
	input logic enable_vertical,
	output logic[7:0] o_red,
	output logic[7:0] o_green,
	output logic[7:0] o_blue
);

always_ff @(posedge clk_25M)	
begin
	if((enable_horizontal && enable_vertical) == 1)
	begin
		o_blue <= colour_data[23:16];
		o_green <= colour_data[15:8];
		o_red <= colour_data[7:0]; //red-LSB
	end
	else begin
		o_red <= 8'b00000000;
		o_green <= 8'b00000000;
		o_blue <= 8'b00000000;
	end
end

endmodule