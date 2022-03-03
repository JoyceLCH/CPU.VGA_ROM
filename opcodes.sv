//-----------------------------------------------------
// File Name : opcodes.sv
//-----------------------------------------------------
// 

`define NOP     6'b000000
`define J       6'b001000
`define STR     6'b010000 //store to RAM
`define ADD     6'b000010
`define SUB     6'b000011 
`define ADDI    6'b001010
`define SUBI    6'b001011 

`define BEQ     6'b010101 
`define BNE     6'b010110
//`define BGE     6'b100011 
//`define BLO     6'b101011 
`define LOAD    6'b010010 //load from RAM
`define LDI     6'b011010   // (Load Immediate to Register) LDI %d, imm is implemented as: ADDI %d, %0, imm
`define MULL_INT    6'b000111
`define MULL_FLT    6'b000100

//`define SWITCH 6'b011000