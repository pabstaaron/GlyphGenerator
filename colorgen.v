`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:51:25 09/11/2016 
// Design Name: 
// Module Name:    colorgen 
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
module colorgen(input bright,clock, input[10:0]pxcount,linecount, output reg[7:0]rgb
    );
parameter black = 8'b00000000,
			white = 8'b11111111,
			red = 8'b11100000,
			green = 8'b00011100,
			blue = 8'b00000011;
			
	//reg [7:0]random;
	//initial random =8'b11001101;
	
	always@(posedge clock)
	begin
	if(bright)begin
		 if(pxcount[10]^linecount[10]) //as per Peter's suggestion XORing the 5th bit of these
											  //two counters for a checkboard pattern
	     rgb<=pxcount[7:0];
	
		else if (pxcount[6]^linecount[6])
		  rgb<=linecount[10:3];
		
		
		else if (pxcount[3]^linecount[3])

		  rgb<=pxcount[10:3];
		else if (pxcount[1]^linecount[1])

		  rgb<={pxcount[10:7],linecount[10:7]};
		  else
			rgb<=white;
		

/*	random<={random[7:1],(random[7]^random[1])};
	if((random[4]^random[5])==1)
		rgb<=random;
	else
		rgb<=black;*/
end
	else
		rgb<=black;
	end


endmodule
