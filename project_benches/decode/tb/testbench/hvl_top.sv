//-----------------------------------------------------------------------------
// hvl_top.sv
// HVL-side top level: imports the UVM class 
//-----------------------------------------------------------------------------
`timescale 1ns/1ps

module hvl_top;

  // imports all the packages and initialises the run_test
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import decode_in_pkg::*;
  import decode_test_pkg::*;

  initial run_test();

endmodule : hvl_top
