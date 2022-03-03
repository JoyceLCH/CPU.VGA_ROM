module cputest;
parameter n = 8;
parameter Psize = 6;
//parameter Isize = n+16;

logic clk, reset; // master reset
//logic [Psize-1 : 0]ProgAddress;
logic[5:0] outport; // need an output port, tentatively this will be the ALU output
//logic SW8;
cpu #(.n(n)) cpu0(.*);

initial 
begin
reset = 0;
#2ns reset = 1;
#3ns reset = 0;
end

initial
begin
  clk = 1'b0;
  forever #5ns clk = ~clk;
end


endmodule