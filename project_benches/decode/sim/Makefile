#------------------------------------------------------------------------------
# Makefile - project_benches/decode/sim
#------------------------------------------------------------------------------

QUESTA_HOME ?= $(QUESTA_HOME)
UVM_HOME    ?= $(QUESTA_HOME)/verilog_src/uvm-1.1d/src
 
RTL_DIR   = ../rtl
IF_DIR    = ../../../verification_ip/interface_packages/decode_in_pkg
TB_DIR    = ../tb/testbench
TEST_DIR  = ../tb/tests/decode_test_pkg
 
SRC_FILES = \
  $(IF_DIR)/decode_in_if.sv \
  $(IF_DIR)/decode_in_driver_bfm.sv \
  $(IF_DIR)/decode_in_monitor_bfm.sv \
  $(IF_DIR)/decode_in_pkg.sv \
  $(TEST_DIR)/decode_test_pkg.sv \
  $(RTL_DIR)/data_defs.v \
  $(RTL_DIR)/Decode_Pipelined.v \
  $(TB_DIR)/hdl_top.sv \
  $(TB_DIR)/hvl_top.sv
 
UVM_TESTNAME ?= test_top
 
.PHONY: p1_debug clean
 
p1_debug:
	@test -f modelsim.ini || cp $(QUESTA_HOME)/modelsim.ini modelsim.ini
	MODELSIM=$$(pwd)/modelsim.ini QSIM_INI=$$(pwd)/modelsim.ini qrun -uvm \
	     +incdir+$(IF_DIR) \
	     +incdir+$(TEST_DIR) \
	     +incdir+$(RTL_DIR) \
	     $(SRC_FILES) \
	     -top hdl_top -top hvl_top \
	     +UVM_TESTNAME=$(UVM_TESTNAME) \
	     +acc \
	     +nowarn8887 \
	     -do wave.do \
	     -gui
 
clean:
	rm -rf work qrun.out *.log transcript wlft* *.wlf covhtmlreport modelsim.ini
