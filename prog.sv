//-----------------------------------------------------	
//	File	Name	:	prog.sv	
//	FuncFon	:	Program	memory	psize	x	isize	-	reads	from	file	prog.hex
//-----------------------------------------------------	
module	prog	#(parameter Psize = 6, Isize = 24)	//psize - address width, isize - instruction width	
(input	logic	[Psize-1:0] address,	
output	logic	[Isize:0] instr); 	//I - instrucFon	code	

//	program	memory	declaration, note: 1<<n	is same as 2^n	
logic	[Isize:0]	progMem[(1<<Psize)-1:0];	
//	get	memory	contents	from	file	
initial	
	$readmemh("prog2.hex", progMem);	
	
//	program	memory	read		
always_comb 
	instr = progMem[address];	
	
endmodule	//	end	of	module	prog