`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module m7404(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    v7404 u0(SW[0], SW[1], SW[2],SW[3], SW[4], SW[5], LEDR[0], LEDR[1], LEDR[2], LEDR[3], LEDR[4], LEDR[5]   );
endmodule

module v7404 (input pin1, pin3, pin5, pin9, pin11, pin13, output pin2, pin4, pin6, pin8, pin10, pin12);
	assign pin2 = ~pin1;  
	assign pin4 = ~pin3;  
	assign pin6 = ~pin5;  
	assign pin8 = ~pin9;  
	assign pin10 = ~pin11;  
	assign pin12 = ~pin13;  	
endmodule 