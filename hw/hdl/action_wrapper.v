`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/01 21:50:19
// Design Name: 
// Module Name: action_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module action_wrapper #(
    // Parameters of Axi Master Bus Interface AXI_CARD_MEM0 ; to DDR memory
    // DDR paramaters are not used but still need to stay here to match the
    // above hierarchy.
    parameter C_M_AXI_CARD_MEM0_ID_WIDTH     = 4,
    parameter C_M_AXI_CARD_MEM0_ADDR_WIDTH   = 33,
    parameter C_M_AXI_CARD_MEM0_DATA_WIDTH   = 512,
    parameter C_M_AXI_CARD_MEM0_AWUSER_WIDTH = 1,
    parameter C_M_AXI_CARD_MEM0_ARUSER_WIDTH = 1,
    parameter C_M_AXI_CARD_MEM0_WUSER_WIDTH  = 1,
    parameter C_M_AXI_CARD_MEM0_RUSER_WIDTH  = 1,
    parameter C_M_AXI_CARD_MEM0_BUSER_WIDTH  = 1,

    // Parameters of Axi Slave Bus Interface AXI_CTRL_REG
    parameter C_S_AXI_CTRL_REG_DATA_WIDTH    = 32,
    parameter C_S_AXI_CTRL_REG_ADDR_WIDTH    = 32,

    // Parameters of Axi Master Bus Interface AXI_HOST_MEM ; to Host memory
    parameter C_M_AXI_HOST_MEM_ID_WIDTH      = 5,
    parameter C_M_AXI_HOST_MEM_ADDR_WIDTH    = 64,
    parameter C_M_AXI_HOST_MEM_DATA_WIDTH    = 1024,
    parameter C_M_AXI_HOST_MEM_AWUSER_WIDTH  = 9,
    parameter C_M_AXI_HOST_MEM_ARUSER_WIDTH  = 9,
    parameter C_M_AXI_HOST_MEM_WUSER_WIDTH   = 9,
    parameter C_M_AXI_HOST_MEM_RUSER_WIDTH   = 9,
    parameter C_M_AXI_HOST_MEM_BUSER_WIDTH   = 9,
    parameter INT_BITS                       = 64,
    parameter CONTEXT_BITS                   = 9

)
(
 input                       ap_clk ,
 input                       ap_rst_n ,
 output                      interrupt ,
 output [INT_BITS-1 : 0]     interrupt_src ,
 output [CONTEXT_BITS-1 : 0] interrupt_ctx ,
 input                       interrupt_ack ,
 //
 // AXI Control Register Interface
 input [C_S_AXI_CTRL_REG_ADDR_WIDTH-1 : 0]      s_axi_ctrl_reg_araddr ,
 output                                         s_axi_ctrl_reg_arready ,
 input                                          s_axi_ctrl_reg_arvalid ,
 input [C_S_AXI_CTRL_REG_ADDR_WIDTH-1 : 0]      s_axi_ctrl_reg_awaddr ,
 output                                         s_axi_ctrl_reg_awready ,
 input                                          s_axi_ctrl_reg_awvalid ,
 input                                          s_axi_ctrl_reg_bready ,
 output [1 : 0]                                 s_axi_ctrl_reg_bresp ,
 output                                         s_axi_ctrl_reg_bvalid ,
 output [C_S_AXI_CTRL_REG_DATA_WIDTH-1 : 0]     s_axi_ctrl_reg_rdata ,
 input                                          s_axi_ctrl_reg_rready ,
 output [1 : 0]                                 s_axi_ctrl_reg_rresp ,
 output                                         s_axi_ctrl_reg_rvalid ,
 input [C_S_AXI_CTRL_REG_DATA_WIDTH-1 : 0]      s_axi_ctrl_reg_wdata ,
 output                                         s_axi_ctrl_reg_wready ,
 input [(C_S_AXI_CTRL_REG_DATA_WIDTH/8)-1 : 0]  s_axi_ctrl_reg_wstrb ,
 input                                          s_axi_ctrl_reg_wvalid ,
 //
 // AXI Host Memory Interface
 output [C_M_AXI_HOST_MEM_ADDR_WIDTH-1 : 0]     m_axi_host_mem_araddr ,
 output [1 : 0]                                 m_axi_host_mem_arburst ,
 output [3 : 0]                                 m_axi_host_mem_arcache ,
 output [C_M_AXI_HOST_MEM_ID_WIDTH-1 : 0]       m_axi_host_mem_arid ,
 output [7 : 0]                                 m_axi_host_mem_arlen ,
 output [1 : 0]                                 m_axi_host_mem_arlock ,
 output [2 : 0]                                 m_axi_host_mem_arprot ,
 output [3 : 0]                                 m_axi_host_mem_arqos ,
 input                                          m_axi_host_mem_arready ,
 output [3 : 0]                                 m_axi_host_mem_arregion ,
 output [2 : 0]                                 m_axi_host_mem_arsize ,
 output [C_M_AXI_HOST_MEM_ARUSER_WIDTH-1 : 0]   m_axi_host_mem_aruser ,
 output                                         m_axi_host_mem_arvalid ,
 output [C_M_AXI_HOST_MEM_ADDR_WIDTH-1 : 0]     m_axi_host_mem_awaddr ,
 output [1 : 0]                                 m_axi_host_mem_awburst ,
 output [3 : 0]                                 m_axi_host_mem_awcache ,
 output [C_M_AXI_HOST_MEM_ID_WIDTH-1 : 0]       m_axi_host_mem_awid ,
 output [7 : 0]                                 m_axi_host_mem_awlen ,
 output [1 : 0]                                 m_axi_host_mem_awlock ,
 output [2 : 0]                                 m_axi_host_mem_awprot ,
 output [3 : 0]                                 m_axi_host_mem_awqos ,
 input                                          m_axi_host_mem_awready ,
 output [3 : 0]                                 m_axi_host_mem_awregion ,
 output [2 : 0]                                 m_axi_host_mem_awsize ,
 output [C_M_AXI_HOST_MEM_AWUSER_WIDTH-1 : 0]   m_axi_host_mem_awuser ,
 output                                         m_axi_host_mem_awvalid ,
 input [C_M_AXI_HOST_MEM_ID_WIDTH-1 : 0]        m_axi_host_mem_bid ,
 output                                         m_axi_host_mem_bready ,
 input [1 : 0]                                  m_axi_host_mem_bresp ,
 input [C_M_AXI_HOST_MEM_BUSER_WIDTH-1 : 0]     m_axi_host_mem_buser ,
 input                                          m_axi_host_mem_bvalid ,
 input [C_M_AXI_HOST_MEM_DATA_WIDTH-1 : 0]      m_axi_host_mem_rdata ,
 input [C_M_AXI_HOST_MEM_ID_WIDTH-1 : 0]        m_axi_host_mem_rid ,
 input                                          m_axi_host_mem_rlast ,
 output                                         m_axi_host_mem_rready ,
 input [1 : 0]                                  m_axi_host_mem_rresp ,
 input [C_M_AXI_HOST_MEM_RUSER_WIDTH-1 : 0]     m_axi_host_mem_ruser ,
 input                                          m_axi_host_mem_rvalid ,
 output [C_M_AXI_HOST_MEM_DATA_WIDTH-1 : 0]     m_axi_host_mem_wdata ,
 output                                         m_axi_host_mem_wlast ,
 input                                          m_axi_host_mem_wready ,
 output [(C_M_AXI_HOST_MEM_DATA_WIDTH/8)-1 : 0] m_axi_host_mem_wstrb ,
 output [C_M_AXI_HOST_MEM_WUSER_WIDTH-1 : 0]    m_axi_host_mem_wuser ,
 output                                         m_axi_host_mem_wvalid
);

    // Make wuser stick to 0
    assign m_axi_host_mem_wuser = 0;

  wire                            sw_start_0;
  wire     [127:0]                CONV1_addr_0;
  wire     [127:0]                POOL1_addr_0;
  wire     [127:0]                F2_E_addr_0;
  wire     [127:0]                F2_S_addr_0;
  wire     [127:0]                F3_E_addr_0;
  wire     [127:0]                F3_S_addr_0;
  wire     [127:0]                POOL3_addr_0;
  wire     [127:0]                F4_E_addr_0;
  wire     [127:0]                F4_S_addr_0;
  wire     [127:0]                F5_E_addr_0;
  wire     [127:0]                F5_S_addr_0;
  wire     [127:0]                POOL5_addr_0;
  wire     [127:0]                F6_E_addr_0;
  wire     [127:0]                F6_S_addr_0;
  wire     [127:0]                F7_E_addr_0;
  wire     [127:0]                F7_S_addr_0;
  wire     [127:0]                F8_E_addr_0;
  wire     [127:0]                F8_S_addr_0;
  wire     [127:0]                F9_E_addr_0;
  wire     [127:0]                F9_S_addr_0;
  wire     [127:0]                CONV10_addr_0;
  wire     [64:0]                 CONV10_weight_addr_0;
  
  wire                            sw_done_0;
  wire     [31:0]                 o_snap_context;
  


design_1_wrapper design_1_wrapper_0(
    .CONV10_addr_0                (CONV10_addr_0),
    .CONV10_weight_addr_0         (CONV10_weight_addr_0),
    .CONV1_addr_0                 (CONV1_addr_0),
    .EachLayer_0                  (),
    .F2_E_addr_0                  (F2_E_addr_0),
    .F2_S_addr_0                  (F2_S_addr_0),
    .F3_E_addr_0                  (F3_E_addr_0),
    .F3_S_addr_0                  (F3_S_addr_0),
    .F4_E_addr_0                  (F4_E_addr_0),
    .F4_S_addr_0                  (F4_S_addr_0),
    .F5_E_addr_0                  (F5_E_addr_0),
    .F5_S_addr_0                  (F5_S_addr_0),
    .F6_E_addr_0                  (F6_E_addr_0),
    .F6_S_addr_0                  (F6_S_addr_0),
    .F7_E_addr_0                  (F7_E_addr_0),
    .F7_S_addr_0                  (F7_S_addr_0),
    .F8_E_addr_0                  (F8_E_addr_0),
    .F8_S_addr_0                  (F8_S_addr_0),
    .F9_E_addr_0                  (F9_E_addr_0),
    .F9_S_addr_0                  (F9_S_addr_0),
    .M00_AXI_0_araddr             (m_axi_host_mem_araddr),
    .M00_AXI_0_arburst            (m_axi_host_mem_arburst),
    .M00_AXI_0_arcache            (m_axi_host_mem_arcache),
    .M00_AXI_0_arlen              (m_axi_host_mem_arlen),
    .M00_AXI_0_arlock             (m_axi_host_mem_arlock),
    .M00_AXI_0_arprot             (m_axi_host_mem_arprot),
    .M00_AXI_0_arqos              (m_axi_host_mem_arqos),
    .M00_AXI_0_arready            (m_axi_host_mem_arready),
    .M00_AXI_0_arregion           (m_axi_host_mem_arregion),
    .M00_AXI_0_arsize             (m_axi_host_mem_arsize),
    .M00_AXI_0_arvalid            (m_axi_host_mem_arvalid),
    .M00_AXI_0_awaddr             (m_axi_host_mem_awaddr),
    .M00_AXI_0_awburst            (m_axi_host_mem_awburst),
    .M00_AXI_0_awcache            (m_axi_host_mem_awcache),
    .M00_AXI_0_awlen              (m_axi_host_mem_awlen),
    .M00_AXI_0_awlock             (m_axi_host_mem_awlock),
    .M00_AXI_0_awprot             (m_axi_host_mem_awprot),
    .M00_AXI_0_awqos              (m_axi_host_mem_awqos),
    .M00_AXI_0_awready            (m_axi_host_mem_awready),
    .M00_AXI_0_awregion           (m_axi_host_mem_awregion),
    .M00_AXI_0_awsize             (m_axi_host_mem_awsize),
    .M00_AXI_0_awvalid            (m_axi_host_mem_awvalid),
    .M00_AXI_0_bready             (m_axi_host_mem_bready),
    .M00_AXI_0_bresp              (m_axi_host_mem_bresp),
    .M00_AXI_0_bvalid             (m_axi_host_mem_bvalid),
    .M00_AXI_0_rdata              (m_axi_host_mem_rdata),
    .M00_AXI_0_rlast              (m_axi_host_mem_rlast),
    .M00_AXI_0_rready             (m_axi_host_mem_rready),
    .M00_AXI_0_rresp              (m_axi_host_mem_rresp),
    .M00_AXI_0_rvalid             (m_axi_host_mem_rvalid),
    .M00_AXI_0_wdata              (m_axi_host_mem_wdata),
    .M00_AXI_0_wlast              (m_axi_host_mem_wlast),
    .M00_AXI_0_wready             (m_axi_host_mem_wready),
    .M00_AXI_0_wstrb              (m_axi_host_mem_wstrb),
    .M00_AXI_0_wvalid             (m_axi_host_mem_wvalid),
    .POOL1_addr_0                 (POOL1_addr_0),
    .POOL3_addr_0                 (POOL3_addr_0),
    .POOL5_addr_0                 (POOL5_addr_0),
    .Parity_0                     (),
    .State_0                      (),
    .TimeCnt_0                    (),
    .ap_done_0                    (),
    .ap_start_0                   (1'b0),
    .clk_0                        (ap_clk),
    .reset_rtl_0_0                (ap_rst_n),
    .sw_done_0                    (sw_done_0),
    .sw_start_0                   (sw_start_0)
    );


    
axi_lite_slave #(
    .DATA_WIDTH(C_S_AXI_CTRL_REG_DATA_WIDTH),
    .ADDR_WIDTH(C_S_AXI_CTRL_REG_ADDR_WIDTH)
) axi_lite_slave_0(
    .clk                          (ap_clk),
    .rst_n                        (ap_rst_n),

    //---- AXI Lite bus----
      // AXI write address channel
    .s_axi_awready                (s_axi_ctrl_reg_awready),
    .s_axi_awaddr                 (s_axi_ctrl_reg_awaddr),
    .s_axi_awvalid                (s_axi_ctrl_reg_awvalid),
      // axi write data channel
    .s_axi_wready                 (s_axi_ctrl_reg_wready),
    .s_axi_wdata                  (s_axi_ctrl_reg_wdata),
    .s_axi_wstrb                  (s_axi_ctrl_reg_wstrb),
    .s_axi_wvalid                 (s_axi_ctrl_reg_wvalid),
      // AXI response channel
    .s_axi_bresp                  (s_axi_ctrl_reg_bresp),
    .s_axi_bvalid                 (s_axi_ctrl_reg_bvalid),
    .s_axi_bready                 (s_axi_ctrl_reg_bready),
      // AXI read address channel
    .s_axi_arready                (s_axi_ctrl_reg_arready),
    .s_axi_arvalid                (s_axi_ctrl_reg_arvalid),
    .s_axi_araddr                 (s_axi_ctrl_reg_araddr),
      // AXI read data channel
    .s_axi_rdata                  (s_axi_ctrl_reg_rdata),
    .s_axi_rresp                  (s_axi_ctrl_reg_rresp),
    .s_axi_rready                 (s_axi_ctrl_reg_rready),
    .s_axi_rvalid                 (s_axi_ctrl_reg_rvalid), 

    //---- local control ----
    .start_pulse                  (sw_start_0),
    .CONV1_addr                   (CONV1_addr_0),
    .POOL1_addr                   (POOL1_addr_0),
    .F2_S_addr                    (F2_S_addr_0),
    .F2_E_addr                    (F2_E_addr_0),
    .F3_S_addr                    (F3_S_addr_0),
    .F3_E_addr                    (F3_E_addr_0),
    .POOL3_addr                   (POOL3_addr_0),
    .F4_S_addr                    (F4_S_addr_0),
    .F4_E_addr                    (F4_E_addr_0),
    .F5_S_addr                    (F5_S_addr_0),
    .F5_E_addr                    (F5_E_addr_0),
    .POOL5_addr                   (POOL5_addr_0),
    .F6_S_addr                    (F6_S_addr_0),
    .F6_E_addr                    (F6_E_addr_0),
    .F7_S_addr                    (F7_S_addr_0),
    .F7_E_addr                    (F7_E_addr_0),
    .F8_S_addr                    (F8_S_addr_0),
    .F8_E_addr                    (F8_E_addr_0),
    .F9_S_addr                    (F9_S_addr_0),
    .F9_E_addr                    (F9_E_addr_0),
    .CONV10_addr                  (CONV10_addr_0),
    .CONV10_weight_addr           (CONV10_weight_addr_0),

    //---- local status ----
    .done_pulse                   (sw_done_0),
    .rd_error                     (1'b0),
    .wr_error                     (1'b0),

    //---- snap status ----
    .i_action_type                (32'h10142006),
    .i_action_version             (32'h1234),
    .o_snap_context               (o_snap_context)
    );

endmodule
