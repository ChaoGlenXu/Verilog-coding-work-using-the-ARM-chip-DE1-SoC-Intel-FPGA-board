
module lab5part3(CLOCK_50, SW, KEY, LEDR);
	input CLOCK_50;
	input [2:0]SW;
	input [1:0]KEY;
	output [1:0]LEDR;
	morse u4(KEY[1], CLOCK_50, KEY[0], SW[2:0], LEDR[0] );
endmodule

module morse(key1, clock, resetn, select, Q0 );
	input key1;
	input clock;
//	input enable;
	input resetn;
	input [2:0]select;
	output Q0;
	//wire W1;
	wire [26:0]W4;
	wire W2;
	wire [12:0]W3;
	//wire [12:0]W5;
	
	//assign Q = (count == 0) ? 1 : 0;
	down_counter u1(clock, resetn,key1, W4 );
	assign W2 = (W4 == 0) ? 1 : 0;
	//assign W1 = key1 & W2;
	mux_morse u2(select, W3);
	shift_with_n u3(W2, key1, clock, resetn, W3, Q0);
	//assign Q0 = W5[0];
endmodule	

//module down_counter(clock, key1enable, Q );
//	input clock;
//	input key1enable;
//	output Q;
//	//reg [26:0]frequency = 27'b101111101011110000011111111;
//	reg [26:0]count = 0;
//		always@(posedge clock)
//		if(key1enable)
//		begin
//			if(count == 27'b0)
//				count <= 27'b101111101011110000011111111;
//			else
//				count <= count - 1;
//		end	
//	assign Q = (count == 0) ? 1 : 0;
//endmodule   
module down_counter(clock, clear, enable, Q);
	input clock;
	input clear;
	input enable;
	output reg[26:0]Q;
		always@(posedge clock)
		if(clear == 0)
			Q <= 0;
		else if(enable == 1'b1)
		begin
			if(Q == 0)
				Q <= 24999999;//27'b101111101011110000011111111;
			else
				Q <= Q - 1;
		end	
			
endmodule                                                                                                    

////////////////////////////////////////////////////////////////////////////
module shift_with_n(enable, parallel_load_n, clock, reset_n, data_in, out);
	input enable;
	input parallel_load_n;
	input clock;	
	input reset_n;
	input [12:0] data_in;
	 reg [12:0] Q;
	 output out;
	always@(posedge clock)
		begin //start
			if(reset_n == 0)
				Q <= 0;
			else if(parallel_load_n == 0)
		    	Q <= data_in;	
			else if (enable == 1);
				begin//555
				Q[0] <= Q[1];
				Q[1] <= Q[2];
				Q[2] <= Q[3];
				Q[3] <= Q[4];
				Q[4] <= Q[5];
				Q[5] <= Q[6];
				Q[6] <= Q[7];
				Q[7] <= Q[8];
				Q[8] <= Q[9];
				Q[9] <= Q[10];
				Q[10] <= Q[11];
				Q[11] <= Q[12];
				Q[12] <= 0;
			   end//555		
		end//start	
		assign out = Q[0];
endmodule

//module shift_reg(clock, resetn, data, enable, Q );
//	input clock;
//	input resetn;
//	input [12:0]data;
//	input enable;
//	output reg [12:0]Q;	
//	always@( posedge clock)//negedge resetn,
//	begin//1st
//		if(resetn == 0)
//			Q[0] <= 0;
//		else if(enable == 0)	
//				begin//b
//				Q[0] <= data[0];
//				Q[1] <= data[1];
//				Q[2] <= data[2];
//				Q[3] <= data[3];
//				Q[4] <= data[4];
//				Q[5] <= data[5];
//				Q[6] <= data[6];
//				Q[7] <= data[7];
//				Q[8] <= data[8];
//				Q[9] <= data[9];
//				Q[10] <= data[10];
//				Q[11] <= data[11];
//				Q[12] <= data[12];
//				end//b
//		else if(enable == 1)
//				begin//c
//				Q[0] <= Q[1];
//				Q[1] <= Q[2];
//				Q[2] <= Q[3];
//				Q[3] <= Q[4];
//				Q[4] <= Q[5];
//				Q[5] <= Q[6];
//				Q[6] <= Q[7];
//				Q[7] <= Q[8];
//				Q[8] <= Q[9];
//				Q[9] <= Q[10];
//				Q[10] <= Q[11];
//				Q[11] <= Q[12];		
//				end//d	
//	end//1st
//endmodule

module mux_morse(select, mux_out);
	input [2:0]select;
	output reg [12:0]mux_out;	
	always@(*)
		case(select[2:0])
			3'b000: mux_out <= 13'b0000000000101;
			3'b001: mux_out <= 13'b1110111011101;
			3'b010: mux_out <= 13'b0000111010111;
			3'b011: mux_out <= 13'b0000101011101;
			3'b100: mux_out <= 13'b0000001110111;
			3'b101: mux_out <= 13'b0000000010111;
			3'b110: mux_out <= 13'b0011101110111;
			3'b111: mux_out <= 13'b0010111011101;
		endcase
endmodule


//module shift_reg(clock, resetn, data, enable, Q );
//	input clock;
//	input resetn;
//	input [12:0]data;
//	input enable;
//	output reg [12:0]Q;	
//	always@(negedge resetn, posedge clock)
//	begin//1st
//		if(resetn == 0)
//			begin//a
//			Q[0] <= 0;
//			Q[1] <= 0;
//			Q[2] <= 0;
//			Q[3] <= 0;
//			Q[4] <= 0;
//			Q[5] <= 0;
//			Q[6] <= 0;
//			Q[7] <= 0;
//			Q[8] <= 0;
//			Q[9] <= 0;
//			Q[10] <= 0;
//			Q[11] <= 0;
//			Q[12] <= 0;
//			end//a
//		else
//			begin//2nd
//			if(enable == 0)
//				begin//b
//				Q[0] <= data[0];
//				Q[1] <= data[1];
//				Q[2] <= data[2];
//				Q[3] <= data[3];
//				Q[4] <= data[4];
//				Q[5] <= data[5];
//				Q[6] <= data[6];
//				Q[7] <= data[7];
//				Q[8] <= data[8];
//				Q[9] <= data[9];
//				Q[10] <= data[10];
//				Q[11] <= data[11];
//				Q[12] <= data[12];
//				end//b
//			else //if(enable == 1)
//				begin//c
//				Q[0] <= Q[1];
//				Q[1] <= Q[2];
//				Q[2] <= Q[3];
//				Q[3] <= Q[4];
//				Q[4] <= Q[5];
//				Q[5] <= Q[6];
//				Q[6] <= Q[7];
//				Q[7] <= Q[8];
//				Q[8] <= Q[9];
//				Q[9] <= Q[10];
//				Q[10] <= Q[11];
//				Q[11] <= Q[12];		
//				end//d
//			end//2nd
//	end//1st
//endmodule



