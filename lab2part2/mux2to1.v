`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

//module mux2to1(LEDR, SW);
//    input [9:0] SW;
//    output [9:0] LEDR;
//
//    mux2TO1 u0(
//        .x(SW[0]),
//        .y(SW[1]),
//        .s(SW[9]),
//        .m(LEDR[0])
//        );
//endmodule
/////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////
//module mux2TO1(x, y, s, m);
//    input x; //select 0
//    input y; //select 1
//    input s; //select signal
//    output m; //output
//	 wire w1, w2, w3;
//	
//	v7404 b1(
//		.pin1(S),
//		.pin2(w1)
//		);
//
//	v7408 b2(
//		.pin1(x),
//		.pin2(w1),
//		.pin3(w2),
//		.pin4(s),
//		.pin5(y),
//		.pin6(w3)
//		);
//
//	v7432 b3(
//		.pin1(w2),
//		.pin2(w3),
//		.pin3(m)
//		);
//	
//
//endmodule

module mux2to1 (LEDR, SW);
	input [9:0] SW;
	output [9:0] LEDR;
	wire wA, wB, wC;

	v7404 b1(
		.pin1(SW[9]),
		.pin2(wA)
		);

	v7408 b2(
		.pin1(SW[1]),
		.pin2(SW[9]),
		.pin3(wB),
		
		.pin8(wC),
		.pin9(wA),
		.pin10(SW[0])
		);

	v7432 b3(
		.pin4(wB),
		.pin5(wC),
		.pin6(LEDR[0])
		);

endmodule

module v7432(input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13, output pin3, pin6, pin8, pin11);
	assign pin3 = pin1 | pin2;  
	assign pin6 = pin4 | pin5;  
	assign pin8 = pin9 | pin10;  
	assign pin11 = pin12 | pin13;  
endmodule 

module v7408(input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13, output pin3, pin6, pin8, pin11);
	assign pin3 = pin1 & pin2;  
	assign pin6 = pin4 & pin5;  
	assign pin8 = pin9 & pin10;  
	assign pin11 = pin12 & pin13;  
endmodule 

module v7404(input pin1, pin3, pin5, pin9, pin11, pin13, output pin2, pin4, pin6, pin8, pin10, pin12);
	assign pin2 = ~pin1;  
	assign pin4 = ~pin3;  
	assign pin6 = ~pin5;  
	assign pin8 = ~pin9;  
	assign pin10 = ~pin11;  
	assign pin12 = ~pin13;  	
endmodule 

