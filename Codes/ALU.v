`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Module Name:    ALU 

//////////////////////////////////////////////////////////////////////////////////

module ALU(op_code,rd,rs,rt,shamt,constant,hi,lo);
//inputs
input [3:0] op_code;                   				 // op_code is of 4 bits
input [15:0]rs,rt;  								        	 // all inputs are of 16 bits
input [5:0] constant;										 //constant is of 6 bits
input [2:0] shamt;                				       // shamt is of 3 bits
//temp regs
reg [8:0] address;
reg [31:0] TEMP; 
//outputs               			                 // temporary wire for saving 32 bit answer of multiplication
output reg[15:0] rd,hi,lo;  							  // outputs are also 16 bits



//Random Access Memory(RAM) for data read/write
reg [15:0] RAM [0:7];
initial
begin
RAM[0] = 16'b 0000000000000001;
RAM[1] = 16'b 0000000000000101;                     // Memory location
RAM[2] = 16'b 0000000000000000;
RAM[3] = 16'b 0000000000000000;
RAM[4] = 16'b 0000000000000011;
RAM[5] = 16'b 0000000000000001;
RAM[6] = 16'b 0000000000000001;
RAM[7] = 16'b 0000000000000001;
end

///////////////////////////////////////////////////////
always @ (*)
	begin
			TEMP = rs * rt;  
			hi = TEMP[31:16];     		 //saving 16 msb in hi             
			lo = TEMP[15:0];				//saving 16 lsb in lo
			
		if(op_code== 0)					// if op_code is 0 then add rs and rt 			
			begin                    
			rd = rs + rt; 
			end
		else if (op_code==1)				// if op_code is 1 then shift the rs left by shamt amount
			begin               
			rd = rs << shamt;
			end
		else if (op_code==2)				// if op_code is 2 then shift the rs right by shamt amount
			begin           
			rd = rs >> shamt; 
			end
		else if (op_code==3) 			// if op_code == 3 then then multiply the answer will come 32 bit which we will store in TEMP
			begin                     
			TEMP = rs * rt;  
			hi = TEMP[31:16];     			 //saving 16 msb in hi             
			lo = TEMP[15:0];					//saving rest 16 lsb in lo 
			end
		else if (op_code==4) 			//if op_code == 4 then rd = lo
			begin           
			rd = lo; 
			end
		else if (op_code==5) 			//if op_code == 5 then rd = hi
			begin           
			rd = hi;   
			end
		else if (op_code==6) 			//if op_code == 6 then rd = rs | rt
			begin           
			rd = rs | rt; 
			end
		else if (op_code==7) 			//if op_code == 7 then rd = rs & rd
			begin 
			rd = rs & rt; 
			end
		else if (op_code==8) 			//if op_code == 8 then rd = rs + constant(addi)
			begin 
			rd = rs + constant; 
			end
		else if (op_code==9) 			//if op_code == 9 then rd = constant(li)
			begin          
			rd = constant; 
			end         
		else if (op_code==10) 			//if op_code == 10 then rd = RAM [rs + constant] (lw)
			begin             
			rd = RAM [rs + constant];  
			end
		else if (op_code==11) 			//if op_code == 11 then RAM [rs + constant] = rd (sw)
			begin              
			RAM [rs + constant] = rd;  
			end
			
		else   
			begin 
			rd = 0; 
			end
			
end


endmodule
