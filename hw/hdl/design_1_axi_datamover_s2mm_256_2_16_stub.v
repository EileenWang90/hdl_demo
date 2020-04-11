// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Tue Feb 18 14:54:05 2020
// Host        : lab369-G19 running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top design_1_axi_datamover_s2mm_256_2_16 -prefix
//               design_1_axi_datamover_s2mm_256_2_16_ design_1_axi_datamover_0_0_stub.v
// Design      : design_1_axi_datamover_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu33p-fsvh2104-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "axi_datamover,Vivado 2019.2" *)
module design_1_axi_datamover_s2mm_256_2_16(m_axi_s2mm_aclk, m_axi_s2mm_aresetn, 
  s2mm_err, m_axis_s2mm_cmdsts_awclk, m_axis_s2mm_cmdsts_aresetn, s_axis_s2mm_cmd_tvalid, 
  s_axis_s2mm_cmd_tready, s_axis_s2mm_cmd_tdata, m_axis_s2mm_sts_tvalid, 
  m_axis_s2mm_sts_tready, m_axis_s2mm_sts_tdata, m_axis_s2mm_sts_tkeep, 
  m_axis_s2mm_sts_tlast, m_axi_s2mm_awid, m_axi_s2mm_awaddr, m_axi_s2mm_awlen, 
  m_axi_s2mm_awsize, m_axi_s2mm_awburst, m_axi_s2mm_awprot, m_axi_s2mm_awcache, 
  m_axi_s2mm_awuser, m_axi_s2mm_awvalid, m_axi_s2mm_awready, m_axi_s2mm_wdata, 
  m_axi_s2mm_wstrb, m_axi_s2mm_wlast, m_axi_s2mm_wvalid, m_axi_s2mm_wready, 
  m_axi_s2mm_bresp, m_axi_s2mm_bvalid, m_axi_s2mm_bready, s_axis_s2mm_tdata, 
  s_axis_s2mm_tkeep, s_axis_s2mm_tlast, s_axis_s2mm_tvalid, s_axis_s2mm_tready)
/* synthesis syn_black_box black_box_pad_pin="m_axi_s2mm_aclk,m_axi_s2mm_aresetn,s2mm_err,m_axis_s2mm_cmdsts_awclk,m_axis_s2mm_cmdsts_aresetn,s_axis_s2mm_cmd_tvalid,s_axis_s2mm_cmd_tready,s_axis_s2mm_cmd_tdata[103:0],m_axis_s2mm_sts_tvalid,m_axis_s2mm_sts_tready,m_axis_s2mm_sts_tdata[7:0],m_axis_s2mm_sts_tkeep[0:0],m_axis_s2mm_sts_tlast,m_axi_s2mm_awid[3:0],m_axi_s2mm_awaddr[63:0],m_axi_s2mm_awlen[7:0],m_axi_s2mm_awsize[2:0],m_axi_s2mm_awburst[1:0],m_axi_s2mm_awprot[2:0],m_axi_s2mm_awcache[3:0],m_axi_s2mm_awuser[3:0],m_axi_s2mm_awvalid,m_axi_s2mm_awready,m_axi_s2mm_wdata[255:0],m_axi_s2mm_wstrb[31:0],m_axi_s2mm_wlast,m_axi_s2mm_wvalid,m_axi_s2mm_wready,m_axi_s2mm_bresp[1:0],m_axi_s2mm_bvalid,m_axi_s2mm_bready,s_axis_s2mm_tdata[255:0],s_axis_s2mm_tkeep[31:0],s_axis_s2mm_tlast,s_axis_s2mm_tvalid,s_axis_s2mm_tready" */;
  input m_axi_s2mm_aclk;
  input m_axi_s2mm_aresetn;
  output s2mm_err;
  input m_axis_s2mm_cmdsts_awclk;
  input m_axis_s2mm_cmdsts_aresetn;
  input s_axis_s2mm_cmd_tvalid;
  output s_axis_s2mm_cmd_tready;
  input [103:0]s_axis_s2mm_cmd_tdata;
  output m_axis_s2mm_sts_tvalid;
  input m_axis_s2mm_sts_tready;
  output [7:0]m_axis_s2mm_sts_tdata;
  output [0:0]m_axis_s2mm_sts_tkeep;
  output m_axis_s2mm_sts_tlast;
  output [3:0]m_axi_s2mm_awid;
  output [63:0]m_axi_s2mm_awaddr;
  output [7:0]m_axi_s2mm_awlen;
  output [2:0]m_axi_s2mm_awsize;
  output [1:0]m_axi_s2mm_awburst;
  output [2:0]m_axi_s2mm_awprot;
  output [3:0]m_axi_s2mm_awcache;
  output [3:0]m_axi_s2mm_awuser;
  output m_axi_s2mm_awvalid;
  input m_axi_s2mm_awready;
  output [255:0]m_axi_s2mm_wdata;
  output [31:0]m_axi_s2mm_wstrb;
  output m_axi_s2mm_wlast;
  output m_axi_s2mm_wvalid;
  input m_axi_s2mm_wready;
  input [1:0]m_axi_s2mm_bresp;
  input m_axi_s2mm_bvalid;
  output m_axi_s2mm_bready;
  input [255:0]s_axis_s2mm_tdata;
  input [31:0]s_axis_s2mm_tkeep;
  input s_axis_s2mm_tlast;
  input s_axis_s2mm_tvalid;
  output s_axis_s2mm_tready;
endmodule
