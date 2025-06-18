	`timescale 1ns / 1ps

// Module Name:    control_unit 

//////////////////////////////////////////////////////////////////////////////////
module control_unit(PC,opcode,rd_index,rs_index,rt_index,shamt,constant,address);
//input
input [7:0] PC;
wire [15:0] instr;
//outputs
output  [3:0] opcode;
output  [2:0] rd_index,rs_index,rt_index,shamt;
output [5:0] constant;
output [8:0] address;

//ROM MEMORY
reg [15:0] ROM [0:15];
initial

begin
//(R TYPE INSTRUCTION)
ROM[0]  = 16'b 0000_111_001_000_000; 	  	//  Opcode = 0 so rd = rs + rt                
ROM[1]  = 16'b 0001_111_001_000_001; 	  	//  Opcode = 1 so rd = rs << shamt           
ROM[2]  = 16'b 0010_111_001_001_001;   	//  Opcode = 2 so rd = rs >> shamt            
ROM[3]  = 16'b 0011_111_001_001_000;   	//  Opcode = 3 so rd = [hi,lo] = rs x rt                  
ROM[4]  = 16'b 0100_111_001_001_000;   	//  Opcode = 4 so move from lo to rd                  
ROM[5]  = 16'b 0101_111_001_001_000;    	//  Opcode = 5 so move from hi to rd    rd = rs + consatnt          
ROM[6]  = 16'b 0110_111_001_001_000;    	//  Opcode = 6 so  rd = rs | rt               
ROM[7]  = 16'b 0111_111_001_001_000;    	//  Opcode = 7 so  rd = rs & rt
//(I TYPE INSTRUCTION)
ROM[8]  = 16'b 1000_111_001_001000;    	//  Opcode = 8 so rd = rs + consatnt  
ROM[9]  = 16'b 1001_111_001_001000;     	//  Opcode = 9 so rd = constant 
ROM[10] = 16'b 1010_111_001_001000;    	//  Opcode = 10 so rd = memory(rs + constant) 
ROM[11] = 16'b 1011_111_001_001000;    	//  Opcode = 11 so memory(rs + constant) = rd
//(J TYPE INSTRUCTION)
ROM[12] = 16'b 1100_000000010_000;     	//  Opcode = 12 so PC = PC + address  
ROM[13] = 16'b 1101_000000010_000;      	//  Opcode = 13 so PC = PC + address
ROM[14] = 16'b 1110_000000010_000;   	   //  Opcode = 14 so PC = PC + address
end



//Assigning instruction to instr reg using ROM[PC]
assign instr = ROM[PC];


//calling decode unit in CU
decode call(instr,opcode,rd_index,rs_index,rt_index,constant,shamt,address);




endmodule
