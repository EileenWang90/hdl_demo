// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Wed Apr  1 21:38:16 2020
// Host        : lab369-G19 running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/wx/vivado/SqueezeNet_Ristretto3/System_Ristretto1/System_Ristretto1.srcs/sources_1/bd/design_1/ip/design_1_SqueezeNet_StateMach_0_1/design_1_SqueezeNet_StateMach_0_1_stub.v
// Design      : design_1_SqueezeNet_StateMach_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu33p-fsvh2104-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "SqueezeNet_StateMachine,Vivado 2019.2" *)
module design_1_SqueezeNet_StateMach_0_1(clk, rst_n, ap_start, ap_done, CONV1_reset_n, 
  CONV1_do, CONV1_done, CONV1_ready, CONV1_read_address_offset, CONV1_write_cmd_TREADY, 
  CONV1_write_cmd_TDATA, CONV1_write_cmd_TVALID, POOL1_reset_n, POOL1_do, POOL1_done, 
  POOL1_ready, POOL1_read_address_offset, POOL1_write_cmd_TREADY, POOL1_write_cmd_TDATA, 
  POOL1_write_cmd_TVALID, F2_S_reset_n, F2_S_do, F2_S_done, F2_S_ready, 
  F2_S_read_address_offset, F2_S_write_cmd_TREADY, F2_S_write_cmd_TDATA, 
  F2_S_write_cmd_TVALID, F2_E_reset_n, F2_E_do, F2_E_done, F2_E_ready, 
  F2_E_read_address_offset, F2_E_write_cmd_TREADY, F2_E_write_cmd_TDATA, 
  F2_E_write_cmd_TVALID, F3_S_reset_n, F3_S_do, F3_S_done, F3_S_ready, 
  F3_S_read_address_offset, F3_S_write_cmd_TREADY, F3_S_write_cmd_TDATA, 
  F3_S_write_cmd_TVALID, F3_E_reset_n, F3_E_do, F3_E_done, F3_E_ready, 
  F3_E_read_address_offset, F3_E_write_cmd_TREADY, F3_E_write_cmd_TDATA, 
  F3_E_write_cmd_TVALID, POOL3_reset_n, POOL3_do, POOL3_done, POOL3_ready, 
  POOL3_read_address_offset, POOL3_write_cmd_TREADY, POOL3_write_cmd_TDATA, 
  POOL3_write_cmd_TVALID, F4_S_reset_n, F4_S_do, F4_S_done, F4_S_ready, 
  F4_S_read_address_offset, F4_S_write_cmd_TREADY, F4_S_write_cmd_TDATA, 
  F4_S_write_cmd_TVALID, F4_E_reset_n, F4_E_do, F4_E_done, F4_E_ready, 
  F4_E_read_address_offset, F4_E_write_cmd_TREADY, F4_E_write_cmd_TDATA, 
  F4_E_write_cmd_TVALID, F5_S_reset_n, F5_S_do, F5_S_done, F5_S_ready, 
  F5_S_read_address_offset, F5_S_write_cmd_TREADY, F5_S_write_cmd_TDATA, 
  F5_S_write_cmd_TVALID, F5_E_reset_n, F5_E_do, F5_E_done, F5_E_ready, 
  F5_E_read_address_offset, F5_E_write_cmd_TREADY, F5_E_write_cmd_TDATA, 
  F5_E_write_cmd_TVALID, POOL5_reset_n, POOL5_do, POOL5_done, POOL5_ready, 
  POOL5_read_address_offset, POOL5_write_cmd_TREADY, POOL5_write_cmd_TDATA, 
  POOL5_write_cmd_TVALID, F6_S_reset_n, F6_S_do, F6_S_done, F6_S_ready, 
  F6_S_read_address_offset, F6_S_write_cmd_TREADY, F6_S_write_cmd_TDATA, 
  F6_S_write_cmd_TVALID, F6_E_reset_n, F6_E_do, F6_E_done, F6_E_ready, 
  F6_E_read_address_offset, F6_E_write_cmd_TREADY, F6_E_write_cmd_TDATA, 
  F6_E_write_cmd_TVALID, F7_S_reset_n, F7_S_do, F7_S_done, F7_S_ready, 
  F7_S_read_address_offset, F7_S_write_cmd_TREADY, F7_S_write_cmd_TDATA, 
  F7_S_write_cmd_TVALID, F7_E_reset_n, F7_E_do, F7_E_done, F7_E_ready, 
  F7_E_read_address_offset, F7_E_write_cmd_TREADY, F7_E_write_cmd_TDATA, 
  F7_E_write_cmd_TVALID, F8_S_reset_n, F8_S_do, F8_S_done, F8_S_ready, 
  F8_S_read_address_offset, F8_S_write_cmd_TREADY, F8_S_write_cmd_TDATA, 
  F8_S_write_cmd_TVALID, F8_E_reset_n, F8_E_do, F8_E_done, F8_E_ready, 
  F8_E_read_address_offset, F8_E_write_cmd_TREADY, F8_E_write_cmd_TDATA, 
  F8_E_write_cmd_TVALID, F9_S_reset_n, F9_S_do, F9_S_done, F9_S_ready, 
  F9_S_read_address_offset, F9_S_write_cmd_TREADY, F9_S_write_cmd_TDATA, 
  F9_S_write_cmd_TVALID, F9_E_reset_n, F9_E_do, F9_E_done, F9_E_ready, 
  F9_E_read_address_offset, F9_E_write_cmd_TREADY, F9_E_write_cmd_TDATA, 
  F9_E_write_cmd_TVALID, CONV10_reset_n, CONV10_do, CONV10_done, CONV10_ready, 
  CONV10_read_address_offset, CONV10_write_cmd_TREADY, CONV10_write_cmd_TDATA, 
  CONV10_write_cmd_TVALID, State, TimeCnt, EachLayer, Parity, sw_start, sw_done, CONV1_addr, 
  POOL1_addr, F2_S_addr, F2_E_addr, F3_S_addr, F3_E_addr, POOL3_addr, F4_S_addr, F4_E_addr, 
  F5_S_addr, F5_E_addr, POOL5_addr, F6_S_addr, F6_E_addr, F7_S_addr, F7_E_addr, F8_S_addr, 
  F8_E_addr, F9_S_addr, F9_E_addr, CONV10_addr, CONV10_weight_addr, 
  CONV10_weight_read_offset)
/* synthesis syn_black_box black_box_pad_pin="clk,rst_n,ap_start,ap_done,CONV1_reset_n,CONV1_do,CONV1_done,CONV1_ready,CONV1_read_address_offset[63:0],CONV1_write_cmd_TREADY,CONV1_write_cmd_TDATA[103:0],CONV1_write_cmd_TVALID,POOL1_reset_n,POOL1_do,POOL1_done,POOL1_ready,POOL1_read_address_offset[63:0],POOL1_write_cmd_TREADY,POOL1_write_cmd_TDATA[103:0],POOL1_write_cmd_TVALID,F2_S_reset_n,F2_S_do,F2_S_done,F2_S_ready,F2_S_read_address_offset[63:0],F2_S_write_cmd_TREADY,F2_S_write_cmd_TDATA[103:0],F2_S_write_cmd_TVALID,F2_E_reset_n,F2_E_do,F2_E_done,F2_E_ready,F2_E_read_address_offset[63:0],F2_E_write_cmd_TREADY,F2_E_write_cmd_TDATA[103:0],F2_E_write_cmd_TVALID,F3_S_reset_n,F3_S_do,F3_S_done,F3_S_ready,F3_S_read_address_offset[63:0],F3_S_write_cmd_TREADY,F3_S_write_cmd_TDATA[103:0],F3_S_write_cmd_TVALID,F3_E_reset_n,F3_E_do,F3_E_done,F3_E_ready,F3_E_read_address_offset[63:0],F3_E_write_cmd_TREADY,F3_E_write_cmd_TDATA[103:0],F3_E_write_cmd_TVALID,POOL3_reset_n,POOL3_do,POOL3_done,POOL3_ready,POOL3_read_address_offset[63:0],POOL3_write_cmd_TREADY,POOL3_write_cmd_TDATA[103:0],POOL3_write_cmd_TVALID,F4_S_reset_n,F4_S_do,F4_S_done,F4_S_ready,F4_S_read_address_offset[63:0],F4_S_write_cmd_TREADY,F4_S_write_cmd_TDATA[103:0],F4_S_write_cmd_TVALID,F4_E_reset_n,F4_E_do,F4_E_done,F4_E_ready,F4_E_read_address_offset[63:0],F4_E_write_cmd_TREADY,F4_E_write_cmd_TDATA[103:0],F4_E_write_cmd_TVALID,F5_S_reset_n,F5_S_do,F5_S_done,F5_S_ready,F5_S_read_address_offset[63:0],F5_S_write_cmd_TREADY,F5_S_write_cmd_TDATA[103:0],F5_S_write_cmd_TVALID,F5_E_reset_n,F5_E_do,F5_E_done,F5_E_ready,F5_E_read_address_offset[63:0],F5_E_write_cmd_TREADY,F5_E_write_cmd_TDATA[103:0],F5_E_write_cmd_TVALID,POOL5_reset_n,POOL5_do,POOL5_done,POOL5_ready,POOL5_read_address_offset[63:0],POOL5_write_cmd_TREADY,POOL5_write_cmd_TDATA[103:0],POOL5_write_cmd_TVALID,F6_S_reset_n,F6_S_do,F6_S_done,F6_S_ready,F6_S_read_address_offset[63:0],F6_S_write_cmd_TREADY,F6_S_write_cmd_TDATA[103:0],F6_S_write_cmd_TVALID,F6_E_reset_n,F6_E_do,F6_E_done,F6_E_ready,F6_E_read_address_offset[63:0],F6_E_write_cmd_TREADY,F6_E_write_cmd_TDATA[103:0],F6_E_write_cmd_TVALID,F7_S_reset_n,F7_S_do,F7_S_done,F7_S_ready,F7_S_read_address_offset[63:0],F7_S_write_cmd_TREADY,F7_S_write_cmd_TDATA[103:0],F7_S_write_cmd_TVALID,F7_E_reset_n,F7_E_do,F7_E_done,F7_E_ready,F7_E_read_address_offset[63:0],F7_E_write_cmd_TREADY,F7_E_write_cmd_TDATA[103:0],F7_E_write_cmd_TVALID,F8_S_reset_n,F8_S_do,F8_S_done,F8_S_ready,F8_S_read_address_offset[63:0],F8_S_write_cmd_TREADY,F8_S_write_cmd_TDATA[103:0],F8_S_write_cmd_TVALID,F8_E_reset_n,F8_E_do,F8_E_done,F8_E_ready,F8_E_read_address_offset[63:0],F8_E_write_cmd_TREADY,F8_E_write_cmd_TDATA[103:0],F8_E_write_cmd_TVALID,F9_S_reset_n,F9_S_do,F9_S_done,F9_S_ready,F9_S_read_address_offset[63:0],F9_S_write_cmd_TREADY,F9_S_write_cmd_TDATA[103:0],F9_S_write_cmd_TVALID,F9_E_reset_n,F9_E_do,F9_E_done,F9_E_ready,F9_E_read_address_offset[63:0],F9_E_write_cmd_TREADY,F9_E_write_cmd_TDATA[103:0],F9_E_write_cmd_TVALID,CONV10_reset_n,CONV10_do,CONV10_done,CONV10_ready,CONV10_read_address_offset[63:0],CONV10_write_cmd_TREADY,CONV10_write_cmd_TDATA[103:0],CONV10_write_cmd_TVALID,State[110:0],TimeCnt[31:0],EachLayer[20:0],Parity,sw_start,sw_done,CONV1_addr[127:0],POOL1_addr[127:0],F2_S_addr[127:0],F2_E_addr[127:0],F3_S_addr[127:0],F3_E_addr[127:0],POOL3_addr[127:0],F4_S_addr[127:0],F4_E_addr[127:0],F5_S_addr[127:0],F5_E_addr[127:0],POOL5_addr[127:0],F6_S_addr[127:0],F6_E_addr[127:0],F7_S_addr[127:0],F7_E_addr[127:0],F8_S_addr[127:0],F8_E_addr[127:0],F9_S_addr[127:0],F9_E_addr[127:0],CONV10_addr[127:0],CONV10_weight_addr[63:0],CONV10_weight_read_offset[63:0]" */;
  input clk;
  input rst_n;
  input ap_start;
  output ap_done;
  output CONV1_reset_n;
  output CONV1_do;
  input CONV1_done;
  input CONV1_ready;
  output [63:0]CONV1_read_address_offset;
  input CONV1_write_cmd_TREADY;
  output [103:0]CONV1_write_cmd_TDATA;
  output CONV1_write_cmd_TVALID;
  output POOL1_reset_n;
  output POOL1_do;
  input POOL1_done;
  input POOL1_ready;
  output [63:0]POOL1_read_address_offset;
  input POOL1_write_cmd_TREADY;
  output [103:0]POOL1_write_cmd_TDATA;
  output POOL1_write_cmd_TVALID;
  output F2_S_reset_n;
  output F2_S_do;
  input F2_S_done;
  input F2_S_ready;
  output [63:0]F2_S_read_address_offset;
  input F2_S_write_cmd_TREADY;
  output [103:0]F2_S_write_cmd_TDATA;
  output F2_S_write_cmd_TVALID;
  output F2_E_reset_n;
  output F2_E_do;
  input F2_E_done;
  input F2_E_ready;
  output [63:0]F2_E_read_address_offset;
  input F2_E_write_cmd_TREADY;
  output [103:0]F2_E_write_cmd_TDATA;
  output F2_E_write_cmd_TVALID;
  output F3_S_reset_n;
  output F3_S_do;
  input F3_S_done;
  input F3_S_ready;
  output [63:0]F3_S_read_address_offset;
  input F3_S_write_cmd_TREADY;
  output [103:0]F3_S_write_cmd_TDATA;
  output F3_S_write_cmd_TVALID;
  output F3_E_reset_n;
  output F3_E_do;
  input F3_E_done;
  input F3_E_ready;
  output [63:0]F3_E_read_address_offset;
  input F3_E_write_cmd_TREADY;
  output [103:0]F3_E_write_cmd_TDATA;
  output F3_E_write_cmd_TVALID;
  output POOL3_reset_n;
  output POOL3_do;
  input POOL3_done;
  input POOL3_ready;
  output [63:0]POOL3_read_address_offset;
  input POOL3_write_cmd_TREADY;
  output [103:0]POOL3_write_cmd_TDATA;
  output POOL3_write_cmd_TVALID;
  output F4_S_reset_n;
  output F4_S_do;
  input F4_S_done;
  input F4_S_ready;
  output [63:0]F4_S_read_address_offset;
  input F4_S_write_cmd_TREADY;
  output [103:0]F4_S_write_cmd_TDATA;
  output F4_S_write_cmd_TVALID;
  output F4_E_reset_n;
  output F4_E_do;
  input F4_E_done;
  input F4_E_ready;
  output [63:0]F4_E_read_address_offset;
  input F4_E_write_cmd_TREADY;
  output [103:0]F4_E_write_cmd_TDATA;
  output F4_E_write_cmd_TVALID;
  output F5_S_reset_n;
  output F5_S_do;
  input F5_S_done;
  input F5_S_ready;
  output [63:0]F5_S_read_address_offset;
  input F5_S_write_cmd_TREADY;
  output [103:0]F5_S_write_cmd_TDATA;
  output F5_S_write_cmd_TVALID;
  output F5_E_reset_n;
  output F5_E_do;
  input F5_E_done;
  input F5_E_ready;
  output [63:0]F5_E_read_address_offset;
  input F5_E_write_cmd_TREADY;
  output [103:0]F5_E_write_cmd_TDATA;
  output F5_E_write_cmd_TVALID;
  output POOL5_reset_n;
  output POOL5_do;
  input POOL5_done;
  input POOL5_ready;
  output [63:0]POOL5_read_address_offset;
  input POOL5_write_cmd_TREADY;
  output [103:0]POOL5_write_cmd_TDATA;
  output POOL5_write_cmd_TVALID;
  output F6_S_reset_n;
  output F6_S_do;
  input F6_S_done;
  input F6_S_ready;
  output [63:0]F6_S_read_address_offset;
  input F6_S_write_cmd_TREADY;
  output [103:0]F6_S_write_cmd_TDATA;
  output F6_S_write_cmd_TVALID;
  output F6_E_reset_n;
  output F6_E_do;
  input F6_E_done;
  input F6_E_ready;
  output [63:0]F6_E_read_address_offset;
  input F6_E_write_cmd_TREADY;
  output [103:0]F6_E_write_cmd_TDATA;
  output F6_E_write_cmd_TVALID;
  output F7_S_reset_n;
  output F7_S_do;
  input F7_S_done;
  input F7_S_ready;
  output [63:0]F7_S_read_address_offset;
  input F7_S_write_cmd_TREADY;
  output [103:0]F7_S_write_cmd_TDATA;
  output F7_S_write_cmd_TVALID;
  output F7_E_reset_n;
  output F7_E_do;
  input F7_E_done;
  input F7_E_ready;
  output [63:0]F7_E_read_address_offset;
  input F7_E_write_cmd_TREADY;
  output [103:0]F7_E_write_cmd_TDATA;
  output F7_E_write_cmd_TVALID;
  output F8_S_reset_n;
  output F8_S_do;
  input F8_S_done;
  input F8_S_ready;
  output [63:0]F8_S_read_address_offset;
  input F8_S_write_cmd_TREADY;
  output [103:0]F8_S_write_cmd_TDATA;
  output F8_S_write_cmd_TVALID;
  output F8_E_reset_n;
  output F8_E_do;
  input F8_E_done;
  input F8_E_ready;
  output [63:0]F8_E_read_address_offset;
  input F8_E_write_cmd_TREADY;
  output [103:0]F8_E_write_cmd_TDATA;
  output F8_E_write_cmd_TVALID;
  output F9_S_reset_n;
  output F9_S_do;
  input F9_S_done;
  input F9_S_ready;
  output [63:0]F9_S_read_address_offset;
  input F9_S_write_cmd_TREADY;
  output [103:0]F9_S_write_cmd_TDATA;
  output F9_S_write_cmd_TVALID;
  output F9_E_reset_n;
  output F9_E_do;
  input F9_E_done;
  input F9_E_ready;
  output [63:0]F9_E_read_address_offset;
  input F9_E_write_cmd_TREADY;
  output [103:0]F9_E_write_cmd_TDATA;
  output F9_E_write_cmd_TVALID;
  output CONV10_reset_n;
  output CONV10_do;
  input CONV10_done;
  input CONV10_ready;
  output [63:0]CONV10_read_address_offset;
  input CONV10_write_cmd_TREADY;
  output [103:0]CONV10_write_cmd_TDATA;
  output CONV10_write_cmd_TVALID;
  output [110:0]State;
  output [31:0]TimeCnt;
  output [20:0]EachLayer;
  output Parity;
  input sw_start;
  output sw_done;
  input [127:0]CONV1_addr;
  input [127:0]POOL1_addr;
  input [127:0]F2_S_addr;
  input [127:0]F2_E_addr;
  input [127:0]F3_S_addr;
  input [127:0]F3_E_addr;
  input [127:0]POOL3_addr;
  input [127:0]F4_S_addr;
  input [127:0]F4_E_addr;
  input [127:0]F5_S_addr;
  input [127:0]F5_E_addr;
  input [127:0]POOL5_addr;
  input [127:0]F6_S_addr;
  input [127:0]F6_E_addr;
  input [127:0]F7_S_addr;
  input [127:0]F7_E_addr;
  input [127:0]F8_S_addr;
  input [127:0]F8_E_addr;
  input [127:0]F9_S_addr;
  input [127:0]F9_E_addr;
  input [127:0]CONV10_addr;
  input [63:0]CONV10_weight_addr;
  output [63:0]CONV10_weight_read_offset;
endmodule
