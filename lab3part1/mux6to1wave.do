vlib work
vlog lab3part1.v
vsim lab3part1
log {/*}
add wave {/*}

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
force {SW[0]} 0
run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 1
force {SW[1]} 0
run 10ns

# 3
force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 0
force {SW[2]} 0
run 10ns

# 4
force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 1
force {SW[3]} 0
run 10ns

# 5
force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 0
force {SW[4]} 0
run 10ns

# 6
force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 1
force {SW[5]} 0
run 10ns

# 6 pairs again for 1
# 1
force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
force {SW[0]} 1
run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 1
force {SW[1]} 1
run 10ns

# 3
force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 0
force {SW[2]} 1
run 10ns

# 4
force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 1
force {SW[3]} 1
run 10ns

# 5
force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 0
force {SW[4]} 1
run 10ns

# 6
force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 1
force {SW[5]} 1
run 10ns
 

