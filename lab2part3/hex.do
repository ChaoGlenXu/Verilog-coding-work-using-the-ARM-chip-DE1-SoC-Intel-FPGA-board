vlib work
vlog hexDisplay.v
vsim hexDisplay
log {/*}
add wave {/*}

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
run 10ns

force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 10ns

# 3
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 10ns

# 4
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
run 10ns

# 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
run 10ns

# 6
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
run 10ns

# 7
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
run 10ns

# 8
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
run 10ns

force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
run 10ns

force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
run 10ns

force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
run 10ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
run 10ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
run 10ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
run 10ns

force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
run 10ns
 
