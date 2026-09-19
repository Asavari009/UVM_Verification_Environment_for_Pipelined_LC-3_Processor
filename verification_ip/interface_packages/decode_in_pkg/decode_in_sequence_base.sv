//-----------------------------------------------------------------------------
// decode_in_sequence_base.sv
// Base sequence for all decode_in sequences.
//-----------------------------------------------------------------------------
class decode_in_sequence_base extends uvm_sequence #(decode_in_transaction);

	  function new(string name = "decode_in_sequence_base");
			super.new(name);
	  endfunction

endclass : decode_in_sequence_base
