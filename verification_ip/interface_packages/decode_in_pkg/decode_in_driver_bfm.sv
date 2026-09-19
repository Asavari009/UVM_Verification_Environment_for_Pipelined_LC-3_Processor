//-----------------------------------------------------------------------------
// decode_in_driver_bfm.sv
// Driver BFM: implements decode_in protocol signaling. 
//-----------------------------------------------------------------------------
interface decode_in_driver_bfm (decode_in_if bus);
 
	  // Storage variables for procedural assignment
	  bit        reset_i;
	  bit        enable_decode_i;
	  bit [15:0] instr_dout_i;
	  bit [15:0] npc_in_i;
	  bit [2:0]  psr_i;
	 
	  // Values continually assigned to the output wires
	  assign bus.reset         = reset_i;
	  assign bus.enable_decode = enable_decode_i;
	  assign bus.Instr_dout    = instr_dout_i;
	  assign bus.npc_in        = npc_in_i;
	  assign bus.psr           = psr_i;
	 
	  // a known reset state is driven
	  // before stimulus loop begins
	  // called once by the driver
	  task automatic reset_signals();
		  reset_i         = 1'b1;
		  enable_decode_i = 1'b0;
		  instr_dout_i    = '0;
		  npc_in_i        = '0;
		  psr_i           = '0;
		  @(posedge bus.clock);
		  reset_i = 1'b0;
		  @(posedge bus.clock);
		  //enable_decode_i = 1'b1;
	  endtask : reset_signals
	 
	  // Called by the driver class object once per transaction.
	  task automatic drive(input bit        enable_decode,
							input bit [15:0] instr_dout,
							input bit [15:0] npc_in,
							input bit [2:0]  psr);
		//@(posedge bus.clock);
		enable_decode_i = enable_decode;
		instr_dout_i    = instr_dout;
		npc_in_i        = npc_in;
		psr_i           = psr;
		@(posedge bus.clock);
		//enable_decode_i = 1'b0;
	  endtask : drive
	 
	  // called once after the 50 transactions are completed
	  task automatic go_idle();
		enable_decode_i = 1'b0;
	  endtask : go_idle
 
endinterface : decode_in_driver_bfm
