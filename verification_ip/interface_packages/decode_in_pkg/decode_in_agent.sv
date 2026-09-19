//-----------------------------------------------------------------------------
// decode_in_agent.sv
// Instantiates the configuration, driver, monitor, coverage component classes
// connects the 4 classes 
//-----------------------------------------------------------------------------
class decode_in_agent extends uvm_agent;
 
	  `uvm_component_utils(decode_in_agent)
	 
	  decode_in_agent_config cfg;
	 
	  uvm_sequencer #(decode_in_transaction) sequencer;
	  decode_in_driver                        driver;
	  decode_in_monitor                       monitor;
	  decode_in_coverage                      coverage;
	 
	  function new(string name = "decode_in_agent", uvm_component parent = null);
		super.new(name, parent);
	  endfunction
	 
	  virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	 
		if (!uvm_config_db #(decode_in_agent_config)::get(null, "CFG", "decode_in", cfg))
		  `uvm_fatal("DECODE_IN_AGENT", "uvm_config_db#(decode_in_agent_config)::get() call failed!")
	 
		monitor = new("monitor", this);
		monitor.configuration = cfg;
	 
		coverage = new("coverage", this);
	 
		if (cfg.is_active == UVM_ACTIVE) 
		begin
		  sequencer = new("sequencer", this);
	 
		  driver = new("driver", this);
		  driver.configuration = cfg;
	 
		  // Printing the sequencer
		  uvm_config_db #(uvm_sequencer #(decode_in_transaction))::set(null, "SQR", "decode_in", sequencer);
		end
	  endfunction : build_phase
	 
	  virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	 
		// monitor analysis port export 
		monitor.ap.connect(coverage.analysis_export);
	 
		if (cfg.is_active == UVM_ACTIVE)
		  driver.seq_item_port.connect(sequencer.seq_item_export);
	  endfunction : connect_phase
 
endclass : decode_in_agent