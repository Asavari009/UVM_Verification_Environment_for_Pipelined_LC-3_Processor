//-----------------------------------------------------------------------------
// decode_in_agent_config.sv
// Helps in holding the BFM handles needed by the agent's driver and monitor.
//-----------------------------------------------------------------------------
class decode_in_agent_config extends uvm_object;

	  `uvm_object_utils(decode_in_agent_config)

	  virtual decode_in_driver_bfm  driver_bfm;
	  virtual decode_in_monitor_bfm monitor_bfm;

	  // Active: drives stimulus and monitors. 
	  // Passive: only monitors.
	  uvm_active_passive_enum is_active = UVM_ACTIVE;

	  function new(string name = "decode_in_agent_config");
			super.new(name);

			if (!uvm_config_db #(virtual decode_in_driver_bfm)::get(null, "decode_in_driver_bfm", "driver_bfm", driver_bfm))
			  `uvm_fatal("DECODE_IN_CFG", "uvm_config_db#(virtual decode_in_driver_bfm)::get() call failed!")

			if (!uvm_config_db #(virtual decode_in_monitor_bfm)::get(null, "decode_in_monitor_bfm", "monitor_bfm", monitor_bfm))
			  `uvm_fatal("DECODE_IN_CFG", "uvm_config_db#(virtual decode_in_monitor_bfm)::get() call failed!")
	  endfunction : new

	  virtual function string convert2string();
			return $sformatf("is_active:%s driver_bfm:%s monitor_bfm:%s",
							  is_active.name(),
							  (driver_bfm  == null) ? "NULL" : "connected",
							  (monitor_bfm == null) ? "NULL" : "connected");
	  endfunction : convert2string

endclass : decode_in_agent_config
