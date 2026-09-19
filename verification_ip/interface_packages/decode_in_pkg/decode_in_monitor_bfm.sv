//-----------------------------------------------------------------------------
// decode_in_monitor_bfm.sv
// Monitor BFM: responsible for protocol signal monitoring operations.
//-----------------------------------------------------------------------------
interface decode_in_monitor_bfm (decode_in_if bus);

	  task automatic wait_for_reset_release();
			wait (bus.reset === 1'b1);
			wait (bus.reset === 1'b0);
	  endtask : wait_for_reset_release

	  // Called by the monitor class object. 
	  // Blocks until enable_decode is seen asserted 
	  // Returns the sampled values plus the start/end time of the transfer for transaction-viewing purposes.
	  task automatic monitor(output bit        enable_decode,
							  output bit [15:0] instr_dout,
							  output bit [15:0] npc_in,
							  output bit [2:0]  psr,
							  output time       start_time,
							  output time       end_time);
							  
		/*do
			@(posedge bus.clock);
		while (bus.reset);*/
		
		@(posedge bus.clock);
		#0;
							  
		//@(posedge bus.clock);
		start_time    = $time;
		enable_decode = bus.enable_decode;
		instr_dout    = bus.Instr_dout;
		npc_in        = bus.npc_in;
		psr           = bus.psr;
		end_time      = $time;
		//@(posedge bus.clock);
	  endtask : monitor

endinterface : decode_in_monitor_bfm
