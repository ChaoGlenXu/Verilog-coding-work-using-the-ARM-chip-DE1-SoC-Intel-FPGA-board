# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab3part3modified.v

#load simulation using mux as the top level simulation module
vsim lab3part3modified

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

// test the adder 
# 1st test case, expect output to be 0000
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
run 10ns

# 2nd test case, expect output to be 1111
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 1
run 10ns

#3rd test case, expect output to be 1101
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 1
run 10ns

#4th test case, expect the output to be 0111
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 1
run 10ns

#5 test case(test a and b), expect the output to be 1111, cout = 0
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0
force {SW[7]} 1
force {SW[8]} 0
run 10ns

#6 test case(test all c's) expect the output to be0000, cout = 1
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
run 10ns

////////////////////////////////////////////////////////////////
#7 expect output to be 1101
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 1
run 10ns

#8 expect the output to be 1111
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 1
force {SW[6]} 0
force {SW[7]} 1
force {SW[8]} 0
run 10ns

#9 expect the output to be 1111
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 0
run 10ns
//test case2//////////////////////////////////////////////////////

force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 0
run 10ns


force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 0
run 10ns

force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 0
run 10ns

force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[6]} 1
force {SW[7]} 1
force {SW[8]} 0
run 10ns

#14 cases
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0
force {SW[8]} 0
run 10ns

//////////////////////////////
