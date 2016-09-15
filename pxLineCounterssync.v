`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:18 09/11/2016 
// Design Name: 
// Module Name:    pxLineCounterssync 
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
module pxLineCounterssync(input clk,output reg[10:0] pixelCounter,
lineCounter, output reg bright,vsync,hsync
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
parameter pxCount=800,
HbackPorch=48,
HfrontPorch=704,
Hsync=800,
lineCount=525,
VbackPorch=33,
VfrontPorch=523,
Vsync=525;


//enable bit that will go high when the pixelcount has been reached, telling the program
//to go to the next line down and begin counting there
reg lineend=0; 

//Pixel state
reg [1:0]pixelstate;
always@(posedge clk)
pixelstate<=pixelstate+1'b1;





always@(posedge clk)
begin

if(pixelstate==2'b11)
begin
//If pixelCounter equals the pre-defined horizontal width, it will enable the bit that moves
//down to the next line and resetting the pixel position to 0. Otherwise increments by one
	if(pixelCounter==pxCount-1)
		begin
		 lineend=1'b1;
		 pixelCounter=11'd0;
		 hsync=1'b1;  
		end
		
	else if(pixelCounter==HfrontPorch-1)
		begin
		hsync=1'b0;
		pixelCounter=pixelCounter+1'b1;
		lineend=1'b0;
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
		if(lineCounter==lineCount-1)
			begin
				lineCounter=11'd0;
				vsync=1'b1;			
			end
		else if(lineCounter==VfrontPorch-1)
			begin
			vsync=1'b0;	
			lineCounter=lineCounter+1'b1;  
			end
		else
			begin
			lineCounter=lineCounter+1'b1;  
			end
		end

	//If the pixel and line counters are within the active part of the screen
	//sends a high "bright" signal to tell the pixels to display
	bright=(((pixelCounter >= HbackPorch-1) && (pixelCounter <= HfrontPorch-1)) && 
		(lineCounter >= VbackPorch-1) && (lineCounter <= VfrontPorch-1));
end
end
endmodule
