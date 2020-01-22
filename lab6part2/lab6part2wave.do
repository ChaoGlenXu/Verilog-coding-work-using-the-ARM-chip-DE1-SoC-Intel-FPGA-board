vlib work
vlog poly_function.v
vsim poly_function
log {/*}
add wave {/*}

####################reset
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[0]} 0
run 10ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[0]} 1
run 10ns

####################load A
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
run 10ns

#####################load B
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
run 10ns
#################load C
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
run 10ns
###################load X
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
run 10ns
#################### go from cycle0 to cycle4
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
run 10ns



