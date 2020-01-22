vlib work
vlog Lab4Part2.v
vsim Lab4Part2
log {/*}
add wave {/*}

#sw9
#asright
#load left
#parallel load n
# 0ns 1 10ns -r 20ns #clock
force {SW[9]} 0 
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 1 
force {KEY[2]} 1 
force {KEY[1]} 1 
force {KEY[0]} 0 
run 10ns

force {SW[9]} 0 
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 1 
force {KEY[2]} 1 
force {KEY[1]} 1 
force {KEY[0]} 1 

run 10ns
##########################################
force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 1 
force {KEY[2]} 1 
force {KEY[1]} 1 
force {KEY[0]} 0 
run 10ns

force {SW[9]} 1 
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 1 
force {KEY[2]} 1 
force {KEY[1]} 1 
force {KEY[0]} 1 

run 10ns
##########################################
force {SW[9]} 1 
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 1 
force {KEY[2]} 1 
force {KEY[1]} 1 
force {KEY[0]} 0 

run 10ns

force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 1 
force {KEY[2]} 1 
force {KEY[1]} 1 
force {KEY[0]} 1
run 10ns
########################################
force {SW[9]} 1 
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[3]} 1 
force {KEY[2]} 1 
force {KEY[1]} 1 
force {KEY[0]} 0 
run 10ns

force {SW[9]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
force {KEY[3]} 1 
force {KEY[2]} 1 
force {KEY[1]} 1 
force {KEY[0]} 1
run 10ns
##################################################

