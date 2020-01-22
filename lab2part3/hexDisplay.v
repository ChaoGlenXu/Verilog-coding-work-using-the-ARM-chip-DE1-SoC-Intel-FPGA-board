`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module hexDisplay (input [9:0] SW, output [6:0] HEX0);
	hexDecoder u1(SW[3], SW[2], SW[1], SW[0], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);
endmodule

module hexDecoder (input a, b, c, d, output f0, f1, f2, f3, f4, f5, f6);
	assign f0 = (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (a & ~b & c & d) | (a & b & ~c & d) ;
	assign f1 = (~a & b & ~c & d) | (~a & b & c & ~d) | (a & ~b & c & d) | (a & b & ~c & ~d) | (a & b & c & ~d) | (a & b & c & d) ;
	assign f2 = (~a & ~b & c & ~d) | (a & b & ~c & ~d) | (a & b & c & ~d) | (a & b & c & d) ;
	assign f3 = (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (~a & b & c & d) | (a & ~b & c & ~d) | (a & b & c & d);
	assign f4 = (~a & ~b & ~c & d) | (~a & ~b & c & d) | (~a & b & ~c & ~d) | (~a & b & ~c & d) | (~a & b & c & d) | (a & ~b & ~c & d);
	assign f5 = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & ~b & c & d) | (~a & b & c & d) | (a & b & ~c & d);
	assign f6 = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & b & c & d) | (a & b & ~c & ~d);
endmodule
