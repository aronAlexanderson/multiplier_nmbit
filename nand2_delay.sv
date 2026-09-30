`timescale 1ns / 1ps

module nand2_delay ( 
	input logic a,   // First input 
	input logic b,   // Second input 
	output logic y   // Output 
	); 

// Continuous assignment for XOR gate 
    assign #1ns y = ~(a & b);  // Perform the XOR operation after the delay
	
endmodule