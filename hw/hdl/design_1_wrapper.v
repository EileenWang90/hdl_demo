//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Wed Apr  8 18:18:50 2020
//Host        : lab369-G19 running 64-bit Ubuntu 18.04.2 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (CONV10_addr_0,
    CONV10_weight_addr_0,
    CONV1_addr_0,
    EachLayer_0,
    F2_E_addr_0,
    F2_S_addr_0,
    F3_E_addr_0,
    F3_S_addr_0,
    F4_E_addr_0,
    F4_S_addr_0,
    F5_E_addr_0,
    F5_S_addr_0,
    F6_E_addr_0,
    F6_S_addr_0,
    F7_E_addr_0,
    F7_S_addr_0,
    F8_E_addr_0,
    F8_S_addr_0,
    F9_E_addr_0,
    F9_S_addr_0,
    M00_AXI_0_araddr,
    M00_AXI_0_arburst,
    M00_AXI_0_arcache,
    M00_AXI_0_arlen,
    M00_AXI_0_arlock,
    M00_AXI_0_arprot,
    M00_AXI_0_arqos,
    M00_AXI_0_arready,
    M00_AXI_0_arregion,
    M00_AXI_0_arsize,
    M00_AXI_0_arvalid,
    M00_AXI_0_awaddr,
    M00_AXI_0_awburst,
    M00_AXI_0_awcache,
    M00_AXI_0_awlen,
    M00_AXI_0_awlock,
    M00_AXI_0_awprot,
    M00_AXI_0_awqos,
    M00_AXI_0_awready,
    M00_AXI_0_awregion,
    M00_AXI_0_awsize,
    M00_AXI_0_awvalid,
    M00_AXI_0_bready,
    M00_AXI_0_bresp,
    M00_AXI_0_bvalid,
    M00_AXI_0_rdata,
    M00_AXI_0_rlast,
    M00_AXI_0_rready,
    M00_AXI_0_rresp,
    M00_AXI_0_rvalid,
    M00_AXI_0_wdata,
    M00_AXI_0_wlast,
    M00_AXI_0_wready,
    M00_AXI_0_wstrb,
    M00_AXI_0_wvalid,
    POOL1_addr_0,
    POOL3_addr_0,
    POOL5_addr_0,
    Parity_0,
    State_0,
    TimeCnt_0,
    ap_done_0,
    ap_start_0,
    clk_0,
    reset_rtl_0_0,
    sw_done_0,
    sw_start_0);
  input [127:0]CONV10_addr_0;
  input [63:0]CONV10_weight_addr_0;
  input [127:0]CONV1_addr_0;
  output [20:0]EachLayer_0;
  input [127:0]F2_E_addr_0;
  input [127:0]F2_S_addr_0;
  input [127:0]F3_E_addr_0;
  input [127:0]F3_S_addr_0;
  input [127:0]F4_E_addr_0;
  input [127:0]F4_S_addr_0;
  input [127:0]F5_E_addr_0;
  input [127:0]F5_S_addr_0;
  input [127:0]F6_E_addr_0;
  input [127:0]F6_S_addr_0;
  input [127:0]F7_E_addr_0;
  input [127:0]F7_S_addr_0;
  input [127:0]F8_E_addr_0;
  input [127:0]F8_S_addr_0;
  input [127:0]F9_E_addr_0;
  input [127:0]F9_S_addr_0;
  output [63:0]M00_AXI_0_araddr;
  output [1:0]M00_AXI_0_arburst;
  output [3:0]M00_AXI_0_arcache;
  output [7:0]M00_AXI_0_arlen;
  output [0:0]M00_AXI_0_arlock;
  output [2:0]M00_AXI_0_arprot;
  output [3:0]M00_AXI_0_arqos;
  input M00_AXI_0_arready;
  output [3:0]M00_AXI_0_arregion;
  output [2:0]M00_AXI_0_arsize;
  output M00_AXI_0_arvalid;
  output [63:0]M00_AXI_0_awaddr;
  output [1:0]M00_AXI_0_awburst;
  output [3:0]M00_AXI_0_awcache;
  output [7:0]M00_AXI_0_awlen;
  output [0:0]M00_AXI_0_awlock;
  output [2:0]M00_AXI_0_awprot;
  output [3:0]M00_AXI_0_awqos;
  input M00_AXI_0_awready;
  output [3:0]M00_AXI_0_awregion;
  output [2:0]M00_AXI_0_awsize;
  output M00_AXI_0_awvalid;
  output M00_AXI_0_bready;
  input [1:0]M00_AXI_0_bresp;
  input M00_AXI_0_bvalid;
  input [511:0]M00_AXI_0_rdata;
  input M00_AXI_0_rlast;
  output M00_AXI_0_rready;
  input [1:0]M00_AXI_0_rresp;
  input M00_AXI_0_rvalid;
  output [511:0]M00_AXI_0_wdata;
  output M00_AXI_0_wlast;
  input M00_AXI_0_wready;
  output [63:0]M00_AXI_0_wstrb;
  output M00_AXI_0_wvalid;
  input [127:0]POOL1_addr_0;
  input [127:0]POOL3_addr_0;
  input [127:0]POOL5_addr_0;
  output Parity_0;
  output [110:0]State_0;
  output [31:0]TimeCnt_0;
  output ap_done_0;
  input ap_start_0;
  input clk_0;
  input reset_rtl_0_0;
  output sw_done_0;
  input sw_start_0;

  wire [127:0]CONV10_addr_0;
  wire [63:0]CONV10_weight_addr_0;
  wire [127:0]CONV1_addr_0;
  wire [20:0]EachLayer_0;
  wire [127:0]F2_E_addr_0;
  wire [127:0]F2_S_addr_0;
  wire [127:0]F3_E_addr_0;
  wire [127:0]F3_S_addr_0;
  wire [127:0]F4_E_addr_0;
  wire [127:0]F4_S_addr_0;
  wire [127:0]F5_E_addr_0;
  wire [127:0]F5_S_addr_0;
  wire [127:0]F6_E_addr_0;
  wire [127:0]F6_S_addr_0;
  wire [127:0]F7_E_addr_0;
  wire [127:0]F7_S_addr_0;
  wire [127:0]F8_E_addr_0;
  wire [127:0]F8_S_addr_0;
  wire [127:0]F9_E_addr_0;
  wire [127:0]F9_S_addr_0;
  wire [63:0]M00_AXI_0_araddr;
  wire [1:0]M00_AXI_0_arburst;
  wire [3:0]M00_AXI_0_arcache;
  wire [7:0]M00_AXI_0_arlen;
  wire [0:0]M00_AXI_0_arlock;
  wire [2:0]M00_AXI_0_arprot;
  wire [3:0]M00_AXI_0_arqos;
  wire M00_AXI_0_arready;
  wire [3:0]M00_AXI_0_arregion;
  wire [2:0]M00_AXI_0_arsize;
  wire M00_AXI_0_arvalid;
  wire [63:0]M00_AXI_0_awaddr;
  wire [1:0]M00_AXI_0_awburst;
  wire [3:0]M00_AXI_0_awcache;
  wire [7:0]M00_AXI_0_awlen;
  wire [0:0]M00_AXI_0_awlock;
  wire [2:0]M00_AXI_0_awprot;
  wire [3:0]M00_AXI_0_awqos;
  wire M00_AXI_0_awready;
  wire [3:0]M00_AXI_0_awregion;
  wire [2:0]M00_AXI_0_awsize;
  wire M00_AXI_0_awvalid;
  wire M00_AXI_0_bready;
  wire [1:0]M00_AXI_0_bresp;
  wire M00_AXI_0_bvalid;
  wire [511:0]M00_AXI_0_rdata;
  wire M00_AXI_0_rlast;
  wire M00_AXI_0_rready;
  wire [1:0]M00_AXI_0_rresp;
  wire M00_AXI_0_rvalid;
  wire [511:0]M00_AXI_0_wdata;
  wire M00_AXI_0_wlast;
  wire M00_AXI_0_wready;
  wire [63:0]M00_AXI_0_wstrb;
  wire M00_AXI_0_wvalid;
  wire [127:0]POOL1_addr_0;
  wire [127:0]POOL3_addr_0;
  wire [127:0]POOL5_addr_0;
  wire Parity_0;
  wire [110:0]State_0;
  wire [31:0]TimeCnt_0;
  wire ap_done_0;
  wire ap_start_0;
  wire clk_0;
  wire reset_rtl_0_0;
  wire sw_done_0;
  wire sw_start_0;

  design_1 design_1_i
       (.CONV10_addr_0(CONV10_addr_0),
        .CONV10_weight_addr_0(CONV10_weight_addr_0),
        .CONV1_addr_0(CONV1_addr_0),
        .EachLayer_0(EachLayer_0),
        .F2_E_addr_0(F2_E_addr_0),
        .F2_S_addr_0(F2_S_addr_0),
        .F3_E_addr_0(F3_E_addr_0),
        .F3_S_addr_0(F3_S_addr_0),
        .F4_E_addr_0(F4_E_addr_0),
        .F4_S_addr_0(F4_S_addr_0),
        .F5_E_addr_0(F5_E_addr_0),
        .F5_S_addr_0(F5_S_addr_0),
        .F6_E_addr_0(F6_E_addr_0),
        .F6_S_addr_0(F6_S_addr_0),
        .F7_E_addr_0(F7_E_addr_0),
        .F7_S_addr_0(F7_S_addr_0),
        .F8_E_addr_0(F8_E_addr_0),
        .F8_S_addr_0(F8_S_addr_0),
        .F9_E_addr_0(F9_E_addr_0),
        .F9_S_addr_0(F9_S_addr_0),
        .M00_AXI_0_araddr(M00_AXI_0_araddr),
        .M00_AXI_0_arburst(M00_AXI_0_arburst),
        .M00_AXI_0_arcache(M00_AXI_0_arcache),
        .M00_AXI_0_arlen(M00_AXI_0_arlen),
        .M00_AXI_0_arlock(M00_AXI_0_arlock),
        .M00_AXI_0_arprot(M00_AXI_0_arprot),
        .M00_AXI_0_arqos(M00_AXI_0_arqos),
        .M00_AXI_0_arready(M00_AXI_0_arready),
        .M00_AXI_0_arregion(M00_AXI_0_arregion),
        .M00_AXI_0_arsize(M00_AXI_0_arsize),
        .M00_AXI_0_arvalid(M00_AXI_0_arvalid),
        .M00_AXI_0_awaddr(M00_AXI_0_awaddr),
        .M00_AXI_0_awburst(M00_AXI_0_awburst),
        .M00_AXI_0_awcache(M00_AXI_0_awcache),
        .M00_AXI_0_awlen(M00_AXI_0_awlen),
        .M00_AXI_0_awlock(M00_AXI_0_awlock),
        .M00_AXI_0_awprot(M00_AXI_0_awprot),
        .M00_AXI_0_awqos(M00_AXI_0_awqos),
        .M00_AXI_0_awready(M00_AXI_0_awready),
        .M00_AXI_0_awregion(M00_AXI_0_awregion),
        .M00_AXI_0_awsize(M00_AXI_0_awsize),
        .M00_AXI_0_awvalid(M00_AXI_0_awvalid),
        .M00_AXI_0_bready(M00_AXI_0_bready),
        .M00_AXI_0_bresp(M00_AXI_0_bresp),
        .M00_AXI_0_bvalid(M00_AXI_0_bvalid),
        .M00_AXI_0_rdata(M00_AXI_0_rdata),
        .M00_AXI_0_rlast(M00_AXI_0_rlast),
        .M00_AXI_0_rready(M00_AXI_0_rready),
        .M00_AXI_0_rresp(M00_AXI_0_rresp),
        .M00_AXI_0_rvalid(M00_AXI_0_rvalid),
        .M00_AXI_0_wdata(M00_AXI_0_wdata),
        .M00_AXI_0_wlast(M00_AXI_0_wlast),
        .M00_AXI_0_wready(M00_AXI_0_wready),
        .M00_AXI_0_wstrb(M00_AXI_0_wstrb),
        .M00_AXI_0_wvalid(M00_AXI_0_wvalid),
        .POOL1_addr_0(POOL1_addr_0),
        .POOL3_addr_0(POOL3_addr_0),
        .POOL5_addr_0(POOL5_addr_0),
        .Parity_0(Parity_0),
        .State_0(State_0),
        .TimeCnt_0(TimeCnt_0),
        .ap_done_0(ap_done_0),
        .ap_start_0(ap_start_0),
        .clk_0(clk_0),
        .reset_rtl_0_0(reset_rtl_0_0),
        .sw_done_0(sw_done_0),
        .sw_start_0(sw_start_0));
endmodule
