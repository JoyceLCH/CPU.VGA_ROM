module clock_divider #(parameter DIVISOR = 28'd2)
                     (input  logic vga_clk, reset,
                      output logic clk_25M);

// Counter
logic [27:0] counter = 28'd0;

always_ff @(posedge vga_clk, negedge reset)
begin
    if(~reset)
        counter <= 0;
    else 
    begin
        counter <= counter + 28'd1;
        if (counter >= (DIVISOR - 1))
            counter <= 28'd0;
    end
end

assign clk_25M = (counter < DIVISOR / 2 ) ? 1'b0 : 1'b1;

endmodule // ClockDivider