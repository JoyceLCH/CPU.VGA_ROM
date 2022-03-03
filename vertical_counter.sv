module vertical_counter(
    input clk_25M,reset,
    input enable_V_Counter,
    output logic enable_vertical,
    output logic [9:0] V_Count_Value = 0
);

always @(posedge clk_25M, negedge reset) begin
    if(~reset)
        V_Count_Value <= 0;
    else if(enable_V_Counter == 1'b1) begin
        if(V_Count_Value < 524)
        begin
            V_Count_Value <= V_Count_Value +1;
            if(V_Count_Value>=100 && V_Count_Value<300)
                enable_vertical <= 1;
            else
                enable_vertical <= 0;
        end
        else if(V_Count_Value == 524)
            V_Count_Value <=0;
    end
end

endmodule