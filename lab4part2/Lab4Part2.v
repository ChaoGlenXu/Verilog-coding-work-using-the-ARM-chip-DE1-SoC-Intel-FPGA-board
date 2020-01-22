

//COMBINE TWO INTO ONE
module Lab4Part2(SW, KEY, LEDR , HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);//SW, KEY, LEDR , HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
	input [9:0]SW;
	input [3:0]KEY;
	output [7:0]LEDR;
	output [6:0]HEX0;
	output [6:0]HEX1;
	output [6:0]HEX2;
	output [6:0]HEX3;
	output [6:0]HEX4;
	output [6:0]HEX5;
	wire [7:0]W1;
	wire [7:0]W2;
	assign LEDR = W1;		
		ALU u1(SW[3:0], W1[3:0], KEY[3:1], W1[7:0], W2[7:0]);
		REGISTER u2(SW[9], W2[7:0], KEY[0], W1[7:0]);
	
		hexDecoder H0(SW[3], SW[2], SW[1], SW[0], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);
		hexDecoder H1(1'b0, 1'b0, 1'b0, 1'b0, HEX1[0], HEX1[1], HEX1[2], HEX1[3], HEX1[4], HEX1[5], HEX1[6]);
		hexDecoder H2(1'b0, 1'b0, 1'b0, 1'b0, HEX2[0], HEX2[1], HEX2[2], HEX2[3], HEX2[4], HEX2[5], HEX2[6]);
		hexDecoder H3(1'b0, 1'b0, 1'b0, 1'b0, HEX3[0], HEX3[1], HEX3[2], HEX3[3], HEX3[4], HEX3[5], HEX3[6]);
		hexDecoder H4(W1[3], W1[2], W1[1], W1[0], HEX4[0], HEX4[1], HEX4[2], HEX4[3], HEX4[4], HEX4[5], HEX4[6]);
		hexDecoder H5(W1[7], W1[6], W1[5], W1[4], HEX5[0], HEX5[1], HEX5[2], HEX5[3], HEX5[4], HEX5[5], HEX5[6]);
endmodule

module REGISTER (RESETb, D, CLK, Q);
	input RESETb;
	input [7:0]D;
	input CLK;
	output reg [7:0]Q;
	always@(negedge RESETb, posedge CLK)
		if(RESETb == 0)
			Q <= 0;
		else
			Q <= D;	
endmodule
//////////////////////////////////////////////////////////////
module ALU(A, B, ALUSelect, HOLD, ALUout);
	input [3:0]A,B;
	input [2:0]ALUSelect;
	input [7:0]HOLD;
	output reg [7:0]ALUout;
	wire [4:0]C1;
	Ripple_carry_adder_4bit r1(.A(A[3:0]),.B(B[3:0]),.S(C1[3:0]),.Cin(1'b0),.Cout(C1[4]));
	always@(*)	
		case (ALUSelect[2:0])
			3'b111: ALUout = {3'b000, C1};
			3'b110: ALUout = A + B;
			3'b101: ALUout = {~(A & B) , ~(A ^ B)};
			3'b100: ALUout =  (| {A,B} ) ? 8'b11110000 : 8'b00000000; //reduction OR operator
			3'b011: ALUout = ((A[1]&~A[2]&~A[3]&~A[0]) | (~A[1]&A[2]&~A[3]&~A[0]) | (~A[1]&~A[2]&A[3]&~A[0]) | (~A[1]&~A[2]&~A[3]&A[0])) & ((~B[1]&~B[2]&B[3]&B[0]) | (B[1]&~B[2]&~B[3]&B[0])| (~B[1]&B[2]&~B[3]&B[0]) | (~B[1]&B[2]&B[3]&~B[0]) | (B[1]&~B[2]&B[3]&~B[0]) | (B[1]&B[2]&~B[3]&~B[0])) ? (8'b11110000) : (8'b00000000);
			3'b010: ALUout = {A[3:0],~B[3:0]};
			3'b001: ALUout = HOLD;
			default: ALUout = 8'b00000000;
		endcase
endmodule

module Ripple_carry_adder_4bit(A,B,S,Cin,Cout);
	input [3:0]A,B;
	input Cin;
	output [3:0]S;
	output Cout;
	wire C1,C2,C3;
	FullAdder FA0(A[0],B[0],Cin,S[0],C1);
	FullAdder FA1(A[1],B[1],C1,S[1],C2);
	FullAdder FA2(A[2],B[2],C2,S[2],C3);
	FullAdder FA3(A[3],B[3],C3,S[3],Cout);
endmodule

module FullAdder(x,y,cin,s,cout);
	input x,y;
	input cin;
	output s;
	output cout;
	assign s = cin ^ x ^ y;
	assign cout =  (x&cin) |  (x&y) |  (y&cin) ;
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


//module Lab4Part2(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
//	input [3:0]KEY;
//	input [9:0]SW;
//	output [7:0]LEDR;
//	output [6:0]HEX0;
//	output [6:0]HEX1;
//	output [6:0]HEX2;
//	output [6:0]HEX3;
//	output [6:0]HEX4;
//	output [6:0]HEX5;
//		ALU_REGISTER(SW[9], KEY[0], KEY[3:1], SW[3:0], LEDR[7:0], HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
//endmodule
//////////////////////////////////////////////////////////////////////
//module ALU_REGISTER(RESETb, CLK, ALUselect, DATA, ALUout, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
//	input RESETb;
//	input CLK;
//	input [3:1]ALUselect;
//	input [3:0]DATA;
//	output [7:0]ALUout;
//	output [6:0]HEX0;
//	output [6:0]HEX1;
//	output [6:0]HEX2;
//	output [6:0]HEX3;
//	output [6:0]HEX4;
//	output [6:0]HEX5;
//	wire [7:0]W1;
//	wire [7:0]W2;
//	//assign HEX1 = 7'b0000000;
//	//assign HEX2 = 7'b0000000;
//	//assign HEX3 = 7'b0000000;
//	assign ALUout = W1;
//		REGISTER u2(RESETb, W2[7:0], CLK, W1[7:0]);
//		ALU u1(DATA[3:0], W1[3:0], ALUselect[3:1], W1[7:0], W2[7:0]);
//		
//		hex_decode H0(DATA[0], DATA[1], DATA[2], DATA[3], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);
//		hex_decode H1(1'b0, 1'b0, 1'b0, 1'b0, HEX1[0], HEX1[1], HEX1[2], HEX1[3], HEX1[4], HEX1[5], HEX1[6]);
//		hex_decode H2(1'b0, 1'b0, 1'b0, 1'b0, HEX2[0], HEX2[1], HEX2[2], HEX2[3], HEX2[4], HEX2[5], HEX2[6]);
//		hex_decode H3(1'b0, 1'b0, 1'b0, 1'b0, HEX3[0], HEX3[1], HEX3[2], HEX3[3], HEX3[4], HEX3[5], HEX3[6]);
//		hex_decode H4(W1[0], W1[1], W1[2], W1[3], HEX4[0], HEX4[1], HEX4[2], HEX4[3], HEX4[4], HEX4[5], HEX4[6]);
//		hex_decode H5(W1[4], W1[5], W1[6], W1[7], HEX5[0], HEX5[1], HEX5[2], HEX5[3], HEX5[4], HEX5[5], HEX5[6]);
//	//	DISPLAY u6(DATA[3:0], W1[7:0], HEX0[6:0], HEX1[6:0], HEX2[6:0], HEX3[6:0], HEX4[6:0], HEX5[6:0], ALUout[7:0]);
//endmodule


//////////////////////////////////////////////////////////////////////
//module DISPLAY(DATA, IN, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, ALUout);
//	input [3:0]DATA;
//	input [7:0]IN;
//	output [6:0]HEX0;
//	output [6:0]HEX1;
//	output [6:0]HEX2;
//	output [6:0]HEX3;
//	output [6:0]HEX4;
//	output [6:0]HEX5;
//	output [7:0]ALUout;
//	//assign HEX4 = {4'b0000, IN[3:0]};
//	//assign HEX5 = {IN[7:4], 4'b0000};
//	hex_decode h0(DATA[0],DATA[1],DATA[2],DATA[3],HEX0[0],HEX0[1],HEX0[2],HEX0[3],HEX0[4],HEX0[5],HEX0[6]);
//	hex_decode h1(1'b0,1'b0,1'b0,1'b0,HEX1[0],HEX1[1],HEX1[2],HEX1[3],HEX1[4],HEX1[5],HEX1[6]);
//	hex_decode h2(1'b0,1'b0,1'b0,1'b0,HEX2[0],HEX2[1],HEX2[2],HEX2[3],HEX2[4],HEX2[5],HEX2[6]);
//	hex_decode h3(1'b0,1'b0,1'b0,1'b0,HEX3[0],HEX3[1],HEX3[2],HEX3[3],HEX3[4],HEX3[5],HEX3[6]);
//	hex_decode h4(IN[0],IN[1],IN[2],IN[3],HEX4[0],HEX4[1],HEX4[2],HEX4[3],HEX4[4],HEX4[5],HEX4[6]);
//	hex_decode h5(IN[4],IN[5],IN[6],IN[7],HEX5[0],HEX5[1],HEX5[2],HEX5[3],HEX5[4],HEX5[5],HEX5[6]);
//	assign ALUout = IN;
//endmodule
//////////////////////////////////////////////////////////////////////


//module hex_decode(C0,C1,C2,C3,F0,F1,F2,F3,F4,F5,F6);
//	input C0,C1,C2,C3;
//	output F0,F1,F2,F3,F4,F5,F6;
//	assign F0 = C0&~C1&~C2&~C3 | ~C3&C2&~C1&~C0 | C3&C2&~C1&C0 | C3&~C2&C1&C0;
//	assign F1 = C0&~C1&C2&~C3 | ~C0&C1&C2&~C3 | C0&C1&~C2&C3 | ~C0&~C1&C2&C3 | ~C0&C1&C2&C3 | C0&C1&C2&C3;
//	assign F2 = ~C0&C1&~C2&~C3 | ~C0&~C1&C2&C3 | C0&C1&C2&C3 | ~C0&C1&C2&C3;
//	assign F3 = C0&~C1&~C2&~C3 | ~C0&~C1&C2&~C3 | C0&C1&C2&~C3 | ~C0&C1&~C2&C3 | C0&C1&C2&C3;
//	assign F4 = C0&~C1&~C2&~C3 | C0&C1&~C2&~C3 | ~C0&~C1&C2&~C3 | C0&~C1&C2&~C3 | C0&C1&C2&~C3 | C0&~C1&~C2&C3;
//	assign F5 = C0&~C1&~C2&~C3 | ~C0&C1&~C2&~C3 | C0&C1&~C2&~C3 | C0&C1&C2&~C3 | C0&~C1&C2&C3;
//	assign F6 = ~C0&~C1&~C2&~C3 | C0&~C1&~C2&~C3 | C0&C1&C2&~C3 | ~C0&~C1&C2&C3;
//endmodule   
