module rom 
#(parameter picture_size = 40000, //fox
  parameter width = 24,
  parameter addrSize = 16
)
(
    input logic [addrSize-1:0] image_addr,
    output logic [width-1:0] colour_data
);

    // Declare the ROM variable
    logic [width-1:0] rom[(1<<addrSize)-1:0];

	initial   
       $readmemh("low.hex", rom);
        // for(i=0; i<64; i=i+1) 
        // $display(rom[14]);
    
    always_comb
     colour_data = rom[image_addr];

	// always_ff @(posedge clk_25M, negedge reset) begin
    //     if(~reset)
    //         colour_data <= 24'd0;
    //     else 
    //         colour_data <= rom[image_addr];
    // end 

endmodule