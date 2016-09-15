`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Julian Whitteron
// 
// Create Date:    13:38:49 09/09/2016 
// Design Name: 
// Module Name:    vgatest1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Takes in the onboard 100MHz clock from the board, brings it through
//the buffers and returns a 25MHz clock for use with the VGA.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vgaclock(input extclock, output reg clk25Mhz
    );
	wire bufwire,clk; //Bufwire connects the two clock buffers, clk is the outcoming buffered clock signal	
	reg [1:0]clocktimer; //3bit register used for clock throttling

	IBUFG ibufg(.I(extclock),.O(bufwire));
	BUFG ibuf(.I(bufwire),.O(clk));

	//Counts to 4 based on positive edges on the clock, once clocktimer is 4 the outgoing
	//signal is 1/4 of the incoming clock speed.
	//This frequency will give the 25Mhz clock needed for VGA use.
	always@(posedge clk)
	begin
		if(clocktimer==2'b11)
			begin
			clk25Mhz=1'b1;
			clocktimer=2'b00;
			end
		else
			begin
			clk25Mhz=1'b0;
			clocktimer=clocktimer+1'b1;
			end
	end
	


endmodule
