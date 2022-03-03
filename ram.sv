//-----------------------------------------------------
// File Name : ram.sv
// Function  : picoMIPS RAM to store image
//-----------------------------------------------------
// synchronous RAM, 128x8 
module ram128x8sync( 
 output logic [23:0] dout, 
 input logic [255:0] address, 
 input logic [23:0] din, 
 input logic clk
 ); 
 
 logic [23:0] mem [255:0]; 
 
 initial begin
     $readmemh("labradorretriever.hex", mem);
 end

 always_ff @(posedge clk) 
 begin 
   if (w2) 
    mem[address] <= din; // memory write 
    
    dout <= mem[address]; // synchronous memory read 
 end 
endmodule