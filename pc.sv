//----------------------------------------------------- 
// File Name : pc.sv 
// Function : picoMIPS Program Counter 
// functions: increment, absolute and relative branches 
// Author: tjk 
// Last rev. 24 Oct 2012 
//----------------------------------------------------- 
module pc #(parameter Psize = 6) // up to 64 instructions 
(input logic clk, reset, PCincr,PCabsbranch,PCrelbranch, 
 input logic [Psize-1:0] Branchaddr, 
 output logic [Psize-1:0] PCout 
); 
//------------- code starts here--------- 
logic[Psize-1:0] Rbranch; // temp variable for addition operand

always_comb // multiplexer to select next instruction offset 
 if (PCincr) // see always_ff block below 
 Rbranch = 1; // add 1 
 else Rbranch = Branchaddr; // add branch addr 


always_ff @ ( posedge clk, negedge reset) // async reset 
 if (~reset) // reset 
 PCout <= {Psize{1'b0}}; 
 //else PCout <= PCout + 1'b1;
 else if (PCincr | PCrelbranch) // increment or branch relative 
 PCout <= PCout + Rbranch; // 1 adder handles both 
 else if (PCabsbranch) // absolute branch, load branch addr 
 PCout <= Branchaddr; 
 
endmodule // module pc
