//-----------------------------------------------------------------------------
// hdl_top.sv
//-----------------------------------------------------------------------------
`timescale 1ns/1ps

module hdl_top;

  import uvm_pkg::*;

  bit clock;

  // 10ns period clock
  always #5 clock = ~clock;

  // decode_in signal bundle
  decode_in_if decode_in_vif (.clock(clock));

  // BFMs for each driver and monitor
  // each wraps the signal bundle through the respective modport
  decode_in_driver_bfm  drv_bfm (decode_in_vif.driver_port);
  decode_in_monitor_bfm mon_bfm (decode_in_vif.monitor_port);

  initial
    uvm_config_db #(virtual decode_in_driver_bfm)::set(null, "decode_in_driver_bfm", "driver_bfm", drv_bfm);

  initial
    uvm_config_db #(virtual decode_in_monitor_bfm)::set(null, "decode_in_monitor_bfm", "monitor_bfm", mon_bfm);

  // -------------------------------------------------------------------
  // DUT: Decode block 
  // -------------------------------------------------------------------
  wire [15:0] IR;
  wire [5:0]  E_Control;
  wire [15:0] npc_out;
  wire        Mem_Control;
  wire [1:0]  W_Control;

  Decode dut (
    .clock         (clock),
    .reset         (decode_in_vif.reset),
    .enable_decode (decode_in_vif.enable_decode),
    .dout          (decode_in_vif.Instr_dout),
    .npc_in        (decode_in_vif.npc_in),
    .IR            (IR),
    .E_Control     (E_Control),
    .npc_out       (npc_out),
    .Mem_Control   (Mem_Control),
    .W_Control     (W_Control)
  );

endmodule : hdl_top
