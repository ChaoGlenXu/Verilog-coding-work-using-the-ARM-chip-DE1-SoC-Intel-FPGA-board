vlib work
vlog mux2to1.v
vsim mux2to1
log {/*}
add wave {/*}

force {SW[9]} 0
force {SW[0]} 0
force {SW[1]} 0
run 10ns

force {SW[9]} 0
force {SW[0]} 0
force {SW[1]} 1
run 10ns

# 3
force {SW[9]} 0
force {SW[0]} 1
force {SW[1]} 0
run 10ns

# 4
force {SW[9]} 0
force {SW[0]} 1
force {SW[1]} 1
run 10ns

# 5
force {SW[9]} 1
force {SW[0]} 0
force {SW[1]} 0
run 10ns

# 6
force {SW[9]} 1
force {SW[0]} 0
force {SW[1]} 1
run 10ns

# 7
force {SW[9]} 1
force {SW[0]} 1
force {SW[1]} 0
run 10ns

# 8
force {SW[9]} 1
force {SW[0]} 1
force {SW[1]} 1
run 10ns

