//`timescale 1ns / 1ns // `timescale time_unit/time_precision





///////////////////////////////////
module lab3part2 (SW, LEDR);
	input [8:0]SW;
	output [9:0]LEDR;	
	FourRCA u4(.IN(SW[8:0]), .OUT(LEDR[9:0]) );
endmodule 

module FourRCA (IN, OUT);
	input [8:0]IN;
	output [9:0]OUT;
	wire W1, W2, W3;
		FA u0 (IN[8], IN[4], IN[0], OUT[0], W1 );
		FA u1 (W1, IN[5], IN[1], OUT[1], W2 );
		FA u2 (W2, IN[6], IN[2], OUT[2], W3 );
		FA u3 (W3, IN[7], IN[3], OUT[3], OUT[9] );
endmodule 

module FA ( input ci, a, b, output s, co );
	assign co = (~b & a & ci) | (b & ~a & ci) | (b & a & ~ci) | (b & a & ci);
	assign s = (~b & ~a & ci) | (~b & a & ~ci) | (b & ~a & ~ci) | (b & a & ci);
endmodule 

