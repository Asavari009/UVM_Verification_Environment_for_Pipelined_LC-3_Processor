# wave.do
# Auto-loads the decode_in interface signals and the Decode DUT's
# outputs into the Wave window, then runs the simulation to completion.
# Loaded automatically by `make p1_debug` (see Makefile's -do wave.do).

# decode_in signals (what the testbench is driving into Decode)
add wave -divider "decode_in"
add wave -radix hex   /hdl_top/decode_in_vif/clock
add wave -radix hex   /hdl_top/decode_in_vif/reset
add wave -radix hex   /hdl_top/decode_in_vif/enable_decode
add wave -radix hex   /hdl_top/decode_in_vif/Instr_dout
add wave -radix hex   /hdl_top/decode_in_vif/npc_in
add wave -radix binary /hdl_top/decode_in_vif/psr

# Decode DUT outputs (sanity check only - not verified until Project 2)
add wave -divider "decode_out (for P1)"
add wave -radix hex    /hdl_top/IR
add wave -radix binary /hdl_top/E_Control
add wave -radix hex    /hdl_top/npc_out
add wave -radix binary /hdl_top/Mem_Control
add wave -radix binary /hdl_top/W_Control

configure wave -namecolwidth 200
configure wave -valuecolwidth 100

run -all

coverage save p1.ucdb

wave zoom full
