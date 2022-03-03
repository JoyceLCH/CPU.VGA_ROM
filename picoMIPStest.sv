module picoMIPStest;
parameter n=8;
parameter Psize = 6;

logic fastclk, reset;
logic [n-1:0] outport; // LEDs
logic vsync, hsync;
logic[7:0] red;
logic[7:0] green;
logic[7:0] blue;
logic clk_25M;

picoMIPStest #(.n(n)) picoMIPS4test(.*);

initial 
begin
reset = 0;
#2ns reset = 1;
#3ns reset = 0;
end

initial
begin
  fastclk = 1'b0;
  forever #5ns fastclk = ~fastclk;
end


endmodule