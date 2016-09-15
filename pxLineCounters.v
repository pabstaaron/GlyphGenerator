`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:58 09/09/2016 
// Design Name: 
// Module Name:    pxLineCounters 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pxLineCounters(input clk25mhz, input screenwidth, input screenheight,output reg[10:0] pixelCounter,
output reg[10:0] lineCounter, output reg bright
    );
//Parameters for the various resolution elements named as such:
//pxCount: Total horizontal pixels
//HbackPorch: pixel count for the horizontal back porch
//HfrontPorch: pixel count for the horizontal front porch
//Hsync: Horizonal sync width
//lineCount: Total number of horizontal lines,oriented up and down
//Vbackporch: pixel count for the veritcal back porch
//VfrontPorch: pixel count for the vertical front porch
//Vsync: Vertical synch width
parameter pxCount=640,
HbackPorch=48,
HfrontPorch=784,
Hsync=96,
lineCount=480,
VbackPorch=33,
VfrontPorch=513,
Vsync=523;

//**FIGURE OUT HOW I CAN SEND IN SCREENWIDTH AND HEIGHT IN, function #(params, list) modulename(vars) maybe?

//enable bit that will go high when the pixelcount has been reached, telling the program
//to go to the next line down and begin counting there
reg lineend=0; 

always@(posedge clk25mhz)
begin

//If pixelCounter equals the pre-defined horizontal width, it will enable the bit that moves
//down to the next line and resetting the pixel position to 0. Otherwise increments by one
	if(pixelCounter==pxCount)
		begin
		 lineend=1'b1;
		 pixelCounter=11'd0;
		end
	else
		begin
		pixelCounter=pixelCounter+1'b1;
		lineend=1'b0;
		end
	
	//If the lineend bit has been enabled it will first check to make sure the line count isn't
	//at the bottom of the screen, designated by lineCount. If it has it resets to line 0.
	//otherwise increments the line by 1
	if(lineend)
		begin
		if(lineCounter==lineCount)
			lineCounter=11'd0;
		else
			lineCounter=lineCounter+1'b1;
		end

	//If the pixel and line counters are within the active part of the screen
	//sends a high "bright" signal to tell the pixels to display
	if(((pixelCounter >= HbackPorch) && (pixelCounter <= HfrontPorch)) && 
		(lineCounter >= VbackPorch) && (lineCounter <= VfrontPorch))
			bright=1'b1;
	else
		bright=1'b0;
	

end










endmodule
