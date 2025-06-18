`timescale 1ns / 1ps

module processor(clk,reset,PC,opcode,rd_index,rs_index,rt_index,shamt,constant,address,rd_value,rs_value,rt_value,low_out,high_out,SR);
//inputs
input clk,reset;
reg [7:0] pc;
//outputs
output [7:0] PC;
output [3:0] opcode;
output [2:0] rd_index, rs_index, rt_index, shamt;
output [5:0] constant;
output [8:0] address;
output [15:0] rd_value,rs_value,rt_value,low_out,high_out,SR;

// Making Clock
always @ (posedge clk,posedge reset)
begin
	if(reset==1)
		begin
		pc<=0;
		end
	else if (pc>14)								//reseting value of pc to zero after it exceeds 15 instructions
		begin
		pc <= 0;
		end
	else if(opcode>=12 && opcode<=14) 		//implementing jump
		begin
		pc <= pc + address; 
		end
	else 
		begin
		pc <= pc + 1; 								//making pc clock
		end
	
end


assign PC = pc;

//using wires to transfer controls from CU to Datapath
wire [3:0] opcode;
wire [2:0] rd_index,rs_index,rt_index,shamt;
wire [5:0] constant;
wire [8:0] address;

//calling CU and Datapath
control_unit cal1(PC,opcode,rd_index,rs_index,rt_index,shamt,constant,address);

data_path cal2(opcode,rd_index,rs_index,rt_index,shamt,constant,rd_value,rs_value,rt_value,low_out,high_out,SR);
endmodule 