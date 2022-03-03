// synthesise to run on Altera DE0 for testing and demo
module picoMIPS4test #(parameter n=8) (
  input logic fastclk,  // 50MHz Altera DE0 clock
  input logic reset,
  output logic [n-1:0] outport, // LEDs
  output logic vsync, hsync,
  output logic[7:0] red,
	output logic[7:0] green,
	output logic[7:0] blue,
  output logic clk_25M
  ); 
  
  logic slowclk; // slow clock, about 10Hz

parameter WIDTH = 480; // default picture width
parameter HEIGHT = 320;


  // to obtain the cost figure, synthesise your design without the counter 
  // and the picoMIPS4test module using Cyclone IV E as target
  // and make a note of the synthesis statistics
  
 counter c (.fastclk(fastclk),.clk(slowclk)); // slow clk from counter
 cpu #(.n(n)) cpu0 (.clk(slowclk),.reset(reset),.outport(outport));
 vga vga0(.vga_clk(fastclk), .reset(reset), .hsync(hsync),.vsync(vsync), .red(red), .green(green), .blue(blue), .clk_25M(clk_25M));

endmodule