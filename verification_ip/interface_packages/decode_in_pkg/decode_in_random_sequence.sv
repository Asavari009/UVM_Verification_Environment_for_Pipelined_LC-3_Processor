//-----------------------------------------------------------------------------
// decode_in_random_sequence.sv
// Generates and sends one fully random transaction.
// test_top calls this 50 times to produce 50 random valid instructions.
//-----------------------------------------------------------------------------
class decode_in_random_sequence extends decode_in_sequence_base;
 
	  function new(string name = "decode_in_random_sequence");
			super.new(name);
	  endfunction
	 
	  virtual task body();
			decode_in_transaction stim;
		 
			stim = new("stim");
			start_item(stim);
			if (!stim.randomize())
				`uvm_fatal("SEQ", "decode_in_random_sequence::body() - randomization failed")
			finish_item(stim);
	  endtask : body
 
endclass : decode_in_random_sequence