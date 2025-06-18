`timescale 1ns / 1ps
 
// Module Name:    decode 

//////////////////////////////////////////////////////////////////////////////////
module decode(instr,opcode,rd_index,rs_index,rt_index,constant,shamt,address);
//inputs
input [15:0] instr;
//outputs
output reg [3:0] opcode;
output reg [2:0] rd_index,rs_index,rt_index,shamt;
output reg [5:0] constant;
output reg [8:0] address;

//dividing each instruction according to its type    
always@(instr)
begin
      opcode=instr[15:12];					// assigning first 4 bits to opcode
	if (opcode>=0 && opcode<=7)			// if opcode ranges from 0 to 7 then it is r type
			begin
			opcode=instr[15:12];
			rd_index = instr[11:9];
			rs_index = instr[8:6];
			rt_index = instr[5:3];
			shamt = instr[2:0]; 
			end
   else if(opcode>=8 && opcode<=11 ) 	// if opcode ranges from 8 to 11 then it is i type
			begin
			opcode = instr[15:12]; 
			rd_index = instr[11:9];
			rs_index = instr[8:6];
			constant = instr[5:0];
			end
      else  									// otherwise it is j type
			begin
			opcode=instr[15:12];
			address = instr[11:3];
			end  
end


endmodule
