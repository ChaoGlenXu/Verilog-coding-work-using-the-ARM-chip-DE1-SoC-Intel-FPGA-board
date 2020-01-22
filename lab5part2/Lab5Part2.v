
module Lab5Part2(CLOCK_50, SW, HEX0);
	input CLOCK_50;
	input [1:0]SW;
	output [6:0]HEX0;
	
	counter_with_speed_control b1(CLOCK_50, SW, HEX0 );
endmodule

module counter_with_speed_control(clock, select, hex0 );
	input clock;
	input [1:0]select;
	output [6:0]hex0;
	wire [26:0]W1; 
	wire W2;
	wire [3:0]W3;
	alu_speed u1(select, W1);
	rate_divide_counter u2(clock, W1, W2);
	counter u3 (clock, W2, W3);
	hexDecoder u4(W3[3],W3[2], W3[1], W3[0], hex0[0], hex0[1], hex0[2], hex0[3], hex0[4], hex0[5], hex0[6]);
endmodule 
/////////////////////////////////////////////////////////
module alu_speed(select,mux_out);
	input [1:0]select;
	output reg[26:0]mux_out;
	always@(*)
		case (select[1:0])
			2'b00: mux_out = 0;
			2'b01: mux_out = 27'b001011111010111100000111111;
			2'b10: mux_out = 27'b010111110101111000001111111;
			2'b11: mux_out = 27'b101111101011110000011111111;
		endcase
endmodule

module rate_divide_counter(clock, D, Enable);
	input clock;
	input [26:0]D;
	 reg [26:0]Q = 0;
	output Enable;
	//assign q_middle = D;
	
	always@(posedge clock)
		begin
			if( Q == 27'b0  )
				Q <= D;
			else 
				Q <= Q - 1;
		end
	assign Enable = (Q ==0) ? 1 : 0;
endmodule

module counter(clock, Enable,  cout);
	input clock;
	input Enable;
	output reg [3:0]cout;
	
	always@(posedge clock)
	begin
		if(Enable)
			cout <= cout + 1;
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

//module Lab5Part1(SW, KEY, LEDR );
//	input [9:0]SW;
//	input [3:0]KEY;
//	output [7:0]LEDR;
//	shift_with_n u1(SW[9], KEY[0], KEY[1], KEY[2], KEY[3], SW[7:0], LEDR[7:0] );
//endmodule
//////////////////////////////////////////////////////////////////////////////
//module shift_with_n(reset_n, clock, parallel_load_n, load_left, ASRight, data_in, Q);
//	//parameter n = 7;
//	input reset_n;
//	input clock;
//	input parallel_load_n;
//	input load_left;
//	input ASRight;
//	input [7:0] data_in;
//	output reg [7:0] Q;
//	
//	always@(posedge clock)
//		begin //start
//			if(reset_n == 1)
//				begin//1st 
//					if(parallel_load_n == 1)
//						begin//2nd
//							if(load_left == 1)//left
//								begin//555
//								Q[0] <= Q[1];
//								Q[1] <= Q[2];
//								Q[2] <= Q[3];
//								Q[3] <= Q[4];
//								Q[4] <= Q[5];
//								Q[5] <= Q[6];
//								Q[6] <= Q[7];
//								//end//555
//								//ASRIGHT
//								//begin//!1ST
//									if(ASRight == 1)
//										Q[7] <= Q[7];
//									else
//										Q[7] <= Q[0];
//								end//!1ST
//							else if(load_left == 0)//right
//								begin//333
//								Q[7] <= Q[6]; 
//								Q[6] <= Q[5];
//								Q[5] <= Q[4]; 	
//								Q[4] <= Q[3];
//								Q[3] <= Q[2];
//								Q[2] <= Q[1];
//								Q[1] <= Q[0];
//								Q[0] <= Q[7]; 
//								end//333
//						end//2nd
//					else
//						Q <= data_in;
//					//end
//				end//1st
//			else
//				Q <= 0;
//		end//start
//	
//endmodule

//module Lab5Part1(KEY, SW, HEX0, HEX1);
//	input [1:0]KEY;
//	input [1:0]SW;
//	output [6:0]HEX0;
//	output [6:0]HEX1;
//	wire [7:0] Q;
//	
//	counter8bit c1(SW[0], SW[1], KEY[0], Q);
//	hexDecoder h0(Q[3], Q[2], Q[1], Q[0], HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], HEX0[6]);
//	hexDecoder h1(Q[7], Q[6], Q[5], Q[4], HEX1[0], HEX1[1], HEX1[2], HEX1[3], HEX1[4], HEX1[5], HEX1[6]);
//
//endmodule
//
//module counter8bit(CLEAR, ENABLE, CLOCK, Q);
//	input CLEAR;
//	input ENABLE;
//	input CLOCK;
//	output [7:0]Q;
//	wire W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14;
//	
//	assign W2 = ENABLE & W1;
//	assign W4 = W2 & W3;
//	assign W6 = W4 & W5;
//	assign W8 = W6 & W7;
//	assign W10 = W8 & W9;
//	assign W12 = W10 & W11;
//	assign W14 = W12 & W13;
//	
//	assign Q[0] = W1;
//	assign Q[1] = W3;
//	assign Q[2] = W5;
//	assign Q[3] = W7;
//	assign Q[4] = W9;
//	assign Q[5] = W11;
//	assign Q[6] = W13;
//	//assign Q[6] = W1;
//
//	T_FF f0(CLEAR, ENABLE, CLOCK, W1);
//	T_FF f1(CLEAR, W2, CLOCK, W3);	
//	T_FF f2(CLEAR, W4, CLOCK, W5);
//	T_FF f3(CLEAR, W6, CLOCK, W7);
//	T_FF f4(CLEAR, W8, CLOCK, W9);
//	T_FF f5(CLEAR, W10, CLOCK, W11);
//	T_FF f6(CLEAR, W12, CLOCK, W13);
//	T_FF f7(CLEAR, W14, CLOCK, Q[7]);
//	
//endmodule 
//
//module T_FF(CLEAR, T, CLOCK, Q );//NOT_Q
//	input CLEAR;
//	input T;
//	input CLOCK;
//	output reg Q;
//	//output reg NOT_Q;//not sure if reg or not 
//		
//	always@(negedge CLEAR, posedge CLOCK)begin
//		if (CLEAR == 0)
//				Q <= 0;
//		else if(T)
//			 Q <= ~Q;
//		end
//endmodule
//
//module hexDecoder (input a, b, c, d, output f0, f1, f2, f3, f4, f5, f6);
//	assign f0 = (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (a & ~b & c & d) | (a & b & ~c & d) ;
//	assign f1 = (~a & b & ~c & d) | (~a & b & c & ~d) | (a & ~b & c & d) | (a & b & ~c & ~d) | (a & b & c & ~d) | (a & b & c & d) ;
//	assign f2 = (~a & ~b & c & ~d) | (a & b & ~c & ~d) | (a & b & c & ~d) | (a & b & c & d) ;
//	assign f3 = (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (~a & b & c & d) | (a & ~b & c & ~d) | (a & b & c & d);
//	assign f4 = (~a & ~b & ~c & d) | (~a & ~b & c & d) | (~a & b & ~c & ~d) | (~a & b & ~c & d) | (~a & b & c & d) | (a & ~b & ~c & d);
//	assign f5 = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & ~b & c & d) | (~a & b & c & d) | (a & b & ~c & d);
//	assign f6 = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & b & c & d) | (a & b & ~c & ~d);
//endmodule



//		if(q_middle == 0)
//			Q <= 1;
//		else if(D == 27'b001011111010111100000111111)
//			q_middle = q_middle - 1;
//		else if(D == 27'b010111110101111000001111111)
//			q_middle = q_middle - 1;
//		else if(D == 27'b101111101011110000011111111)
//			q_middle = q_middle - 1;
//

