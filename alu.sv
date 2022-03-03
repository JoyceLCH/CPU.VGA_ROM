
//-----------------------------------------------------
// File Name : alu.sv
// Function : ALU module for picoMIPS
// Version: 1, only 8 funcs
// Author: tjk
// Last rev. 17 Feb 21
//-----------------------------------------------------
`include "alucodes.sv" 
module alu #(parameter n=8) (
input logic [n-1:0] a, b, // ALU operands
input logic [2:0] func, // ALU function code
output logic [3:0] flags, // ALU flags V,N,Z,C
output logic [n-1:0] result
); 


//------------- code starts here ---------
// create an n-bit adder 
// and then build the ALU around the adder
logic [n-1:0] ar,a1,b1,bsub; // temp signals
logic [2*(n)-1:0] mult_out;

always_comb
begin
if(func==`RSUB)
bsub = ~b + 1'b1; // 2's complement subtrahend
else bsub = b;
ar = a + bsub;
end // always_com

// create the ALU, use signal ar in arithmetic operations
always_comb
begin
//default output values; prevent latches 
a1 = 0;
b1 = 0;
flags = 4'b0;
result = a; // default
mult_out = 0;

case(func)
`RA : result = a;
`RB : result = b;
`RADD : begin
result = ar; // arithmetic addition
flags[3] = a[7] & b[7] & ~result[7] | ~a[7] & ~b[7] & result[7]; //V
flags[0] = a[7] & b[7] | a[7] & ~result[7] | b[7] & ~result[7]; // C
end
`RSUB : begin
result = ar; // arithmetic subtraction
flags[3] = a[7] & ~b[7] & ~result[7] | ~a[7] & b[7] & result[7]; // V
// C - note: picoMIPS inverts carry when subtracting
flags[0] = ~a[7] & b[7] | ~a[7] & result[7] | b[7] & result[7];
end 

//`RAND : result = a1 & b1;
//`ROR : result= a | b;
//`RXOR : result = a ^ b;
//`RNOR : result = ~ (a | b);

`BEQ : 
if (a==b) 
    result = 8'b0;

`BNE : 
if (a!=b)
    result = 1;

`MULL_FLT : begin
    a1 = a;
    b1 = b;
   
mult_out = a1*b1; 
result = mult_out[(2*n)-2:7];
//result = mult_out[n-1:0];

if(a[7]==1)
begin
    a1 = ~a + 1'b1;
    mult_out = a1*b1;
    //mult_outflip = ~mult_out + 1'b1; 
    //result = mult_outflip[n-1:0];
    result = ~(mult_out[(2*n)-2:7]) + 1'b1;
end

if(b[7]==1)
begin
    b1 = ~b + 1'b1;
    mult_out = a1*b1; 
    //mult_outflip = ~mult_out + 1'b1; 
    //result = mult_outflip[n-1:0];
    result = ~(mult_out[(2*n)-2:7]) + 1'b1;
end
end

`MULL_INT : begin
    a1 = a;
    b1 = b;

mult_out = a1*b1; 
result = mult_out[n-1:0];

if(a[7]==1)
begin
    a1 = ~a + 1'b1;
    mult_out = a1*b1;
    //mult_outflip = ~mult_out + 1'b1; 
    //result = mult_outflip[n-1:0];
    result = ~(mult_out[n-1:0]) + 1'b1;
end

if(b[7]==1)
begin
    b1 = ~b + 1'b1;
    mult_out = a1*b1; 
    //mult_outflip = ~mult_out + 1'b1; 
    result = ~(mult_out[n-1:0]) + 1'b1;
end

end
endcase

// calculate flags Z and N
flags[1] = result == {n{1'b0}}; // Z
flags[2] = result[n-1]; // N
end //always_comb
endmodule //end of module ALU

