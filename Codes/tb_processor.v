`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

// Design Name:   processor

////////////////////////////////////////////////////////////////////////////////

module tb_processor;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] PC;
	wire [3:0] opcode;
	wire [2:0] rd_index;
	wire [2:0] rs_index;
	wire [2:0] rt_index;
	wire [2:0] shamt;
	wire [5:0] constant;
	wire [8:0] address;
	wire [15:0] rd_value;
	wire [15:0] rs_value;
	wire [15:0] rt_value;
	wire [15:0] low_out;
	wire [15:0] high_out;
	wire [15:0] SR;

	// Instantiate the Unit Under Test (UUT)
	processor uut (
		.clk(clk), 
		.reset(reset), 
		.PC(PC), 
		.opcode(opcode), 
		.rd_index(rd_index), 
		.rs_index(rs_index), 
		.rt_index(rt_index), 
		.shamt(shamt), 
		.constant(constant), 
		.address(address), 
		.rd_value(rd_value), 
		.rs_value(rs_value), 
		.rt_value(rt_value), 
		.low_out(low_out), 
		.high_out(high_out), 
		.SR(SR)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 1;
		#100;
		reset = 0;
		#100;

	end
	
	always 
		begin
		clk=!clk;
		#100;
	end    


      
endmodule
