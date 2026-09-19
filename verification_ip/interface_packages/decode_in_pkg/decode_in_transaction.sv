//-----------------------------------------------------------------------------
// decode_in_transaction.sv
// Sequence item representing one decode_in stimulus cycle. 
//-----------------------------------------------------------------------------
class decode_in_transaction extends uvm_sequence_item;

	  // Type-definition: the 12 legal LC-3 opcodes (IR[15:12]). 
	  // Referred LC3 specs pdf for the opcode values
	  // 4'b1101 is invalid and they're never be randomized.
	  typedef enum bit [3:0] 
	  {
			OP_BR  = 4'b0000,
			OP_ADD = 4'b0001,
			OP_LD  = 4'b0010,
			OP_ST  = 4'b0011,
			OP_JSR = 4'b0100,
			OP_AND = 4'b0101,
			OP_LDR = 4'b0110,
			OP_STR = 4'b0111,
			OP_RTI = 4'b1000,
			OP_NOT = 4'b1001,
			OP_LDI = 4'b1010,
			OP_STI = 4'b1011,
			OP_JMP = 4'b1100,
			OP_LEA = 4'b1110,
			OP_TRAP = 4'b1111
	  } opcode_e;

	  `uvm_object_utils(decode_in_transaction)

	  rand bit        enable_decode;
	  rand bit [15:0] instr_dout;
	  rand bit [15:0] npc_in;
	  rand bit [2:0]  psr;

	  // Populated by the monitor BFM's monitor() task
	  // used in transaction-viewing timestamps.
	  time start_time;
	  time end_time;

	  constraint c_enable_decode 
	  {
			enable_decode == 1'b1;
	  }

	  constraint c_valid_opcode 
	  {
			instr_dout[15:12] inside 
			{
				  OP_BR, OP_ADD, OP_LD, OP_ST, OP_JSR, OP_AND, OP_LDR,
				  OP_STR, OP_RTI, OP_NOT, OP_LDI, OP_STI, OP_JMP, OP_LEA, OP_TRAP
			};
	  }

	  function new(string name = "decode_in_transaction");
			super.new(name);
	  endfunction

	  function opcode_e get_opcode();
			return opcode_e'(instr_dout[15:12]);
	  endfunction

	  virtual function string convert2string();
			return $sformatf(
			  "enable_decode:%0b instr_dout:0x%0h (opcode:%s) npc_in:0x%0h psr:0b%0b",
			  enable_decode, instr_dout, get_opcode().name(), npc_in, psr);
	  endfunction

endclass : decode_in_transaction
