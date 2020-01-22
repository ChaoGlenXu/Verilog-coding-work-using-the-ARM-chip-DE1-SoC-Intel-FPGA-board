//`timescale 1ns / 1ns // `timescale time_unit/time_precision



module lab3part1(input [9:0]SW, output [1:0] LEDR );
	
	mux6to1 u1(
				.IN(SW[5:0]),
				.SELECT(SW[9:7]),
				.OUT(LEDR[0])
					);

endmodule 

module mux6to1( IN, SELECT, OUT);
		
	input [5:0] IN;
	input [2:0] SELECT;
	output reg OUT;
	
	always@(*)
		begin 
			case(SELECT[2:0])
				3'b000: OUT = IN[0];
				3'b001: OUT = IN[1];
				3'b010: OUT = IN[2];
				3'b011: OUT = IN[3];
				3'b100: OUT = IN[4];
				3'b101: OUT = IN[5];
				default: OUT = 1'b0;
			endcase
		end

endmodule


// for testing 
//module lab3part1 (input [9:0] SW, output [2:0] LEDR );
//
//	mux7To1 b1(SW[9:0], LEDR[0]);
//
//endmodule
//
//
//module mux7To1 (input [9:0] s, output reg out );
//
//	always @(*)
//		case(s[9:7])
//		3'b000: out = s[0];
//		3'b001: out = s[1];
//		3'b010: out = s[2];
//		3'b011: out = s[3];
//		3'b100: out = s[4];
//		3'b101: out = s[5];
//		3'b110: out = s[6];
//		default: out = 1;
//	endcase
//endmodule	
