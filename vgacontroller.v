`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:56 09/11/2016 
// Design Name: 
// Module Name:    vgacontroller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Top level controller for the VGA circuit
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vgacontroller(input extclock, output hsync,vsync, output [7:0]rgb
    );
	 wire bright; //pixel on enable bit
	 wire[10:0]pxcounter,linecounter; //pixel and line counter registers, tracking position
	 
	wire bufwire,clk; //Bufwire connects the two clock buffers, clk is the outcoming buffered clock signal	
	reg [1:0]clocktimer; //3bit register used for clock throttling

	IBUFG ibufg(.I(extclock),.O(bufwire));
	BUFG ibuf(.I(bufwire),.O(clk));
	
	
	 pxLineCounterssync VHposition(clk,pxcounter,linecounter,bright,vsync,hsync);
	 colorgen colorin(bright,clk,pxcounter,linecounter,rgb);

endmodule
