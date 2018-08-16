-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:click_components:sel_a_not_b_fork:1.0
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY GCD_block_design_sel_a_not_b_fork_0_0 IS
  PORT (
    reset : IN STD_LOGIC;
    a_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    a_req_in : IN STD_LOGIC;
    a_ack_out : OUT STD_LOGIC;
    selector : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    sel_req_b_out : OUT STD_LOGIC;
    sel_ack_b_in : IN STD_LOGIC;
    sel_req_c_out : OUT STD_LOGIC;
    sel_ack_c_in : IN STD_LOGIC
  );
END GCD_block_design_sel_a_not_b_fork_0_0;

ARCHITECTURE GCD_block_design_sel_a_not_b_fork_0_0_arch OF GCD_block_design_sel_a_not_b_fork_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF GCD_block_design_sel_a_not_b_fork_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT sel_a_not_b_fork IS
    GENERIC (
      DATA_WIDTH : INTEGER;
      PHASE_INIT : STD_LOGIC
    );
    PORT (
      reset : IN STD_LOGIC;
      a_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      a_req_in : IN STD_LOGIC;
      a_ack_out : OUT STD_LOGIC;
      selector : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      sel_req_b_out : OUT STD_LOGIC;
      sel_ack_b_in : IN STD_LOGIC;
      sel_req_c_out : OUT STD_LOGIC;
      sel_ack_c_in : IN STD_LOGIC
    );
  END COMPONENT sel_a_not_b_fork;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF sel_ack_c_in: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_sel_c_out ack";
  ATTRIBUTE X_INTERFACE_INFO OF sel_req_c_out: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_sel_c_out req";
  ATTRIBUTE X_INTERFACE_INFO OF sel_ack_b_in: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_sel_b_out ack";
  ATTRIBUTE X_INTERFACE_INFO OF sel_req_b_out: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_sel_b_out req";
  ATTRIBUTE X_INTERFACE_INFO OF a_ack_out: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_a_in ack";
  ATTRIBUTE X_INTERFACE_INFO OF a_req_in: SIGNAL IS "xilinx.com:click_components:async_2ph_ch:1.0 ctrl_a_in req";
BEGIN
  U0 : sel_a_not_b_fork
    GENERIC MAP (
      DATA_WIDTH => 32,
      PHASE_INIT => '0'
    )
    PORT MAP (
      reset => reset,
      a_data_in => a_data_in,
      a_req_in => a_req_in,
      a_ack_out => a_ack_out,
      selector => selector,
      sel_req_b_out => sel_req_b_out,
      sel_ack_b_in => sel_ack_b_in,
      sel_req_c_out => sel_req_c_out,
      sel_ack_c_in => sel_ack_c_in
    );
END GCD_block_design_sel_a_not_b_fork_0_0_arch;