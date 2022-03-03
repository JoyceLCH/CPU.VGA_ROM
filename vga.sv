//VGA controller
module vga(
	input logic vga_clk,reset,
	output logic hsync, vsync,
	output logic clk_25M,
	output logic[7:0] red,
	output logic[7:0] green,
	output logic[7:0] blue
);

parameter width = 24;
parameter addrSize = 16;

logic enable_V_Counter;
logic [9:0] H_Count_Value;
logic [9:0] V_Count_Value;
logic [addrSize-1:0] address;
logic [23:0] colour_data;
logic enable_horizontal;
logic enable_vertical;
logic counter_increment;

clock_divider VGA_Clock_gen (.vga_clk(vga_clk), .reset(reset), .clk_25M(clk_25M));
rom VGA_rom (.image_addr(address), .colour_data(colour_data));
rom_addr ROM_addr (.clk_25M(clk_25M), .enable_horizontal(enable_horizontal), .enable_vertical(enable_vertical), .counter_increment(counter_increment),
.image_addr(address), .H_Count_Value(H_Count_Value), .V_Count_Value(V_Count_Value));
horizontal_counter VGA_Horiz (.clk_25M(clk_25M), .reset(reset), .enable_horizontal(enable_horizontal), .enable_V_Counter(enable_V_Counter), .H_Count_Value(H_Count_Value));
vertical_counter VGA_Verti (.clk_25M(clk_25M), .reset(reset), .enable_vertical(enable_vertical), .enable_V_Counter(enable_V_Counter), .V_Count_Value(V_Count_Value));
display VGA_display (.clk_25M(clk_25M), .enable_horizontal(enable_horizontal), .enable_vertical(enable_vertical), 
.H_Count_Value(H_Count_Value), .V_Count_Value(V_Count_Value), .colour_data(colour_data), .o_red(red), .o_green(green), .o_blue(blue));


//hsync and vsync outputs assignments
assign hsync = (H_Count_Value >= 0 && H_Count_Value < 96) ? 1'b1:1'b0; //hsync high for 96 counts
assign vsync = (V_Count_Value >= 0 && V_Count_Value < 2) ? 1'b1:1'b0; //vsync high for 2 counts
// assign sync =  1'b1;
// assign blank = 1'b1;

// assign colour_out = {red,green,blue};
endmodule

