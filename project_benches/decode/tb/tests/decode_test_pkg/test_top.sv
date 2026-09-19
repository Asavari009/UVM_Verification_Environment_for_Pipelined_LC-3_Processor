//-----------------------------------------------------------------------------
// test_top.sv
// Top-level UVM test for Project 1 
//-----------------------------------------------------------------------------
class test_top extends uvm_test;
 
  `uvm_component_utils(test_top)
 
  decode_in_agent_config cfg;   //configuration
  decode_in_agent        agent; //agent
 
  function new(string name = "test_top", uvm_component parent = null);
    super.new(name, parent);
  endfunction
 
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    // Constructing the configuration pulls the BFM handles out of uvm_config_db inside decode_in_agent_config::new().
    cfg = new("cfg");
    cfg.is_active = UVM_ACTIVE;
 
    // Printing the configuration for the agent to retrieve 
    uvm_config_db #(decode_in_agent_config)::set(null, "CFG", "decode_in", cfg);
 
    agent = new("agent", this);
  endfunction : build_phase
 
  virtual task run_phase(uvm_phase phase);
    uvm_sequencer #(decode_in_transaction) sqr;
    decode_in_random_sequence              rand_seq;
 
    // raising the objection
    phase.raise_objection(this, "Running 50 random decode_in instructions");
 
    if (!uvm_config_db #(uvm_sequencer #(decode_in_transaction))::get(null, "SQR", "decode_in", sqr))
      `uvm_fatal("TEST_TOP", "uvm_config_db#(...)::get() call for SQR failed!")
 
    for (int i = 0; i < 50; i++) 
    begin
      rand_seq = new($sformatf("seq_%0d", i));
      rand_seq.start(sqr);
    end
 
    #10ns;
	
	// enable_decode is pulled low and called only once after the 50 random transactions
    cfg.driver_bfm.go_idle();

    // dropping the objection 
    phase.drop_objection(this, "Finished 50 random decode_in instructions");
  endtask : run_phase
 
endclass : test_top
