module lab4part3(SW, KEY, LEDR );
	input [9:0]SW;
	input [3:0]KEY;
	output [7:0]LEDR;
	shift_with_n u1(SW[9], KEY[0], KEY[1], KEY[2], KEY[3], SW[7:0], LEDR[7:0] );
endmodule
////////////////////////////////////////////////////////////////////////////
module shift_with_n(reset_n, clock, parallel_load_n, load_left, ASRight, data_in, Q);
	//parameter n = 7;
	input reset_n;
	input clock;
	input parallel_load_n;
	input load_left;
	input ASRight;
	input [7:0] data_in;
	output reg [7:0] Q;
	
	always@(posedge clock)
		begin //start
			if(reset_n == 1)
				begin//1st 
					if(parallel_load_n == 1)
						begin//2nd
							if(load_left == 1)//left
								begin//555
								Q[0] <= Q[1];
								Q[1] <= Q[2];
								Q[2] <= Q[3];
								Q[3] <= Q[4];
								Q[4] <= Q[5];
								Q[5] <= Q[6];
								Q[6] <= Q[7];
								//end//555
								//ASRIGHT
								//begin//!1ST
									if(ASRight == 1)
										Q[7] <= Q[7];
									else
										Q[7] <= Q[0];
								end//!1ST
							else if(load_left == 0)//right
								begin//333
								Q[7] <= Q[6]; 
								Q[6] <= Q[5];
								Q[5] <= Q[4]; 	
								Q[4] <= Q[3];
								Q[3] <= Q[2];
								Q[2] <= Q[1];
								Q[1] <= Q[0];
								Q[0] <= Q[7]; 
								end//333
						end//2nd
					else
						Q <= data_in;
					//end
				end//1st
			else
				Q <= 0;
		end//start
	
endmodule


