`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    data_path 

//////////////////////////////////////////////////////////////////////////////////
module data_path(op_code,rd_index,rs_index,rt_index,shamt,constant,rd_value,rs_value,rt_value,low,high,SR);
//inputs
input [3:0] op_code;
input [2:0] rd_index, rs_index, rt_index, shamt;
input [5:0] constant;
//outputs
output [15:0] rd_value;
output reg [15:0] rs_value,rt_value,low,high;
output [15:0]SR;	
//wires
wire [15:0] hi,lo;
//regs
reg [15:0]HI,LO,SR;

//Registers file
reg [15:0] regfile[0:7];
initial
begin
  regfile[0]=7;
  regfile[1]=6;
  regfile[2]=5;
  regfile[3]=4;
  regfile[4]=3;
  regfile[5]=2;
  regfile[6]=1;
  regfile[7]=0;
  //special registers
	HI=16'b0000000000000000;
	LO=16'b0000000000000000;
	SR=16'b0000000000000000;
end


always@(op_code)
	begin
     if (op_code>=0 && op_code<=7)		//R TYPE
			begin
			rs_value=regfile[rs_index];
			rt_value=regfile[rt_index];
			end
    else if (op_code>=8 && op_code<=11) //I TYPE
			begin
			rs_value=regfile[rs_index]; 
			end
    else 
			begin 								//J TYPE IS USED WITH PC
			rs_value=0;
			rt_value=0; 
			
			end
	end

//Implementing SR	
always @(*)
	begin	
	if(rs_value==rt_value)
			SR[3]=1;                                	   //zero flag
	else if(rs_value<rt_value)
			SR[2]=1;                           		   	//negative flag
	else if(rs_value[15]==1 && rt_value[15]==1)
			SR[0]=1;                          			  //overflow flag
	else if(rs_value[15]==0 && rt_value[15]==0)
			SR[0]=1;                                 	 //overflow flag
	else if(rs_value[15:0] || rt_value[15:0])
			SR[1]=1;                          			 //carry flag
	end
	
	
always @(*)
	begin
	//assigning values of low and high to output
	low = lo;
	high = hi;
	//assigning value of rd,high and lo to register
	regfile[rd_index] = rd_value;
	HI = hi;
	LO = lo;	
	end

ALU call(op_code,rd_value,rs_value,rt_value,shamt,constant,hi,lo);



endmodule
