// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Thu Feb 27 16:06:50 2020
// Host        : lab369-G19 running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/wx/vivado/SqueezeNet_Ristretto3/System_Ristretto1/System_Ristretto1.srcs/sources_1/bd/design_1/ip/design_1_SqueezeNet_CONV10_0_0/design_1_SqueezeNet_CONV10_0_0_stub.v
// Design      : design_1_SqueezeNet_CONV10_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu33p-fsvh2104-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "SqueezeNet_CONV10,Vivado 2019.2" *)
module design_1_SqueezeNet_CONV10_0_0(ap_clk, ap_rst_n, ap_start, ap_done, ap_idle, 
  ap_ready, m_axi_gmem_AWADDR, m_axi_gmem_AWLEN, m_axi_gmem_AWSIZE, m_axi_gmem_AWBURST, 
  m_axi_gmem_AWLOCK, m_axi_gmem_AWREGION, m_axi_gmem_AWCACHE, m_axi_gmem_AWPROT, 
  m_axi_gmem_AWQOS, m_axi_gmem_AWVALID, m_axi_gmem_AWREADY, m_axi_gmem_WDATA, 
  m_axi_gmem_WSTRB, m_axi_gmem_WLAST, m_axi_gmem_WVALID, m_axi_gmem_WREADY, 
  m_axi_gmem_BRESP, m_axi_gmem_BVALID, m_axi_gmem_BREADY, m_axi_gmem_ARADDR, 
  m_axi_gmem_ARLEN, m_axi_gmem_ARSIZE, m_axi_gmem_ARBURST, m_axi_gmem_ARLOCK, 
  m_axi_gmem_ARREGION, m_axi_gmem_ARCACHE, m_axi_gmem_ARPROT, m_axi_gmem_ARQOS, 
  m_axi_gmem_ARVALID, m_axi_gmem_ARREADY, m_axi_gmem_RDATA, m_axi_gmem_RRESP, 
  m_axi_gmem_RLAST, m_axi_gmem_RVALID, m_axi_gmem_RREADY, m_axi_gmem2_AWADDR, 
  m_axi_gmem2_AWLEN, m_axi_gmem2_AWSIZE, m_axi_gmem2_AWBURST, m_axi_gmem2_AWLOCK, 
  m_axi_gmem2_AWREGION, m_axi_gmem2_AWCACHE, m_axi_gmem2_AWPROT, m_axi_gmem2_AWQOS, 
  m_axi_gmem2_AWVALID, m_axi_gmem2_AWREADY, m_axi_gmem2_WDATA, m_axi_gmem2_WSTRB, 
  m_axi_gmem2_WLAST, m_axi_gmem2_WVALID, m_axi_gmem2_WREADY, m_axi_gmem2_BRESP, 
  m_axi_gmem2_BVALID, m_axi_gmem2_BREADY, m_axi_gmem2_ARADDR, m_axi_gmem2_ARLEN, 
  m_axi_gmem2_ARSIZE, m_axi_gmem2_ARBURST, m_axi_gmem2_ARLOCK, m_axi_gmem2_ARREGION, 
  m_axi_gmem2_ARCACHE, m_axi_gmem2_ARPROT, m_axi_gmem2_ARQOS, m_axi_gmem2_ARVALID, 
  m_axi_gmem2_ARREADY, m_axi_gmem2_RDATA, m_axi_gmem2_RRESP, m_axi_gmem2_RLAST, 
  m_axi_gmem2_RVALID, m_axi_gmem2_RREADY, input_io_info_V, output_io_info_V_TVALID, 
  output_io_info_V_TREADY, output_io_info_V_TDATA, weight_io_info_V)
/* synthesis syn_black_box black_box_pad_pin="ap_clk,ap_rst_n,ap_start,ap_done,ap_idle,ap_ready,m_axi_gmem_AWADDR[63:0],m_axi_gmem_AWLEN[7:0],m_axi_gmem_AWSIZE[2:0],m_axi_gmem_AWBURST[1:0],m_axi_gmem_AWLOCK[1:0],m_axi_gmem_AWREGION[3:0],m_axi_gmem_AWCACHE[3:0],m_axi_gmem_AWPROT[2:0],m_axi_gmem_AWQOS[3:0],m_axi_gmem_AWVALID,m_axi_gmem_AWREADY,m_axi_gmem_WDATA[255:0],m_axi_gmem_WSTRB[31:0],m_axi_gmem_WLAST,m_axi_gmem_WVALID,m_axi_gmem_WREADY,m_axi_gmem_BRESP[1:0],m_axi_gmem_BVALID,m_axi_gmem_BREADY,m_axi_gmem_ARADDR[63:0],m_axi_gmem_ARLEN[7:0],m_axi_gmem_ARSIZE[2:0],m_axi_gmem_ARBURST[1:0],m_axi_gmem_ARLOCK[1:0],m_axi_gmem_ARREGION[3:0],m_axi_gmem_ARCACHE[3:0],m_axi_gmem_ARPROT[2:0],m_axi_gmem_ARQOS[3:0],m_axi_gmem_ARVALID,m_axi_gmem_ARREADY,m_axi_gmem_RDATA[255:0],m_axi_gmem_RRESP[1:0],m_axi_gmem_RLAST,m_axi_gmem_RVALID,m_axi_gmem_RREADY,m_axi_gmem2_AWADDR[63:0],m_axi_gmem2_AWLEN[7:0],m_axi_gmem2_AWSIZE[2:0],m_axi_gmem2_AWBURST[1:0],m_axi_gmem2_AWLOCK[1:0],m_axi_gmem2_AWREGION[3:0],m_axi_gmem2_AWCACHE[3:0],m_axi_gmem2_AWPROT[2:0],m_axi_gmem2_AWQOS[3:0],m_axi_gmem2_AWVALID,m_axi_gmem2_AWREADY,m_axi_gmem2_WDATA[1023:0],m_axi_gmem2_WSTRB[127:0],m_axi_gmem2_WLAST,m_axi_gmem2_WVALID,m_axi_gmem2_WREADY,m_axi_gmem2_BRESP[1:0],m_axi_gmem2_BVALID,m_axi_gmem2_BREADY,m_axi_gmem2_ARADDR[63:0],m_axi_gmem2_ARLEN[7:0],m_axi_gmem2_ARSIZE[2:0],m_axi_gmem2_ARBURST[1:0],m_axi_gmem2_ARLOCK[1:0],m_axi_gmem2_ARREGION[3:0],m_axi_gmem2_ARCACHE[3:0],m_axi_gmem2_ARPROT[2:0],m_axi_gmem2_ARQOS[3:0],m_axi_gmem2_ARVALID,m_axi_gmem2_ARREADY,m_axi_gmem2_RDATA[1023:0],m_axi_gmem2_RRESP[1:0],m_axi_gmem2_RLAST,m_axi_gmem2_RVALID,m_axi_gmem2_RREADY,input_io_info_V[63:0],output_io_info_V_TVALID,output_io_info_V_TREADY,output_io_info_V_TDATA[127:0],weight_io_info_V[63:0]" */;
  input ap_clk;
  input ap_rst_n;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [63:0]m_axi_gmem_AWADDR;
  output [7:0]m_axi_gmem_AWLEN;
  output [2:0]m_axi_gmem_AWSIZE;
  output [1:0]m_axi_gmem_AWBURST;
  output [1:0]m_axi_gmem_AWLOCK;
  output [3:0]m_axi_gmem_AWREGION;
  output [3:0]m_axi_gmem_AWCACHE;
  output [2:0]m_axi_gmem_AWPROT;
  output [3:0]m_axi_gmem_AWQOS;
  output m_axi_gmem_AWVALID;
  input m_axi_gmem_AWREADY;
  output [255:0]m_axi_gmem_WDATA;
  output [31:0]m_axi_gmem_WSTRB;
  output m_axi_gmem_WLAST;
  output m_axi_gmem_WVALID;
  input m_axi_gmem_WREADY;
  input [1:0]m_axi_gmem_BRESP;
  input m_axi_gmem_BVALID;
  output m_axi_gmem_BREADY;
  output [63:0]m_axi_gmem_ARADDR;
  output [7:0]m_axi_gmem_ARLEN;
  output [2:0]m_axi_gmem_ARSIZE;
  output [1:0]m_axi_gmem_ARBURST;
  output [1:0]m_axi_gmem_ARLOCK;
  output [3:0]m_axi_gmem_ARREGION;
  output [3:0]m_axi_gmem_ARCACHE;
  output [2:0]m_axi_gmem_ARPROT;
  output [3:0]m_axi_gmem_ARQOS;
  output m_axi_gmem_ARVALID;
  input m_axi_gmem_ARREADY;
  input [255:0]m_axi_gmem_RDATA;
  input [1:0]m_axi_gmem_RRESP;
  input m_axi_gmem_RLAST;
  input m_axi_gmem_RVALID;
  output m_axi_gmem_RREADY;
  output [63:0]m_axi_gmem2_AWADDR;
  output [7:0]m_axi_gmem2_AWLEN;
  output [2:0]m_axi_gmem2_AWSIZE;
  output [1:0]m_axi_gmem2_AWBURST;
  output [1:0]m_axi_gmem2_AWLOCK;
  output [3:0]m_axi_gmem2_AWREGION;
  output [3:0]m_axi_gmem2_AWCACHE;
  output [2:0]m_axi_gmem2_AWPROT;
  output [3:0]m_axi_gmem2_AWQOS;
  output m_axi_gmem2_AWVALID;
  input m_axi_gmem2_AWREADY;
  output [1023:0]m_axi_gmem2_WDATA;
  output [127:0]m_axi_gmem2_WSTRB;
  output m_axi_gmem2_WLAST;
  output m_axi_gmem2_WVALID;
  input m_axi_gmem2_WREADY;
  input [1:0]m_axi_gmem2_BRESP;
  input m_axi_gmem2_BVALID;
  output m_axi_gmem2_BREADY;
  output [63:0]m_axi_gmem2_ARADDR;
  output [7:0]m_axi_gmem2_ARLEN;
  output [2:0]m_axi_gmem2_ARSIZE;
  output [1:0]m_axi_gmem2_ARBURST;
  output [1:0]m_axi_gmem2_ARLOCK;
  output [3:0]m_axi_gmem2_ARREGION;
  output [3:0]m_axi_gmem2_ARCACHE;
  output [2:0]m_axi_gmem2_ARPROT;
  output [3:0]m_axi_gmem2_ARQOS;
  output m_axi_gmem2_ARVALID;
  input m_axi_gmem2_ARREADY;
  input [1023:0]m_axi_gmem2_RDATA;
  input [1:0]m_axi_gmem2_RRESP;
  input m_axi_gmem2_RLAST;
  input m_axi_gmem2_RVALID;
  output m_axi_gmem2_RREADY;
  input [63:0]input_io_info_V;
  output output_io_info_V_TVALID;
  input output_io_info_V_TREADY;
  output [127:0]output_io_info_V_TDATA;
  input [63:0]weight_io_info_V;
endmodule
