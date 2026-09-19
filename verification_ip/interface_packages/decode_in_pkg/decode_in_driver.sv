//-----------------------------------------------------------------------------
// decode_in_driver.sv
// Through the blocking sequencer interface, decode_in_transaction receives objects 
// sends the transaction variables to the driver BFM through its drive task 
//-----------------------------------------------------------------------------
class decode_in_driver extends uvm_driver #(decode_in_transaction);

	  `uvm_component_utils(decode_in_driver)

	  // Handle to the agent configuration
	  // access to configuration.driver_bfm is given
	  decode_in_agent_config configuration;

	  function new(string name = "decode_in_driver", uvm_component parent = null);
			super.new(name, parent);
	  endfunction

	  virtual task run_phase(uvm_phase phase);
			decode_in_transaction xact;

			configuration.driver_bfm.reset_signals();

			forever 
			begin
				  seq_item_port.get_next_item(xact);
				  `uvm_info(get_type_name(), {"Received transaction: ", xact.convert2string()}, UVM_MEDIUM)
				  configuration.driver_bfm.drive(xact.enable_decode, xact.instr_dout, xact.npc_in, xact.psr);
				  seq_item_port.item_done();
			end
	  endtask : run_phase

endclass : decode_in_driver
