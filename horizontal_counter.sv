module horizontal_counter(
    input clk_25M,reset,
    output logic enable_V_Counter,
    output logic enable_horizontal,
    output logic [9:0] H_Count_Value
);

always @(posedge clk_25M, negedge reset) 
begin
    if(~reset) begin
        enable_V_Counter <= 0;
        H_Count_Value <= 0;
    end
    else if(H_Count_Value < 800)
    begin
		H_Count_Value <= H_Count_Value + 1;
		enable_V_Counter <= 0; //disable vertical counter
        if(H_Count_Value>=200 && H_Count_Value<400) //picture = 200x200
            enable_horizontal <= 1;
        else
            enable_horizontal <= 0; //disable print
	end
	else if(H_Count_Value == 800) 
    begin
		H_Count_Value <= 0;
		enable_V_Counter <= 1;
	end
end

endmodule