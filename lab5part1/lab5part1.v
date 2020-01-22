
module lab5part1(KEY, SW, HEX0, HEX1);
	input [1:0]KEY;
	input [1:0]SW;
	output [6:0]HEX0;
	output [6:0]HEX1;
	wire [7:0] Q;
	
	counter8bit c1(SW[0], SW[1], KEY[0], Q);
	hexDecoder h0(Q[3], Q[2], Q[1], Q[0], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);
	hexDecoder h1(Q[7], Q[6], Q[5], Q[4], HEX1[0], HEX1[1], HEX1[2], HEX1[3], HEX1[4], HEX1[5], HEX1[6]);

endmodule

module counter8bit(CLEAR, ENABLE, CLOCK, Q);
	input CLEAR;
	input ENABLE;
	input CLOCK;
	output [7:0]Q;
	wire W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14;
	
	assign W2 = ENABLE & W1;
	assign W4 = W2 & W3;
	assign W6 = W4 & W5;
	assign W8 = W6 & W7;
	assign W10 = W8 & W9;
	assign W12 = W10 & W11;
	assign W14 = W12 & W13;
	
	assign Q[0] = W1;
	assign Q[1] = W3;
	assign Q[2] = W5;
	assign Q[3] = W7;
	assign Q[4] = W9;
	assign Q[5] = W11;
	assign Q[6] = W13;
	//assign Q[6] = W1;

	T_FF f0(CLEAR, ENABLE, CLOCK, W1);
	T_FF f1(CLEAR, W2, CLOCK, W3);	
	T_FF f2(CLEAR, W4, CLOCK, W5);
	T_FF f3(CLEAR, W6, CLOCK, W7);
	T_FF f4(CLEAR, W8, CLOCK, W9);
	T_FF f5(CLEAR, W10, CLOCK, W11);
	T_FF f6(CLEAR, W12, CLOCK, W13);
	T_FF f7(CLEAR, W14, CLOCK, Q[7]);
	
endmodule 

module T_FF(CLEAR, T, CLOCK, Q );//NOT_Q
	input CLEAR;
	input T;
	input CLOCK;
	output reg Q;
	//output reg NOT_Q;//not sure if reg or not 
		
	always@(negedge CLEAR, posedge CLOCK)begin
		if (CLEAR == 0)
				Q <= 0;
		else if(T)
			 Q <= ~Q;
		end
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

//module D_FF(CLEAR, T, CLOCK, Q NOT_Q);//NOT_Q
//	input CLEAR;
//	input T;
//	input CLOCK;
//	output reg Q;
//	output reg NOT_Q;//not sure if reg or not 
//		
//	always@(negedge CLEAR, posedge CLOCK)begin
//		if (CLEAR == 0)
//				Q <= 0;
//		else if(T)
//			 Q <= ~Q;
//		end
//endmodule

