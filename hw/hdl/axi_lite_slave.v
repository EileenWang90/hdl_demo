/*
 * Copyright 2019 International Business Machines
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
`timescale 1ns/1ns

module axi_lite_slave #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32
)(
                      input                            clk              ,
                      input                            rst_n            ,

                      //---- AXI Lite bus----
                        // AXI write address channel
                      output reg                       s_axi_awready    ,
                      input      [ADDR_WIDTH - 1:0]    s_axi_awaddr     ,
                      input                            s_axi_awvalid    ,
                        // axi write data channel
                      output reg                       s_axi_wready     ,
                      input      [DATA_WIDTH - 1:0]    s_axi_wdata      ,
                      input      [(DATA_WIDTH/8) - 1:0]s_axi_wstrb      ,
                      input                            s_axi_wvalid     ,
                        // AXI response channel
                      output     [01:0]                s_axi_bresp      ,
                      output reg                       s_axi_bvalid     ,
                      input                            s_axi_bready     ,
                        // AXI read address channel
                      output reg                       s_axi_arready    ,
                      input                            s_axi_arvalid    ,
                      input      [ADDR_WIDTH - 1:0]    s_axi_araddr     ,
                        // AXI read data channel
                      output reg [DATA_WIDTH - 1:0]    s_axi_rdata      ,
                      output     [01:0]                s_axi_rresp      ,
                      input                            s_axi_rready     ,
                      output reg                       s_axi_rvalid     ,

                      //---- local control ----
                      output                           start_pulse      ,
                      output     [127:0]               CONV1_addr       ,
                      output     [127:0]               POOL1_addr       ,
                      output     [127:0]               F2_S_addr        ,
                      output     [127:0]               F2_E_addr        ,
                      output     [127:0]               F3_S_addr        ,
                      output     [127:0]               F3_E_addr        ,
                      output     [127:0]               POOL3_addr       ,
                      output     [127:0]               F4_S_addr        ,
                      output     [127:0]               F4_E_addr        ,
                      output     [127:0]               F5_S_addr        ,
                      output     [127:0]               F5_E_addr        ,
                      output     [127:0]               POOL5_addr       ,
                      output     [127:0]               F6_S_addr        ,
                      output     [127:0]               F6_E_addr        ,
                      output     [127:0]               F7_S_addr        ,
                      output     [127:0]               F7_E_addr        ,
                      output     [127:0]               F8_S_addr        ,
                      output     [127:0]               F8_E_addr        ,
                      output     [127:0]               F9_S_addr        ,
                      output     [127:0]               F9_E_addr        ,
                      output     [127:0]               CONV10_addr      ,
                      output     [63:0]                CONV10_weight_addr  ,

                      //---- local status ----
                      input                            done_pulse       ,
                      input                            rd_error         ,
                      input                            wr_error         ,

                      //---- snap status ----
                      input      [31:0]                i_action_type    ,
                      input      [31:0]                i_action_version ,
                      output     [31:0]                o_snap_context
                      );
            

//---- declarations ----
 wire[31:0] REG_snap_control_rd;
 wire[31:0] REG_user_status;

 wire[31:0] regw_snap_status;
 wire[31:0] regw_snap_int_enable;
 wire[31:0] regw_snap_context;
//==== local control ====
 wire[31:0] regw_control;

 wire[63:0] regw_conv1_raddr;
 wire[63:0] regw_conv1_waddr;

 wire[63:0] regw_pool1_raddr;
 wire[63:0] regw_pool1_waddr;

 wire[63:0] regw_f2s_raddr;
 wire[63:0] regw_f2s_waddr;

 wire[63:0] regw_f2e_raddr;
 wire[63:0] regw_f2e_waddr;

 wire[63:0] regw_f3s_raddr;
 wire[63:0] regw_f3s_waddr;

 wire[63:0] regw_f3e_raddr;
 wire[63:0] regw_f3e_waddr;

 wire[63:0] regw_pool3_raddr;
 wire[63:0] regw_pool3_waddr;

 wire[63:0] regw_f4s_raddr;
 wire[63:0] regw_f4s_waddr;

 wire[63:0] regw_f4e_raddr;
 wire[63:0] regw_f4e_waddr;

 wire[63:0] regw_f5s_raddr;
 wire[63:0] regw_f5s_waddr;

 wire[63:0] regw_f5e_raddr;
 wire[63:0] regw_f5e_waddr;
 
 wire[63:0] regw_pool5_raddr;
 wire[63:0] regw_pool5_waddr;
 
 wire[63:0] regw_f6s_raddr;
 wire[63:0] regw_f6s_waddr;

 wire[63:0] regw_f6e_raddr;
 wire[63:0] regw_f6e_waddr;

 wire[63:0] regw_f7s_raddr;
 wire[63:0] regw_f7s_waddr;

 wire[63:0] regw_f7e_raddr;
 wire[63:0] regw_f7e_waddr;

 wire[63:0] regw_f8s_raddr;
 wire[63:0] regw_f8s_waddr;

 wire[63:0] regw_f8e_raddr;
 wire[63:0] regw_f8e_waddr;

 wire[63:0] regw_f9s_raddr;
 wire[63:0] regw_f9s_waddr;

 wire[63:0] regw_f9e_raddr;
 wire[63:0] regw_f9e_waddr;

 wire[63:0] regw_conv10_raddr;
 wire[63:0] regw_conv10_waddr;

 wire[63:0] regw_conv10_weight_raddr;

 //==== local control end ====

 wire[31:0] regw_soft_reset;

 reg [31:0] write_address;
 wire[31:0] wr_mask;

 wire       soft_reset;
 

 ///////////////////////////////////////////////////
 //***********************************************//
 //>                REGISTERS                    <//
 //***********************************************//
 //                                               //
 /**/   reg [31:0] REG_snap_control          ;  /**/
 /**/   reg [31:0] REG_snap_int_enable       ;  /**/
 /**/   reg [31:0] REG_snap_context          ;  /**/
 /*-----------------------------------------------*/
        reg [31:0] REG_user_control          ; 

        reg [63:0] REG_conv1_raddr           ; 
        reg [63:0] REG_conv1_waddr           ; 

        reg [63:0] REG_pool1_raddr           ; 
        reg [63:0] REG_pool1_waddr           ; 

        reg [63:0] REG_f2s_raddr             ;
        reg [63:0] REG_f2s_waddr             ;
                    
        reg [63:0] REG_f2e_raddr             ;
        reg [63:0] REG_f2e_waddr             ;
                    
        reg [63:0] REG_f3s_raddr             ;
        reg [63:0] REG_f3s_waddr             ;
                    
        reg [63:0] REG_f3e_raddr             ;
        reg [63:0] REG_f3e_waddr             ;
       
        reg [63:0] REG_pool3_raddr           ;
        reg [63:0] REG_pool3_waddr           ;
       
        reg [63:0] REG_f4s_raddr             ;
        reg [63:0] REG_f4s_waddr             ;
       
        reg [63:0] REG_f4e_raddr             ;
        reg [63:0] REG_f4e_waddr             ;
       
        reg [63:0] REG_f5s_raddr             ;
        reg [63:0] REG_f5s_waddr             ;
                    
        reg [63:0] REG_f5e_raddr             ;
        reg [63:0] REG_f5e_waddr             ;
        
        reg [63:0] REG_pool5_raddr           ;
        reg [63:0] REG_pool5_waddr           ;
                    
        reg [63:0] REG_f6s_raddr             ;
        reg [63:0] REG_f6s_waddr             ;
                    
        reg [63:0] REG_f6e_raddr             ;
        reg [63:0] REG_f6e_waddr             ;
                    
        reg [63:0] REG_f7s_raddr             ;
        reg [63:0] REG_f7s_waddr             ;
                    
        reg [63:0] REG_f7e_raddr             ;
        reg [63:0] REG_f7e_waddr             ;
                    
        reg [63:0] REG_f8s_raddr             ;
        reg [63:0] REG_f8s_waddr             ;
                    
        reg [63:0] REG_f8e_raddr             ;
        reg [63:0] REG_f8e_waddr             ;
                    
        reg [63:0] REG_f9s_raddr             ;
        reg [63:0] REG_f9s_waddr             ;
                    
        reg [63:0] REG_f9e_raddr             ;
        reg [63:0] REG_f9e_waddr             ;
       
        reg [63:0] REG_conv10_raddr          ;
        reg [63:0] REG_conv10_waddr          ;
       
        reg [63:0] REG_conv10_weight_raddr   ;

 /**/   reg [31:0] REG_soft_reset            ;  /**/
 //                                               //
 //-----------------------------------------------//
 //                                               //
 ///////////////////////////////////////////////////


//---- parameters ----
 // Register addresses arrangement
 parameter ADDR_SNAP_CONTROL        = 32'h00,
           ADDR_SNAP_INT_ENABLE     = 32'h04,
           ADDR_SNAP_ACTION_TYPE    = 32'h10,
           ADDR_SNAP_ACTION_VERSION = 32'h14,
           ADDR_SNAP_CONTEXT        = 32'h20,
           // User defined below
           ADDR_USER_STATUS         = 32'h30,
           ADDR_USER_CONTROL        = 32'h34,

          //  ADDR_CONV1_READ_H        = 32'h40, 
          //  ADDR_CONV1_READ_L        = 32'h41,
          //  ADDR_CONV1_WRITE_H       = 32'h42,
          //  ADDR_CONV1_WRITE_L       = 32'h43,

          //  ADDR_POOL1_READ_H        = 32'h44,
          //  ADDR_POOL1_READ_L        = 32'h45,
          //  ADDR_POOL1_WRITE_H       = 32'h46,
          //  ADDR_POOL1_WRITE_L       = 32'h47,

          //  ADDR_F2_S_READ_H         = 32'h48,
          //  ADDR_F2_S_READ_L         = 32'h49,
          //  ADDR_F2_S_WRITE_H        = 32'h4A,
          //  ADDR_F2_S_WRITE_L        = 32'h4B,

          //  ADDR_F2_E_READ_H         = 32'h4C, 
          //  ADDR_F2_E_READ_L         = 32'h4D, 
          //  ADDR_F2_E_WRITE_H        = 32'h4E, 
          //  ADDR_F2_E_WRITE_L        = 32'h4F, 

          //  ADDR_F3_S_READ_H         = 32'h50, 
          //  ADDR_F3_S_READ_L         = 32'h51, 
          //  ADDR_F3_S_WRITE_H        = 32'h52, 
          //  ADDR_F3_S_WRITE_L        = 32'h53, 

          //  ADDR_F3_E_READ_H         = 32'h54, 
          //  ADDR_F3_E_READ_L         = 32'h55, 
          //  ADDR_F3_E_WRITE_H        = 32'h56, 
          //  ADDR_F3_E_WRITE_L        = 32'h57, 

          //  ADDR_POOL3_READ_H        = 32'h58, 
          //  ADDR_POOL3_READ_L        = 32'h59, 
          //  ADDR_POOL3_WRITE_H       = 32'h5A, 
          //  ADDR_POOL3_WRITE_L       = 32'h5B, 

          //  ADDR_F4_S_READ_H         = 32'h5C, 
          //  ADDR_F4_S_READ_L         = 32'h5D, 
          //  ADDR_F4_S_WRITE_H        = 32'h5E, 
          //  ADDR_F4_S_WRITE_L        = 32'h5F, 

          //  ADDR_F4_E_READ_H         = 32'h60, 
          //  ADDR_F4_E_READ_L         = 32'h61, 
          //  ADDR_F4_E_WRITE_H        = 32'h62, 
          //  ADDR_F4_E_WRITE_L        = 32'h63, 

          //  ADDR_F5_S_READ_H         = 32'h64, 
          //  ADDR_F5_S_READ_L         = 32'h65,
          //  ADDR_F5_S_WRITE_H        = 32'h66,
          //  ADDR_F5_S_WRITE_L        = 32'h67,

          //  ADDR_F5_E_READ_H         = 32'h68, 
          //  ADDR_F5_E_READ_L         = 32'h69,
          //  ADDR_F5_E_WRITE_H        = 32'h6A,
          //  ADDR_F5_E_WRITE_L        = 32'h6B,

          //  ADDR_POOL5_READ_H        = 32'h6C, 
          //  ADDR_POOL5_READ_L        = 32'h6D,
          //  ADDR_POOL5_WRITE_H       = 32'h6E,
          //  ADDR_POOL5_WRITE_L       = 32'h6F,

          //  ADDR_F6_S_READ_H         = 32'h70, 
          //  ADDR_F6_S_READ_L         = 32'h71,
          //  ADDR_F6_S_WRITE_H        = 32'h72,
          //  ADDR_F6_S_WRITE_L        = 32'h73,

          //  ADDR_F6_E_READ_H         = 32'h74, 
          //  ADDR_F6_E_READ_L         = 32'h75,
          //  ADDR_F6_E_WRITE_H        = 32'h76,
          //  ADDR_F6_E_WRITE_L        = 32'h77,

          //  ADDR_F7_S_READ_H         = 32'h78, 
          //  ADDR_F7_S_READ_L         = 32'h79,
          //  ADDR_F7_S_WRITE_H        = 32'h7A,
          //  ADDR_F7_S_WRITE_L        = 32'h7B,

          //  ADDR_F7_E_READ_H         = 32'h7C, 
          //  ADDR_F7_E_READ_L         = 32'h7D,
          //  ADDR_F7_E_WRITE_H        = 32'h7E,
          //  ADDR_F7_E_WRITE_L        = 32'h7F,

          //  ADDR_F8_S_READ_H         = 32'h80, 
          //  ADDR_F8_S_READ_L         = 32'h81,
          //  ADDR_F8_S_WRITE_H        = 32'h82,
          //  ADDR_F8_S_WRITE_L        = 32'h83,

          //  ADDR_F8_E_READ_H         = 32'h84, 
          //  ADDR_F8_E_READ_L         = 32'h85,
          //  ADDR_F8_E_WRITE_H        = 32'h86,
          //  ADDR_F8_E_WRITE_L        = 32'h87,

          //  ADDR_F9_S_READ_H         = 32'h88, 
          //  ADDR_F9_S_READ_L         = 32'h89,
          //  ADDR_F9_S_WRITE_H        = 32'h8A,
          //  ADDR_F9_S_WRITE_L        = 32'h8B,

          //  ADDR_F9_E_READ_H         = 32'h8C, 
          //  ADDR_F9_E_READ_L         = 32'h8D,
          //  ADDR_F9_E_WRITE_H        = 32'h8E,
          //  ADDR_F9_E_WRITE_L        = 32'h8F,

          //  ADDR_CONV10_READ_H       = 32'h90, 
          //  ADDR_CONV10_READ_L       = 32'h91,
          //  ADDR_CONV10_WRITE_H      = 32'h92,
          //  ADDR_CONV10_WRITE_L      = 32'h93,

          //  ADDR_CONV10_WEIGHT_H     = 32'h94,
          //  ADDR_CONV10_WEIGHT_L     = 32'h95,

          //  ADDR_SOFT_RESET          = 32'hA0;

               ADDR_CONV1_READ_H      = 32'h40,
               ADDR_CONV1_READ_L      = 32'h44,
               ADDR_CONV1_WRITE_H     = 32'h48,
               ADDR_CONV1_WRITE_L     = 32'h4C,

               ADDR_POOL1_READ_H      = 32'h50,
               ADDR_POOL1_READ_L      = 32'h54,
               ADDR_POOL1_WRITE_H     = 32'h58,
               ADDR_POOL1_WRITE_L     = 32'h5C,

               ADDR_F2_S_READ_H      = 32'h60,
               ADDR_F2_S_READ_L      = 32'h64,
               ADDR_F2_S_WRITE_H     = 32'h68,
               ADDR_F2_S_WRITE_L     = 32'h6C,

               ADDR_F2_E_READ_H      = 32'h70,
               ADDR_F2_E_READ_L      = 32'h74,
               ADDR_F2_E_WRITE_H     = 32'h78,
               ADDR_F2_E_WRITE_L     = 32'h7C,

               ADDR_F3_S_READ_H      = 32'h80,
               ADDR_F3_S_READ_L      = 32'h84,
               ADDR_F3_S_WRITE_H     = 32'h88,
               ADDR_F3_S_WRITE_L     = 32'h8C,

               ADDR_F3_E_READ_H      = 32'h90,
               ADDR_F3_E_READ_L      = 32'h94,
               ADDR_F3_E_WRITE_H     = 32'h98,
               ADDR_F3_E_WRITE_L     = 32'h9C,

               ADDR_POOL3_READ_H      = 32'ha0,
               ADDR_POOL3_READ_L      = 32'ha4,
               ADDR_POOL3_WRITE_H     = 32'ha8,
               ADDR_POOL3_WRITE_L     = 32'haC,

               ADDR_F4_S_READ_H      = 32'hb0,
               ADDR_F4_S_READ_L      = 32'hb4,
               ADDR_F4_S_WRITE_H     = 32'hb8,
               ADDR_F4_S_WRITE_L     = 32'hbC,

               ADDR_F4_E_READ_H      = 32'hc0,
               ADDR_F4_E_READ_L      = 32'hc4,
               ADDR_F4_E_WRITE_H     = 32'hc8,
               ADDR_F4_E_WRITE_L     = 32'hcC,

               ADDR_F5_S_READ_H      = 32'hd0,
               ADDR_F5_S_READ_L      = 32'hd4,
               ADDR_F5_S_WRITE_H     = 32'hd8,
               ADDR_F5_S_WRITE_L     = 32'hdC,

               ADDR_F5_E_READ_H      = 32'he0,
               ADDR_F5_E_READ_L      = 32'he4,
               ADDR_F5_E_WRITE_H     = 32'he8,
               ADDR_F5_E_WRITE_L     = 32'heC,

               ADDR_POOL5_READ_H      = 32'hf0,
               ADDR_POOL5_READ_L      = 32'hf4,
               ADDR_POOL5_WRITE_H     = 32'hf8,
               ADDR_POOL5_WRITE_L     = 32'hfC,

               ADDR_F6_S_READ_H      = 32'h100,
               ADDR_F6_S_READ_L      = 32'h104,
               ADDR_F6_S_WRITE_H     = 32'h108,
               ADDR_F6_S_WRITE_L     = 32'h10C,

               ADDR_F6_E_READ_H      = 32'h110,
               ADDR_F6_E_READ_L      = 32'h114,
               ADDR_F6_E_WRITE_H     = 32'h118,
               ADDR_F6_E_WRITE_L     = 32'h11C,

               ADDR_F7_S_READ_H      = 32'h120,
               ADDR_F7_S_READ_L      = 32'h124,
               ADDR_F7_S_WRITE_H     = 32'h128,
               ADDR_F7_S_WRITE_L     = 32'h12C,

               ADDR_F7_E_READ_H      = 32'h130,
               ADDR_F7_E_READ_L      = 32'h134,
               ADDR_F7_E_WRITE_H     = 32'h138,
               ADDR_F7_E_WRITE_L     = 32'h13C,

               ADDR_F8_S_READ_H      = 32'h140,
               ADDR_F8_S_READ_L      = 32'h144,
               ADDR_F8_S_WRITE_H     = 32'h148,
               ADDR_F8_S_WRITE_L     = 32'h14C,

               ADDR_F8_E_READ_H      = 32'h150,
               ADDR_F8_E_READ_L      = 32'h154,
               ADDR_F8_E_WRITE_H     = 32'h158,
               ADDR_F8_E_WRITE_L     = 32'h15C,

               ADDR_F9_S_READ_H      = 32'h160,
               ADDR_F9_S_READ_L      = 32'h164,
               ADDR_F9_S_WRITE_H     = 32'h168,
               ADDR_F9_S_WRITE_L     = 32'h16C,

               ADDR_F9_E_READ_H      = 32'h170,
               ADDR_F9_E_READ_L      = 32'h174,
               ADDR_F9_E_WRITE_H     = 32'h178,
               ADDR_F9_E_WRITE_L     = 32'h17C,

               ADDR_CONV10_READ_H      = 32'h180,
               ADDR_CONV10_READ_L      = 32'h184,
               ADDR_CONV10_WRITE_H     = 32'h188,
               ADDR_CONV10_WRITE_L     = 32'h18C,

               ADDR_CONV10_WEIGHT_H     = 32'h190,
               ADDR_CONV10_WEIGHT_L     = 32'h194,

               ADDR_SOFT_RESET          = 32'h1A0;

 

//---- local controlling signals assignments ----
 assign CONV1_addr          = {REG_conv1_waddr, REG_conv1_raddr};
 assign POOL1_addr          = {REG_pool1_waddr, REG_pool1_raddr};
 assign F2_S_addr           = {REG_f2s_waddr, REG_f2s_raddr};
 assign F2_E_addr           = {REG_f2e_waddr, REG_f2e_raddr};
 assign F3_S_addr           = {REG_f3s_waddr, REG_f3s_raddr};
 assign F3_E_addr           = {REG_f3e_waddr, REG_f3e_raddr};
 assign POOL3_addr          = {REG_pool3_waddr, REG_pool3_raddr};
 assign F4_S_addr           = {REG_f4s_waddr, REG_f4s_raddr};
 assign F4_E_addr           = {REG_f4e_waddr, REG_f4e_raddr};
 assign F5_S_addr           = {REG_f5s_waddr, REG_f5s_raddr};
 assign F5_E_addr           = {REG_f5e_waddr, REG_f5e_raddr};
 assign POOL5_addr          = {REG_pool5_waddr, REG_pool5_raddr};
 assign F6_S_addr           = {REG_f6s_waddr, REG_f6s_raddr};
 assign F6_E_addr           = {REG_f6e_waddr, REG_f6e_raddr};
 assign F7_S_addr           = {REG_f7s_waddr, REG_f7s_raddr};
 assign F7_E_addr           = {REG_f7e_waddr, REG_f7e_raddr};
 assign F8_S_addr           = {REG_f8s_waddr, REG_f8s_raddr};
 assign F8_E_addr           = {REG_f8e_waddr, REG_f8e_raddr};
 assign F9_S_addr           = {REG_f9s_waddr, REG_f9s_raddr};
 assign F9_E_addr           = {REG_f9e_waddr, REG_f9e_raddr};
 assign CONV10_addr         = {REG_conv10_waddr, REG_conv10_raddr};
 assign CONV10_weight_addr  = REG_conv10_weight_raddr;

 assign o_snap_context = REG_snap_context;
 assign soft_reset     = REG_soft_reset[0];

/***********************************************************************
*                          writing registers                           *
***********************************************************************/

//---- write address capture ----
 always@(posedge clk or negedge rst_n)
   if(~rst_n)
     write_address <= 32'd0;
   else if(s_axi_awvalid & s_axi_awready)
     write_address <= s_axi_awaddr;

//---- write address ready ----
 always@(posedge clk or negedge rst_n)
   if(~rst_n)
     s_axi_awready <= 1'b1;
   else if(s_axi_awvalid)
     s_axi_awready <= 1'b0;
   else if(s_axi_wvalid & s_axi_wready)
     s_axi_awready <= 1'b1;

//---- write data ready ----
 always@(posedge clk or negedge rst_n)
   if(~rst_n)
     s_axi_wready <= 1'b0;
   else if(s_axi_awvalid & s_axi_awready)
     s_axi_wready <= 1'b1;
   else if(s_axi_wvalid)
     s_axi_wready <= 1'b0;

//---- handle write data strobe ----
 assign wr_mask = {{8{s_axi_wstrb[3]}},{8{s_axi_wstrb[2]}},{8{s_axi_wstrb[1]}},{8{s_axi_wstrb[0]}}};

 assign regw_snap_status     = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_snap_control)};
 assign regw_snap_int_enable = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_snap_int_enable)};
 assign regw_snap_context    = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_snap_context)};
 assign regw_control         = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_user_control)};
 
 assign regw_conv1_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_conv1_raddr)};
 assign regw_conv1_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_conv1_waddr)};

 assign regw_pool1_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_pool1_raddr)};
 assign regw_pool1_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_pool1_waddr)};

 assign regw_f2s_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f2s_raddr)};
 assign regw_f2s_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f2s_waddr)};

 assign regw_f2e_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f2e_raddr)};
 assign regw_f2e_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f2e_waddr)};

 assign regw_f3s_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f3s_raddr)};
 assign regw_f3s_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f3s_waddr)};

 assign regw_f3e_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f3e_raddr)};
 assign regw_f3e_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f3e_waddr)};

 assign regw_pool3_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_pool3_raddr)};
 assign regw_pool3_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_pool3_waddr)};

 assign regw_f4s_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f4s_raddr)};
 assign regw_f4s_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f4s_waddr)};

 assign regw_f4e_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f4e_raddr)};
 assign regw_f4e_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f4e_waddr)};

 assign regw_f5s_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f5s_raddr)};
 assign regw_f5s_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f5s_waddr)};

 assign regw_f5e_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f5e_raddr)};
 assign regw_f5e_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f5e_waddr)};

 assign regw_pool5_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_pool5_raddr)};
 assign regw_pool5_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_pool5_waddr)};

 assign regw_f6s_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f6s_raddr)};
 assign regw_f6s_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f6s_waddr)};

 assign regw_f6e_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f6e_raddr)};
 assign regw_f6e_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f6e_waddr)};

 assign regw_f7s_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f7s_raddr)};
 assign regw_f7s_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f7s_waddr)};

 assign regw_f7e_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f7e_raddr)};
 assign regw_f7e_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f7e_waddr)};

 assign regw_f8s_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f8s_raddr)};
 assign regw_f8s_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f8s_waddr)};

 assign regw_f8e_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f8e_raddr)};
 assign regw_f8e_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f8e_waddr)};

 assign regw_f9s_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f9s_raddr)};
 assign regw_f9s_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f9s_waddr)};

 assign regw_f9e_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f9e_raddr)};
 assign regw_f9e_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_f9e_waddr)};

 assign regw_conv10_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_conv10_raddr)};
 assign regw_conv10_waddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_conv10_waddr)};

 assign regw_conv10_weight_raddr = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_conv10_weight_raddr)};

 assign regw_soft_reset      = {(s_axi_wdata&wr_mask)|(~wr_mask&REG_soft_reset)};

//---- write registers ----
 always@(posedge clk or negedge rst_n)
   if(~rst_n)
     begin
       REG_snap_control    <= 32'd0;
       REG_snap_int_enable <= 32'd0;
       REG_snap_context    <= 32'd0;
       REG_user_control    <= 32'd0;
       REG_soft_reset      <= 32'd0;

       REG_conv1_raddr     <= 64'd0; 
       REG_conv1_waddr     <= 64'd0; 
       REG_pool1_raddr     <= 64'd0; 
       REG_pool1_waddr     <= 64'd0; 
       REG_f2s_raddr       <= 64'd0;
       REG_f2s_waddr       <= 64'd0;
 
       REG_f2e_raddr       <= 64'd0;
       REG_f2e_waddr       <= 64'd0;
 
       REG_f3s_raddr       <= 64'd0;
       REG_f3s_waddr       <= 64'd0;
 
       REG_f3e_raddr       <= 64'd0;
       REG_f3e_waddr       <= 64'd0;
       REG_pool3_raddr     <= 64'd0;
       REG_pool3_waddr     <= 64'd0;
       REG_f4s_raddr       <= 64'd0;
       REG_f4s_waddr       <= 64'd0;
       REG_f4e_raddr       <= 64'd0;
       REG_f4e_waddr       <= 64'd0;
       REG_f5s_raddr       <= 64'd0;
       REG_f5s_waddr       <= 64'd0;
 
       REG_f5e_raddr       <= 64'd0;
       REG_f5e_waddr       <= 64'd0;
       REG_pool5_raddr     <= 64'd0;
       REG_pool5_waddr     <= 64'd0;
 
       REG_f6s_raddr       <= 64'd0;
       REG_f6s_waddr       <= 64'd0;
 
       REG_f6e_raddr       <= 64'd0;
       REG_f6e_waddr       <= 64'd0;
 
       REG_f7s_raddr       <= 64'd0;
       REG_f7s_waddr       <= 64'd0;
 
       REG_f7e_raddr       <= 64'd0;
       REG_f7e_waddr       <= 64'd0;
 
       REG_f8s_raddr       <= 64'd0;
       REG_f8s_waddr       <= 64'd0;
 
       REG_f8e_raddr       <= 64'd0;
       REG_f8e_waddr       <= 64'd0;
 
       REG_f9s_raddr       <= 64'd0;
       REG_f9s_waddr       <= 64'd0;
 
       REG_f9e_raddr             <= 64'd0;
       REG_f9e_waddr             <= 64'd0;
       REG_conv10_raddr          <= 64'd0;
       REG_conv10_waddr          <= 64'd0;
       REG_conv10_weight_raddr   <= 64'd0;
     end
    else if(soft_reset)
    begin
       REG_snap_control    <= 32'd0;
       REG_snap_int_enable <= 32'd0;
       REG_snap_context    <= 32'd0;
       REG_user_control    <= 32'd0;
       REG_soft_reset      <= 32'd0;

       REG_conv1_raddr     <= 64'd0; 
       REG_conv1_waddr     <= 64'd0; 
       REG_pool1_raddr     <= 64'd0; 
       REG_pool1_waddr     <= 64'd0; 
       REG_f2s_raddr       <= 64'd0;
       REG_f2s_waddr       <= 64'd0;
 
       REG_f2e_raddr       <= 64'd0;
       REG_f2e_waddr       <= 64'd0;
 
       REG_f3s_raddr       <= 64'd0;
       REG_f3s_waddr       <= 64'd0;
 
       REG_f3e_raddr       <= 64'd0;
       REG_f3e_waddr       <= 64'd0;
       REG_pool3_raddr     <= 64'd0;
       REG_pool3_waddr     <= 64'd0;
       REG_f4s_raddr       <= 64'd0;
       REG_f4s_waddr       <= 64'd0;
       REG_f4e_raddr       <= 64'd0;
       REG_f4e_waddr       <= 64'd0;
       REG_f5s_raddr       <= 64'd0;
       REG_f5s_waddr       <= 64'd0;
 
       REG_f5e_raddr       <= 64'd0;
       REG_f5e_waddr       <= 64'd0;
       REG_pool5_raddr     <= 64'd0;
       REG_pool5_waddr     <= 64'd0;
 
       REG_f6s_raddr       <= 64'd0;
       REG_f6s_waddr       <= 64'd0;
 
       REG_f6e_raddr       <= 64'd0;
       REG_f6e_waddr       <= 64'd0;
 
       REG_f7s_raddr       <= 64'd0;
       REG_f7s_waddr       <= 64'd0;
 
       REG_f7e_raddr       <= 64'd0;
       REG_f7e_waddr       <= 64'd0;
 
       REG_f8s_raddr       <= 64'd0;
       REG_f8s_waddr       <= 64'd0;
 
       REG_f8e_raddr       <= 64'd0;
       REG_f8e_waddr       <= 64'd0;
 
       REG_f9s_raddr       <= 64'd0;
       REG_f9s_waddr       <= 64'd0;
 
       REG_f9e_raddr             <= 64'd0;
       REG_f9e_waddr             <= 64'd0;
       REG_conv10_raddr          <= 64'd0;
       REG_conv10_waddr          <= 64'd0;
       REG_conv10_weight_raddr   <= 64'd0;
    end
   else if(s_axi_wvalid & s_axi_wready)
     case(write_address)
       ADDR_SNAP_CONTROL     : REG_snap_control    <= regw_snap_status;
       ADDR_SNAP_INT_ENABLE  : REG_snap_int_enable <= regw_snap_int_enable;
       ADDR_SNAP_CONTEXT     : REG_snap_context    <= regw_snap_context;

       ADDR_USER_CONTROL     : REG_user_control    <= regw_control;

       // ADDR_SOURCE_ADDRESS_H : REG_source_address  <= {regw_source_address,REG_source_address[31:00]};
       // ADDR_SOURCE_ADDRESS_L : REG_source_address  <= {REG_source_address[63:32],regw_source_address};
       // ADDR_TARGET_ADDRESS_H : REG_target_address  <= {regw_target_address,REG_target_address[31:00]};
       // ADDR_TARGET_ADDRESS_L : REG_target_address  <= {REG_target_address[63:32],regw_target_address};
       // ADDR_MB_WIDTH_HEIGHT  : REG_mb_width_height <= regw_mb_width_height;

       ADDR_CONV1_READ_H     : REG_conv1_raddr     <= {regw_conv1_raddr,REG_conv1_raddr[31:00]};
       ADDR_CONV1_READ_L     : REG_conv1_raddr     <= {REG_conv1_raddr[63:32],regw_conv1_raddr};
       ADDR_CONV1_WRITE_H    : REG_conv1_waddr     <= {regw_conv1_waddr,REG_conv1_waddr[31:00]};
       ADDR_CONV1_WRITE_L    : REG_conv1_waddr     <= {REG_conv1_waddr[63:32],regw_conv1_waddr};
       ADDR_POOL1_READ_H     : REG_pool1_raddr     <= {regw_pool1_raddr,REG_pool1_raddr[31:00]};
       ADDR_POOL1_READ_L     : REG_pool1_raddr     <= {REG_pool1_raddr[63:32],regw_pool1_raddr};
       ADDR_POOL1_WRITE_H    : REG_pool1_waddr     <= {regw_pool1_waddr,REG_pool1_waddr[31:00]};
       ADDR_POOL1_WRITE_L    : REG_pool1_waddr     <= {REG_pool1_waddr[63:32],regw_pool1_waddr};
       ADDR_F2_S_READ_H      : REG_f2s_raddr       <= {regw_f2s_raddr,REG_f2s_raddr[31:00]};
       ADDR_F2_S_READ_L      : REG_f2s_raddr       <= {REG_f2s_raddr[63:32],regw_f2s_raddr};
       ADDR_F2_S_WRITE_H     : REG_f2s_waddr       <= {regw_f2s_waddr,REG_f2s_waddr[31:00]};
       ADDR_F2_S_WRITE_L     : REG_f2s_waddr       <= {REG_f2s_waddr[63:32],regw_f2s_waddr};
       ADDR_F2_E_READ_H      : REG_f2e_raddr       <= {regw_f2e_raddr,REG_f2e_raddr[31:00]};
       ADDR_F2_E_READ_L      : REG_f2e_raddr       <= {REG_f2e_raddr[63:32],regw_f2e_raddr};
       ADDR_F2_E_WRITE_H     : REG_f2e_waddr       <= {regw_f2e_waddr,REG_f2e_waddr[31:00]};
       ADDR_F2_E_WRITE_L     : REG_f2e_waddr       <= {REG_f2e_waddr[63:32],regw_f2e_waddr};
       ADDR_F3_S_READ_H      : REG_f3s_raddr       <= {regw_f3s_raddr,REG_f3s_raddr[31:00]};
       ADDR_F3_S_READ_L      : REG_f3s_raddr       <= {REG_f3s_raddr[63:32],regw_f3s_raddr};
       ADDR_F3_S_WRITE_H     : REG_f3s_waddr       <= {regw_f3s_waddr,REG_f3s_waddr[31:00]};
       ADDR_F3_S_WRITE_L     : REG_f3s_waddr       <= {REG_f3s_waddr[63:32],regw_f3s_waddr};
       ADDR_F3_E_READ_H      : REG_f3e_raddr       <= {regw_f3e_raddr,REG_f3e_raddr[31:00]};
       ADDR_F3_E_READ_L      : REG_f3e_raddr       <= {REG_f3e_raddr[63:32],regw_f3e_raddr};
       ADDR_F3_E_WRITE_H     : REG_f3e_waddr       <= {regw_f3e_waddr,REG_f3e_waddr[31:00]};
       ADDR_F3_E_WRITE_L     : REG_f3e_waddr       <= {REG_f3e_waddr[63:32],regw_f3e_waddr};
       ADDR_POOL3_READ_H     : REG_pool3_raddr     <= {regw_pool3_raddr,REG_pool3_raddr[31:00]};
       ADDR_POOL3_READ_L     : REG_pool3_raddr     <= {REG_pool3_raddr[63:32],regw_pool3_raddr};
       ADDR_POOL3_WRITE_H    : REG_pool3_waddr     <= {regw_pool3_waddr,REG_pool3_waddr[31:00]};
       ADDR_POOL3_WRITE_L    : REG_pool3_waddr     <= {REG_pool3_waddr[63:32],regw_pool3_waddr};
       ADDR_F4_S_READ_H      : REG_f4s_raddr       <= {regw_f4s_raddr,REG_f4s_raddr[31:00]};
       ADDR_F4_S_READ_L      : REG_f4s_raddr       <= {REG_f4s_raddr[63:32],regw_f4s_raddr};
       ADDR_F4_S_WRITE_H     : REG_f4s_waddr       <= {regw_f4s_waddr,REG_f4s_waddr[31:00]};
       ADDR_F4_S_WRITE_L     : REG_f4s_waddr       <= {REG_f4s_waddr[63:32],regw_f4s_waddr};
       ADDR_F4_E_READ_H      : REG_f4e_raddr       <= {regw_f4e_raddr,REG_f4e_raddr[31:00]};
       ADDR_F4_E_READ_L      : REG_f4e_raddr       <= {REG_f4e_raddr[63:32],regw_f4e_raddr};
       ADDR_F4_E_WRITE_H     : REG_f4e_waddr       <= {regw_f4e_waddr,REG_f4e_waddr[31:00]};
       ADDR_F4_E_WRITE_L     : REG_f4e_waddr       <= {REG_f4e_waddr[63:32],regw_f4e_waddr};
       ADDR_F5_S_READ_H      : REG_f5s_raddr       <= {regw_f5s_raddr,REG_f5s_raddr[31:00]};
       ADDR_F5_S_READ_L      : REG_f5s_raddr       <= {REG_f5s_raddr[63:32],regw_f5s_raddr};
       ADDR_F5_S_WRITE_H     : REG_f5s_waddr       <= {regw_f5s_waddr,REG_f5s_waddr[31:00]};
       ADDR_F5_S_WRITE_L     : REG_f5s_waddr       <= {REG_f5s_waddr[63:32],regw_f5s_waddr};
       ADDR_F5_E_READ_H      : REG_f5e_raddr       <= {regw_f5e_raddr,REG_f5e_raddr[31:00]};
       ADDR_F5_E_READ_L      : REG_f5e_raddr       <= {REG_f5e_raddr[63:32],regw_f5e_raddr};
       ADDR_F5_E_WRITE_H     : REG_f5e_waddr       <= {regw_f5e_waddr,REG_f5e_waddr[31:00]};
       ADDR_F5_E_WRITE_L     : REG_f5e_waddr       <= {REG_f5e_waddr[63:32],regw_f5e_waddr};
       ADDR_POOL5_READ_H     : REG_pool5_raddr     <= {regw_pool5_raddr,REG_pool5_raddr[31:00]};
       ADDR_POOL5_READ_L     : REG_pool5_raddr     <= {REG_pool5_raddr[63:32],regw_pool5_raddr};
       ADDR_POOL5_WRITE_H    : REG_pool5_waddr     <= {regw_pool5_waddr,REG_pool5_waddr[31:00]};
       ADDR_POOL5_WRITE_L    : REG_pool5_waddr     <= {REG_pool5_waddr[63:32],regw_pool5_waddr};
       ADDR_F6_S_READ_H      : REG_f6s_raddr       <= {regw_f6s_raddr,REG_f6s_raddr[31:00]};
       ADDR_F6_S_READ_L      : REG_f6s_raddr       <= {REG_f6s_raddr[63:32],regw_f6s_raddr};
       ADDR_F6_S_WRITE_H     : REG_f6s_waddr       <= {regw_f6s_waddr,REG_f6s_waddr[31:00]};
       ADDR_F6_S_WRITE_L     : REG_f6s_waddr       <= {REG_f6s_waddr[63:32],regw_f6s_waddr};
       ADDR_F6_E_READ_H      : REG_f6e_raddr       <= {regw_f6e_raddr,REG_f6e_raddr[31:00]};
       ADDR_F6_E_READ_L      : REG_f6e_raddr       <= {REG_f6e_raddr[63:32],regw_f6e_raddr};
       ADDR_F6_E_WRITE_H     : REG_f6e_waddr       <= {regw_f6e_waddr,REG_f6e_waddr[31:00]};
       ADDR_F6_E_WRITE_L     : REG_f6e_waddr       <= {REG_f6e_waddr[63:32],regw_f6e_waddr};
       ADDR_F7_S_READ_H      : REG_f7s_raddr       <= {regw_f7s_raddr,REG_f7s_raddr[31:00]};
       ADDR_F7_S_READ_L      : REG_f7s_raddr       <= {REG_f7s_raddr[63:32],regw_f7s_raddr};
       ADDR_F7_S_WRITE_H     : REG_f7s_waddr       <= {regw_f7s_waddr,REG_f7s_waddr[31:00]};
       ADDR_F7_S_WRITE_L     : REG_f7s_waddr       <= {REG_f7s_waddr[63:32],regw_f7s_waddr};
       ADDR_F7_E_READ_H      : REG_f7e_raddr       <= {regw_f7e_raddr,REG_f7e_raddr[31:00]};
       ADDR_F7_E_READ_L      : REG_f7e_raddr       <= {REG_f7e_raddr[63:32],regw_f7e_raddr};
       ADDR_F7_E_WRITE_H     : REG_f7e_waddr       <= {regw_f7e_waddr,REG_f7e_waddr[31:00]};
       ADDR_F7_E_WRITE_L     : REG_f7e_waddr       <= {REG_f7e_waddr[63:32],regw_f7e_waddr};
       ADDR_F8_S_READ_H      : REG_f8s_raddr       <= {regw_f8s_raddr,REG_f8s_raddr[31:00]};
       ADDR_F8_S_READ_L      : REG_f8s_raddr       <= {REG_f8s_raddr[63:32],regw_f8s_raddr};
       ADDR_F8_S_WRITE_H     : REG_f8s_waddr       <= {regw_f8s_waddr,REG_f8s_waddr[31:00]};
       ADDR_F8_S_WRITE_L     : REG_f8s_waddr       <= {REG_f8s_waddr[63:32],regw_f8s_waddr};
       ADDR_F8_E_READ_H      : REG_f8e_raddr       <= {regw_f8e_raddr,REG_f8e_raddr[31:00]};
       ADDR_F8_E_READ_L      : REG_f8e_raddr       <= {REG_f8e_raddr[63:32],regw_f8e_raddr};
       ADDR_F8_E_WRITE_H     : REG_f8e_waddr       <= {regw_f8e_waddr,REG_f8e_waddr[31:00]};
       ADDR_F8_E_WRITE_L     : REG_f8e_waddr       <= {REG_f8e_waddr[63:32],regw_f8e_waddr};
       ADDR_F9_S_READ_H      : REG_f9s_raddr       <= {regw_f9s_raddr,REG_f9s_raddr[31:00]};
       ADDR_F9_S_READ_L      : REG_f9s_raddr       <= {REG_f9s_raddr[63:32],regw_f9s_raddr};
       ADDR_F9_S_WRITE_H     : REG_f9s_waddr       <= {regw_f9s_waddr,REG_f9s_waddr[31:00]};
       ADDR_F9_S_WRITE_L     : REG_f9s_waddr       <= {REG_f9s_waddr[63:32],regw_f9s_waddr};
       ADDR_F9_E_READ_H      : REG_f9e_raddr       <= {regw_f9e_raddr,REG_f9e_raddr[31:00]};
       ADDR_F9_E_READ_L      : REG_f9e_raddr       <= {REG_f9e_raddr[63:32],regw_f9e_raddr};
       ADDR_F9_E_WRITE_H     : REG_f9e_waddr       <= {regw_f9e_waddr,REG_f9e_waddr[31:00]};
       ADDR_F9_E_WRITE_L     : REG_f9e_waddr       <= {REG_f9e_waddr[63:32],regw_f9e_waddr};
       ADDR_CONV10_READ_H    : REG_conv10_raddr    <= {regw_conv10_raddr,REG_conv10_raddr[31:00]};
       ADDR_CONV10_READ_L    : REG_conv10_raddr    <= {REG_conv10_raddr[63:32],regw_conv10_raddr};
       ADDR_CONV10_WRITE_H   : REG_conv10_waddr    <= {regw_conv10_waddr,REG_conv10_waddr[31:00]};
       ADDR_CONV10_WRITE_L   : REG_conv10_waddr    <= {REG_conv10_waddr[63:32],regw_conv10_waddr};
       ADDR_CONV10_WEIGHT_H  : REG_conv10_weight_raddr     <= {regw_conv10_weight_raddr,REG_conv10_weight_raddr[31:00]};
       ADDR_CONV10_WEIGHT_L  : REG_conv10_weight_raddr     <= {REG_conv10_weight_raddr[63:32],regw_conv10_weight_raddr};

       ADDR_SOFT_RESET       : REG_soft_reset      <= regw_soft_reset;
       default :;
     endcase
     else begin
         REG_user_control[0] <= 1'b0;
         REG_soft_reset[0]   <= 1'b0;
     end


/***********************************************************************
*                          Control Flow                                *
***********************************************************************/
// The build-in snap_action_start() and snap_action_completed functions 
// sets REG_snap_control bit "start" and reads bit "idle"
// The other things are managed by REG_user_control (user defined control register)
// Flow:
// ---------------------------------------------------------------------------------------------
// Software                                  Hardware REG                               Hardware signal & action
// ---------------------------------------------------------------------------------------------
// snap_action_start()                      |                                          |
//                                          | SNAP_CONTROL[snap_start]=1               |
// mmio_write(USER_CONTROL[conv1...])       |                                          | snap_start_pulse
// mmio_write(USER_CONTROL[pool1...])       |                                          |
// mmio_write(USER_CONTROL[...])            |                                          |
// mmio_write(USER_CONTROL[start])=1        |                                          |
//                                          | CONTROL[start]=1                         |
//                                          |                                          | start
//                                          |                                          | Run SqueezeNet
//                                          |                                          | .
//                                          |                                          | .
//                                          |                                          | .
//                                          |                                          | done
//                                          | USER_STATUS[done]= 1                     |
//                                          | SNAP_CONTROL[snap_idle]=1                |
// wait(USER_STATUS)                        |                                          |
// snap_action_completed()                  |                                          |
//

wire snap_start_pulse;

reg snap_start_q;
reg snap_idle_q;

reg rd_error_q;
reg wr_error_q;
reg done_q;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        snap_start_q <= 0;
    end
    else if(soft_reset) begin
        snap_start_q <= 0;
    end
    else begin
        snap_start_q <= REG_snap_control[0];
    end
end

assign snap_start_pulse = REG_snap_control[0] & ~snap_start_q;
assign start_pulse = REG_user_control[0];

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
       snap_idle_q <= 0;
    end
    else if(soft_reset) begin
       snap_idle_q <= 0;
    end
    else if(done_pulse) begin   //finish
       snap_idle_q <= 1;
    end
end

always@(posedge clk or negedge rst_n)
   if (~rst_n) begin
     rd_error_q      <= 0;
   end
   else if(soft_reset) begin
     rd_error_q      <= 0;
   end
   else if(rd_error) begin
     rd_error_q      <= rd_error;
   end

always@(posedge clk or negedge rst_n)
   if (~rst_n) begin
     wr_error_q      <= 0;
   end
   else if(soft_reset) begin
     wr_error_q      <= 0;
   end
   else if(wr_error) begin
     wr_error_q      <= 1;
   end

always@(posedge clk or negedge rst_n)
   if (~rst_n)
     done_q <= 0;
   else if(soft_reset)
     done_q <= 0;
   else if (done_pulse)
     done_q <= 1;

assign REG_user_status     = {29'd0, rd_error_q, wr_error_q, done_q};
assign REG_snap_control_rd = {REG_snap_control[31:4], 1'b1, snap_idle_q, 1'b0, snap_start_q};
//Address: 0x000
//  31..8  RO: Reserved
//      7  RW: auto restart
//   6..4  RO: Reserved
//      3  RO: Ready     (not used)
//      2  RO: Idle      (in use)
//      1  RC: Done      (not used)
//      0  RW: Start     (in use)
/***********************************************************************
*                       reading registers                              *
***********************************************************************/

//---- read registers ----
 always@(posedge clk or negedge rst_n)
   if(~rst_n)
     s_axi_rdata <= 32'd0;
   else if(s_axi_arvalid & s_axi_arready)
     case(s_axi_araddr)
       ADDR_SNAP_CONTROL        : s_axi_rdata <= REG_snap_control_rd;
       ADDR_SNAP_INT_ENABLE     : s_axi_rdata <= REG_snap_int_enable[31 : 0];
       ADDR_SNAP_ACTION_TYPE    : s_axi_rdata <= i_action_type;
       ADDR_SNAP_ACTION_VERSION : s_axi_rdata <= i_action_version;
       ADDR_SNAP_CONTEXT        : s_axi_rdata <= REG_snap_context[31 : 0];

       ADDR_USER_STATUS         : s_axi_rdata <= REG_user_status;
       ADDR_USER_CONTROL        : s_axi_rdata <= REG_user_control;
       
       ADDR_CONV1_READ_H        : s_axi_rdata <= REG_conv1_raddr[63 : 32];
       ADDR_CONV1_READ_L        : s_axi_rdata <= REG_conv1_raddr[31 : 0];
       ADDR_CONV1_WRITE_H       : s_axi_rdata <= REG_conv1_waddr[63 : 32];
       ADDR_CONV1_WRITE_L       : s_axi_rdata <= REG_conv1_waddr[31 : 0];
       ADDR_POOL1_READ_H        : s_axi_rdata <= REG_pool1_raddr[63 : 32];
       ADDR_POOL1_READ_L        : s_axi_rdata <= REG_pool1_raddr[31 : 0];
       ADDR_POOL1_WRITE_H       : s_axi_rdata <= REG_pool1_waddr[63 : 32];
       ADDR_POOL1_WRITE_L       : s_axi_rdata <= REG_pool1_waddr[31 : 0];
       ADDR_F2_S_READ_H         : s_axi_rdata <= REG_f2s_raddr[63 : 32];
       ADDR_F2_S_READ_L         : s_axi_rdata <= REG_f2s_raddr[31 : 0];
       ADDR_F2_S_WRITE_H        : s_axi_rdata <= REG_f2s_waddr[63 : 32];
       ADDR_F2_S_WRITE_L        : s_axi_rdata <= REG_f2s_waddr[31 : 0];
       ADDR_F2_E_READ_H         : s_axi_rdata <= REG_f2e_raddr[63 : 32];
       ADDR_F2_E_READ_L         : s_axi_rdata <= REG_f2e_raddr[31 : 0];
       ADDR_F2_E_WRITE_H        : s_axi_rdata <= REG_f2e_waddr[63 : 32];
       ADDR_F2_E_WRITE_L        : s_axi_rdata <= REG_f2e_waddr[31 : 0];
       ADDR_F3_S_READ_H         : s_axi_rdata <= REG_f3s_raddr[63 : 32];
       ADDR_F3_S_READ_L         : s_axi_rdata <= REG_f3s_raddr[31 : 0];
       ADDR_F3_S_WRITE_H        : s_axi_rdata <= REG_f3s_waddr[63 : 32];
       ADDR_F3_S_WRITE_L        : s_axi_rdata <= REG_f3s_waddr[31 : 0];
       ADDR_F3_E_READ_H         : s_axi_rdata <= REG_f3e_raddr[63 : 32];
       ADDR_F3_E_READ_L         : s_axi_rdata <= REG_f3e_raddr[31 : 0];
       ADDR_F3_E_WRITE_H        : s_axi_rdata <= REG_f3e_waddr[63 : 32];
       ADDR_F3_E_WRITE_L        : s_axi_rdata <= REG_f3e_waddr[31 : 0];
       ADDR_POOL3_READ_H        : s_axi_rdata <= REG_pool3_raddr[63 : 32];
       ADDR_POOL3_READ_L        : s_axi_rdata <= REG_pool3_raddr[31 : 0];
       ADDR_POOL3_WRITE_H       : s_axi_rdata <= REG_pool3_waddr[63 : 32];
       ADDR_POOL3_WRITE_L       : s_axi_rdata <= REG_pool3_waddr[31 : 0];
       ADDR_F4_S_READ_H         : s_axi_rdata <= REG_f4s_raddr[63 : 32];
       ADDR_F4_S_READ_L         : s_axi_rdata <= REG_f4s_raddr[31 : 0];
       ADDR_F4_S_WRITE_H        : s_axi_rdata <= REG_f4s_waddr[63 : 32];
       ADDR_F4_S_WRITE_L        : s_axi_rdata <= REG_f4s_waddr[31 : 0];
       ADDR_F4_E_READ_H         : s_axi_rdata <= REG_f4e_raddr[63 : 32];
       ADDR_F4_E_READ_L         : s_axi_rdata <= REG_f4e_raddr[31 : 0];
       ADDR_F4_E_WRITE_H        : s_axi_rdata <= REG_f4e_waddr[63 : 32];
       ADDR_F4_E_WRITE_L        : s_axi_rdata <= REG_f4e_waddr[31 : 0];
       ADDR_F5_S_READ_H         : s_axi_rdata <= REG_f5s_raddr[63 : 32];
       ADDR_F5_S_READ_L         : s_axi_rdata <= REG_f5s_raddr[31 : 0];
       ADDR_F5_S_WRITE_H        : s_axi_rdata <= REG_f5s_waddr[63 : 32];
       ADDR_F5_S_WRITE_L        : s_axi_rdata <= REG_f5s_waddr[31 : 0];
       ADDR_F5_E_READ_H         : s_axi_rdata <= REG_f5e_raddr[63 : 32];
       ADDR_F5_E_READ_L         : s_axi_rdata <= REG_f5e_raddr[31 : 0];
       ADDR_F5_E_WRITE_H        : s_axi_rdata <= REG_f5e_waddr[63 : 32];
       ADDR_F5_E_WRITE_L        : s_axi_rdata <= REG_f5e_waddr[31 : 0];
       ADDR_POOL5_READ_H        : s_axi_rdata <= REG_pool5_raddr[63 : 32];
       ADDR_POOL5_READ_L        : s_axi_rdata <= REG_pool5_raddr[31 : 0];
       ADDR_POOL5_WRITE_H       : s_axi_rdata <= REG_pool5_waddr[63 : 32];
       ADDR_POOL5_WRITE_L       : s_axi_rdata <= REG_pool5_waddr[31 : 0];
       ADDR_F6_S_READ_H         : s_axi_rdata <= REG_f6s_raddr[63 : 32];
       ADDR_F6_S_READ_L         : s_axi_rdata <= REG_f6s_raddr[31 : 0];
       ADDR_F6_S_WRITE_H        : s_axi_rdata <= REG_f6s_waddr[63 : 32];
       ADDR_F6_S_WRITE_L        : s_axi_rdata <= REG_f6s_waddr[31 : 0];
       ADDR_F6_E_READ_H         : s_axi_rdata <= REG_f6e_raddr[63 : 32];
       ADDR_F6_E_READ_L         : s_axi_rdata <= REG_f6e_raddr[31 : 0];
       ADDR_F6_E_WRITE_H        : s_axi_rdata <= REG_f6e_waddr[63 : 32];
       ADDR_F6_E_WRITE_L        : s_axi_rdata <= REG_f6e_waddr[31 : 0];
       ADDR_F7_S_READ_H         : s_axi_rdata <= REG_f7s_raddr[63 : 32];
       ADDR_F7_S_READ_L         : s_axi_rdata <= REG_f7s_raddr[31 : 0];
       ADDR_F7_S_WRITE_H        : s_axi_rdata <= REG_f7s_waddr[63 : 32];
       ADDR_F7_S_WRITE_L        : s_axi_rdata <= REG_f7s_waddr[31 : 0];
       ADDR_F7_E_READ_H         : s_axi_rdata <= REG_f7e_raddr[63 : 32];
       ADDR_F7_E_READ_L         : s_axi_rdata <= REG_f7e_raddr[31 : 0];
       ADDR_F7_E_WRITE_H        : s_axi_rdata <= REG_f7e_waddr[63 : 32];
       ADDR_F7_E_WRITE_L        : s_axi_rdata <= REG_f7e_waddr[31 : 0];
       ADDR_F8_S_READ_H         : s_axi_rdata <= REG_f8s_raddr[63 : 32];
       ADDR_F8_S_READ_L         : s_axi_rdata <= REG_f8s_raddr[31 : 0];
       ADDR_F8_S_WRITE_H        : s_axi_rdata <= REG_f8s_waddr[63 : 32];
       ADDR_F8_S_WRITE_L        : s_axi_rdata <= REG_f8s_waddr[31 : 0];
       ADDR_F8_E_READ_H         : s_axi_rdata <= REG_f8e_raddr[63 : 32];
       ADDR_F8_E_READ_L         : s_axi_rdata <= REG_f8e_raddr[31 : 0];
       ADDR_F8_E_WRITE_H        : s_axi_rdata <= REG_f8e_waddr[63 : 32];
       ADDR_F8_E_WRITE_L        : s_axi_rdata <= REG_f8e_waddr[31 : 0];
       ADDR_F9_S_READ_H         : s_axi_rdata <= REG_f9s_raddr[63 : 32];
       ADDR_F9_S_READ_L         : s_axi_rdata <= REG_f9s_raddr[31 : 0];
       ADDR_F9_S_WRITE_H        : s_axi_rdata <= REG_f9s_waddr[63 : 32];
       ADDR_F9_S_WRITE_L        : s_axi_rdata <= REG_f9s_waddr[31 : 0];
       ADDR_F9_E_READ_H         : s_axi_rdata <= REG_f9e_raddr[63 : 32];
       ADDR_F9_E_READ_L         : s_axi_rdata <= REG_f9e_raddr[31 : 0];
       ADDR_F9_E_WRITE_H        : s_axi_rdata <= REG_f9e_waddr[63 : 32];
       ADDR_F9_E_WRITE_L        : s_axi_rdata <= REG_f9e_waddr[31 : 0];
       ADDR_CONV10_READ_H       : s_axi_rdata <= REG_conv10_raddr[63 : 32];
       ADDR_CONV10_READ_L       : s_axi_rdata <= REG_conv10_raddr[31 : 0];
       ADDR_CONV10_WRITE_H      : s_axi_rdata <= REG_conv10_waddr[63 : 32];
       ADDR_CONV10_WRITE_L      : s_axi_rdata <= REG_conv10_waddr[31 : 0];
       ADDR_CONV10_WEIGHT_H     : s_axi_rdata <= REG_conv10_weight_raddr[63 : 32];
       ADDR_CONV10_WEIGHT_L     : s_axi_rdata <= REG_conv10_weight_raddr[31 : 0];

       ADDR_SOFT_RESET          : s_axi_rdata <= REG_soft_reset;
       default                  : s_axi_rdata <= 32'h5a5aa5a5;
     endcase

//---- address ready: deasserts once arvalid is seen; reasserts when current read is done ----
 always@(posedge clk or negedge rst_n)
   if(~rst_n)
     s_axi_arready <= 1'b1;
   else if(s_axi_arvalid)
     s_axi_arready <= 1'b0;
   else if(s_axi_rvalid & s_axi_rready)
     s_axi_arready <= 1'b1;

//---- data ready: deasserts once rvalid is seen; reasserts when new address has come ----
 always@(posedge clk or negedge rst_n)
   if(~rst_n)
     s_axi_rvalid <= 1'b0;
   else if (s_axi_arvalid & s_axi_arready)
     s_axi_rvalid <= 1'b1;
   else if (s_axi_rready)
     s_axi_rvalid <= 1'b0;

/***********************************************************************
*                        status reporting                              *
***********************************************************************/

//---- axi write response ----
 always@(posedge clk or negedge rst_n)
   if(~rst_n) 
     s_axi_bvalid <= 1'b0;
   else if(s_axi_wvalid & s_axi_wready)
     s_axi_bvalid <= 1'b1;
   else if(s_axi_bready)
     s_axi_bvalid <= 1'b0;

 assign s_axi_bresp = 2'd0;

//---- axi read response ----
 assign s_axi_rresp = 2'd0;

endmodule
