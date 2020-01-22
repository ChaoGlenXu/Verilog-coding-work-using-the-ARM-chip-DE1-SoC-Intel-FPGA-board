vlib work
vlog sequence_detector.v
vsim sequence_detector
log {/*}
add wave {/*}

force {SW[0]} 0
force {SW[1]} 0
force {KEY[0]} 0
run 10ns

force {SW[0]} 0
force {SW[1]} 0
force {KEY[0]} 1
run 10ns

# 3
force {SW[0]} 0
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

# 4
force {SW[0]} 0
force {SW[1]} 1
force {KEY[0]} 1
run 10ns

################TO B
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 1
run 10ns
################TO C
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 1
run 10ns
################TO D
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 1
run 10ns
################TO F
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 1
run 10ns
################TO E
force {SW[0]} 1
force {SW[1]} 0
force {KEY[0]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 0
force {KEY[0]} 1
run 10ns
################TO G 
force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[0]} 1
force {SW[1]} 1
force {KEY[0]} 1
run 10ns
################TO A
force {SW[0]} 0
force {SW[1]} 1
force {KEY[0]} 0
run 10ns

force {SW[0]} 0
force {SW[1]} 1
force {KEY[0]} 1
run 10ns


