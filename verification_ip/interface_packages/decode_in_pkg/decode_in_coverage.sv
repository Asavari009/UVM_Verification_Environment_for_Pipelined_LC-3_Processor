//-----------------------------------------------------------------------------
// decode_in_coverage.sv
//-----------------------------------------------------------------------------
class decode_in_coverage extends uvm_subscriber #(decode_in_transaction);
 
	  `uvm_component_utils(decode_in_coverage)
	 
	  decode_in_transaction coverage_trans;
	 
	  // declaring the covergroup
	  covergroup decode_in_opcode_cg;
		option.per_instance = 1;
		cp_opcode : coverpoint coverage_trans.get_opcode() 
		{
		  bins BR  = {decode_in_transaction::OP_BR};
		  bins ADD = {decode_in_transaction::OP_ADD};
		  bins LD  = {decode_in_transaction::OP_LD};
		  bins ST  = {decode_in_transaction::OP_ST};
		  bins JSR  = {decode_in_transaction::OP_JSR};
		  bins AND = {decode_in_transaction::OP_AND};
		  bins LDR = {decode_in_transaction::OP_LDR};
		  bins STR = {decode_in_transaction::OP_STR};
		  bins RTI  = {decode_in_transaction::OP_RTI};
		  bins NOT = {decode_in_transaction::OP_NOT};
		  bins LDI = {decode_in_transaction::OP_LDI};
		  bins STI = {decode_in_transaction::OP_STI};
		  bins JMP = {decode_in_transaction::OP_JMP};
		  bins LEA = {decode_in_transaction::OP_LEA};
		  bins TRAP  = {decode_in_transaction::OP_TRAP};
		}
	  endgroup : decode_in_opcode_cg
	 
	  function new(string name = "decode_in_coverage", uvm_component parent = null);
			super.new(name, parent);
			decode_in_opcode_cg = new();
	  endfunction
	 
	  virtual function void write(decode_in_transaction t);
			`uvm_info(get_type_name(), "Received transaction", UVM_MEDIUM)
			coverage_trans = t;
			decode_in_opcode_cg.sample();
	  endfunction : write
 
endclass : decode_in_coverage