// Part 2 skeleton
/*KEY[1] (Plot) is pressed. KEY[2]
should cause the entire screen to be cleared to black (Black). Note that black corresponds to (0,0,0). KEY[0]
should be the system active low Resetn.*/
//`include "vga_adapter/vga_adapter.v"
//`include "vga_adapter/vga_address_translator.v"
//`include "vga_adapter/vga_controller.v"
//`include "vga_adapter/vga_pll.v"





module fill
	(
		SW,
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		KEY,		
			LEDR,// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,					//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);
	
	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;	
	input 	[9:0] 	SW;
	output [9:0] LEDR;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;			//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	wire go;
	assign go = ~KEY[1];
	
	wire clear;
	assign clear = ~KEY[2];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [7:0] x;  //0-159
	wire [6:0] y;  //0-119
	wire plot;
	wire ld_x, ld_y, enable;
	wire [4:0] counter;
	wire writeEn;
	wire deadFlag;
	wire [14:0] counter1;
	control c0(CLOCK_50,go, clear, resetn, plot , writeEn , ld_x, ld_y, deadFlag, counter,counter1);
	datapath d0(
    CLOCK_50,
    resetn,
	deadFlag,
	counter,
	counter1,
    SW [6:0],
	SW[9:7],
	writeEn,
    ld_x, ld_y, 
    x_o,
	y_o,
	c_o
    );
	wire [7:0] x_o;
	wire [6:0] y_o;
	wire [2:0] c_o; 
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(c_o),
			.x(x_o),
			.y(y_o),
			.plot(plot),
	//Signals for the DAC to drive the monitor
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif"; // black.mif fille
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	
	
endmodule

module control(input  clk, go, input clear, resetn, output reg plot , enable , ld_x, ld_y, deadFlag, output reg [4:0] counter, output reg [14:0] counter1);
	localparam  S_LOAD_X        = 3'd0,
                S_LOAD_X_WAIT   = 3'd1,
                S_LOAD_Y        = 3'd2,
				S_LOAD_Y_WAIT   = 3'd3,
                S_CYCLE_0       = 3'd4,
				S_CYCLE_1       = 3'd5;
	reg [2:0] current_state, next_state; 
	always@(*)
		begin: state_table 
				case (current_state)

					S_LOAD_X: 		next_state = !clear ? (go ? S_LOAD_X_WAIT : S_LOAD_X): S_CYCLE_1; // Loop in current state until value is input
					S_LOAD_X_WAIT: 	next_state = go ? S_LOAD_X_WAIT : S_LOAD_Y; // Loop in current state until go signal goes low
					S_LOAD_Y: 		next_state = !clear ? (go ? S_LOAD_Y_WAIT : S_LOAD_Y): S_CYCLE_1; // Loop in current state until value is input
					S_LOAD_Y_WAIT: 	next_state = go ? S_LOAD_Y_WAIT : S_CYCLE_0; // Loop in current state until go signal goes low
					S_CYCLE_0: 		next_state = !clear ?( ( counter==5'd16 ) ? S_LOAD_X : S_CYCLE_0 ) : S_CYCLE_1;
					S_CYCLE_1: 		next_state = (counter1==15'b111100010100000	) ? S_LOAD_X : S_CYCLE_1;
				default:     		next_state = S_LOAD_X;
			endcase
		end // state_table
		
		
	always @(*)
    begin
        ld_x = 1'b0;
        ld_y = 1'b0;
		enable = 1'b0;
		plot = 1'b0;
		deadFlag = 1'b0;
        case (current_state)
            S_LOAD_Y: begin
                ld_y = 1'b1;
                end
            S_LOAD_X: begin
                ld_x = 1'b1;
                end
            S_CYCLE_0: begin // Do A <- A * x 
				enable=1;
				plot=1;
            end
			S_CYCLE_1: begin // Do A <- A * x 
				deadFlag=1;
				plot=1;
            end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
		begin
            current_state <= S_LOAD_X;
			counter <= 4'b0000;
			counter1 <=15'b000000000000000;
		end
        else
		begin
			if( current_state == S_CYCLE_0) counter <= counter + 1;
			if( current_state == S_CYCLE_1) counter1 <= counter1 + 1;
            current_state <= next_state;
			if( current_state == S_LOAD_X) 
			begin
				counter <= 4'b0000;
				counter1 <=15'b000000000000000;
			end
		end
    end // state_FFS
endmodule
				
module datapath(
    input clk,
    input resetn,
	input deadFlag,
	input [4:0] counter,
	input [14:0] counter1,
    input [6:0] data_in,
	input [2:0] c,
	input enable,
    input ld_x, ld_y, 
    output reg [7:0] x_o,
	output reg [6:0] y_o,
	output reg [2:0] c_o
    );
	reg [7:0]x;
	reg [6:0]y;
    always@(posedge clk) begin
        if(!resetn) begin
            x_o [7:0] <= 8'b0; 
            y_o [6:0] <= 7'b0;
			c_o <= 0;
        end
        else begin
            if(ld_x)
                x [6:0] <= data_in [6:0]; // load alu_out if load_alu_out signal is high, otherwise load from data_in
            if(ld_y)
                y [6:0] <= data_in [6:0]; // load alu_out if load_alu_out signal is high, otherwise load from data_in
			if(enable)
			begin
				x_o  <= x + counter [1:0];
				y_o  <= y + counter [3:2];	
				c_o  <= c;
			end
			if(deadFlag)
			begin
				x_o <= counter1 [7:0];
				y_o <= counter1 [14:8];
				c_o <= 3'b000;
			end
        end	
    end
	
endmodule
			
				
				
				

