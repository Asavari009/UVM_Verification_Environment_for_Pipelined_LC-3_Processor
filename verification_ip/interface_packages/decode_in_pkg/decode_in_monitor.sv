//-----------------------------------------------------------------------------
// decode_in_monitor.sv
// Responsible for transaction level operations
// configuration of the BFM and transaction variable communication with the BFM. 
//-----------------------------------------------------------------------------
class decode_in_monitor extends uvm_monitor;
 
	  `uvm_component_utils(decode_in_monitor)
	 
	  // Handle to the agent configuration
	  // gives access to configuration.monitor_bfm
	  decode_in_agent_config configuration;
	 
	  uvm_analysis_port #(decode_in_transaction) ap;
	 
	  // Transaction Viewer stream handle 
	  int transaction_viewing_stream_h;
	 
	  function new(string name = "decode_in_monitor", uvm_component parent = null);
		super.new(name, parent);
		ap = new("ap", this);
	  endfunction
	 
	  virtual function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		transaction_viewing_stream_h = $create_transaction_stream({"..", get_full_name(), ".", "txn_stream"}, "TVM");
	  endfunction : start_of_simulation_phase
	 
	  virtual task run_phase(uvm_phase phase);
		  decode_in_transaction sampled_txn;
		  integer rec_h;
		  int unsigned i;

		  //@(posedge configuration.monitor_bfm.bus.clock);   // stay in sync with the driver's added post-reset delay

		  configuration.monitor_bfm.wait_for_reset_release();

		  for (i=0; i<50; i++)
		  begin
			sampled_txn = new("sampled_txn");

			configuration.monitor_bfm.monitor(sampled_txn.enable_decode,
											   sampled_txn.instr_dout,
											   sampled_txn.npc_in,
											   sampled_txn.psr,
											   sampled_txn.start_time,
											   sampled_txn.end_time);

			rec_h = $begin_transaction(transaction_viewing_stream_h, "decode_in_transaction", sampled_txn.start_time);
			$add_attribute(rec_h, sampled_txn.enable_decode, "enable_decode");
			$add_attribute(rec_h, sampled_txn.instr_dout,    "instr_dout");
			$add_attribute(rec_h, sampled_txn.npc_in,        "npc_in");
			$add_attribute(rec_h, sampled_txn.psr,           "psr");
			$end_transaction(rec_h, sampled_txn.end_time);

			`uvm_info(get_type_name(), sampled_txn.convert2string(), UVM_MEDIUM)

			ap.write(sampled_txn);
		  end
	  endtask : run_phase
 
endclass : decode_in_monitor