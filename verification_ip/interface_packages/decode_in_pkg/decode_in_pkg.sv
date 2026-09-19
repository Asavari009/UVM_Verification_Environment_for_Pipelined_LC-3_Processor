//-----------------------------------------------------------------------------
// decode_in_pkg.sv
//-----------------------------------------------------------------------------
package decode_in_pkg;

	  // importing the UVM package
	  // including all the decode_in files from environment
	  import uvm_pkg::*;
	  `include "uvm_macros.svh"

	  `include "decode_in_transaction.sv"
	  `include "decode_in_sequence_base.sv"
	  `include "decode_in_random_sequence.sv"
	  `include "decode_in_agent_config.sv"
	  `include "decode_in_driver.sv"
	  `include "decode_in_monitor.sv"
	  `include "decode_in_coverage.sv"
	  `include "decode_in_agent.sv"

endpackage : decode_in_pkg
