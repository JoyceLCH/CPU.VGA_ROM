module rom_addr  
#(parameter addrSize = 16)
(
    input logic clk_25M, 
    input logic [9:0] V_Count_Value,
    input logic [9:0] H_Count_Value,
    input logic enable_horizontal,enable_vertical,
    output logic counter_increment,
    output logic [addrSize-1:0] image_addr=0
);

logic [addrSize-1:0] counter = 0;

always_comb
begin
  if((enable_horizontal && enable_vertical) == 1) 
    counter_increment = 1;
  else
   counter_increment = 0;
end

always_ff @(posedge clk_25M) begin
  if(counter < 40000) begin 
      counter <= counter + counter_increment;
      image_addr <= counter;
  end
  else begin 
      counter <= 0;
      image_addr <= counter;
   end
end

endmodule
