`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module m7432(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
    v7432 u1(SW[0], SW[1], SW[2], SW[3], SW[4], SW[5], SW[6], SW[7], LEDR[0], LEDR[1], LEDR[2], LEDR[3]);
endmodule

module v7432 (input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13, output pin3, pin6, pin8, pin11);
	assign pin3 = pin1 | pin2;  
	assign pin6 = pin4 | pin5;  
	assign pin8 = pin9 | pin10;  
	assign pin11 = pin12 | pin13;  
endmodule 