
//---------------------------------------------------------
// File Name   : decoder.sv
// Function    : picoMIPS instruction decoder 
// Author: tjk
// ver 2:  // NOP, ADD, ADDI, and branches
// Last revised: 26 Oct 2012
//---------------------------------------------------------

`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decoder 
( input logic [5:0] opcode, // top 6 bits of instruction
input logic [3:0] flags, // ALU flags
//input logic SW8,
//output logic [4:0]address,
// output signals
//    PC control
output logic PCincr,PCabsbranch,PCrelbranch,
//    ALU control
output logic [2:0] ALUfunc, 
// imm mux control
output logic imm,
//   register file control
output logic w1,w2
  );
   
//------------- code starts here ---------
// instruction decoder
logic takeBranch; // temp variable to control conditional branching

always_comb 
begin 
  // set default output signal values for NOP instruction
   PCincr = 1'b1; // PC increments by default
   PCabsbranch = 1'b0; 
   PCrelbranch = 1'b0;
   ALUfunc = opcode[2:0]; 
   imm=1'b0;
   w1=1'b0; 
   w2=1'b0;
   takeBranch = 1'b0; 

   case(opcode)
      `NOP: ;
      `ADD,`SUB : begin // register-register
	      w1 = 1'b1; // write result to dest register
	      end
      
      `ADDI,`SUBI,`LDI : begin // register-immediate
	      w1 = 1'b1; // write result to dest register
		imm = 1'b1; // set ctrl signal for imm operand MUX
            end
       
      `J : begin // Jump absolute and unconditional
            PCincr = 1'b0; // tell PC not to increment
            PCabsbranch = 1'b1; // tell PC to branch absolute
            end

      `STR : begin
            w2 = 1'b1;
            end

      `MULL_INT,`MULL_FLT : begin
            w1 = 1'b1;
            end

      // branches
	`BEQ: takeBranch = flags[1]; // branch if Z==1

	`BNE: takeBranch = ~flags[1]; // branch if Z==0
 
	//`BGE: takeBranch = ~flags[2]; // branch if N==0
	//`BLO: takeBranch = flags[0]; // branch if C==1
	default:
	    $error("unimplemented opcode %h",opcode);
 
   endcase // opcode 

   if(takeBranch) // branch condition is true;
   begin
      PCincr = 1'b0;
	PCrelbranch = 1'b1; 
   end
   

end // always_comb
endmodule //module decoder --------------------------------