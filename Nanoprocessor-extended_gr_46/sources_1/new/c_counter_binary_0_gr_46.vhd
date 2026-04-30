----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 02:46:37 PM
-- Design Name: 
-- Module Name: c_counter_binary_0_gr_46 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



LIBRARY c_counter_binary_v12_0_12;
USE c_counter_binary_v12_0_12.c_counter_binary_v12_0_12;

ENTITY c_counter_binary_0 IS
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    LOAD : IN STD_LOGIC;
    L : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    Q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
END c_counter_binary_0;

ARCHITECTURE c_counter_binary_0_arch OF c_counter_binary_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF c_counter_binary_0_arch: ARCHITECTURE IS "yes";
  COMPONENT c_counter_binary_v12_0_12 IS
    GENERIC (
      C_IMPLEMENTATION : INTEGER;
      C_VERBOSITY : INTEGER;
      C_XDEVICEFAMILY : STRING;
      C_WIDTH : INTEGER;
      C_HAS_CE : INTEGER;
      C_HAS_SCLR : INTEGER;
      C_RESTRICT_COUNT : INTEGER;
      C_COUNT_TO : STRING;
      C_COUNT_BY : STRING;
      C_COUNT_MODE : INTEGER;
      C_THRESH0_VALUE : STRING;
      C_CE_OVERRIDES_SYNC : INTEGER;
      C_HAS_THRESH0 : INTEGER;
      C_HAS_LOAD : INTEGER;
      C_LOAD_LOW : INTEGER;
      C_LATENCY : INTEGER;
      C_FB_LATENCY : INTEGER;
      C_AINIT_VAL : STRING;
      C_SINIT_VAL : STRING;
      C_SCLR_OVERRIDES_SSET : INTEGER;
      C_HAS_SSET : INTEGER;
      C_HAS_SINIT : INTEGER
    );
    PORT (
      CLK : IN STD_LOGIC;
      CE : IN STD_LOGIC;
      SCLR : IN STD_LOGIC;
      SSET : IN STD_LOGIC;
      SINIT : IN STD_LOGIC;
      UP : IN STD_LOGIC;
      LOAD : IN STD_LOGIC;
      L : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      THRESH0 : OUT STD_LOGIC;
      Q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
  END COMPONENT c_counter_binary_v12_0_12;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF c_counter_binary_0_arch: ARCHITECTURE IS "c_counter_binary_v12_0_12,Vivado 2018.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF c_counter_binary_0_arch : ARCHITECTURE IS "c_counter_binary_0,c_counter_binary_v12_0_12,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF c_counter_binary_0_arch: ARCHITECTURE IS "c_counter_binary_0,c_counter_binary_v12_0_12,{x_ipProduct=Vivado 2018.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=c_counter_binary,x_ipVersion=12.0,x_ipCoreRevision=12,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_IMPLEMENTATION=1,C_VERBOSITY=0,C_XDEVICEFAMILY=artix7,C_WIDTH=3,C_HAS_CE=1,C_HAS_SCLR=1,C_RESTRICT_COUNT=0,C_COUNT_TO=1,C_COUNT_BY=1,C_COUNT_MODE=0,C_THRESH0_VALUE=1,C_CE_OVERRIDES_SYNC=0,C_HAS_THRESH0=0,C_HAS_LOAD=1,C_LOAD_LOW=0,C_LATENCY=1,C_FB_LATENCY=0,C_AINIT_VAL=0,C_SINIT_VAL=" & 
"0,C_SCLR_OVERRIDES_SSET=1,C_HAS_SSET=0,C_HAS_SINIT=0}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF Q: SIGNAL IS "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF Q: SIGNAL IS "xilinx.com:signal:data:1.0 q_intf DATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF L: SIGNAL IS "XIL_INTERFACENAME l_intf, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF L: SIGNAL IS "xilinx.com:signal:data:1.0 l_intf DATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF LOAD: SIGNAL IS "XIL_INTERFACENAME load_intf, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF LOAD: SIGNAL IS "xilinx.com:signal:data:1.0 load_intf DATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF SCLR: SIGNAL IS "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH";
  ATTRIBUTE X_INTERFACE_INFO OF SCLR: SIGNAL IS "xilinx.com:signal:reset:1.0 sclr_intf RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF CE: SIGNAL IS "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_LOW";
  ATTRIBUTE X_INTERFACE_INFO OF CE: SIGNAL IS "xilinx.com:signal:clockenable:1.0 ce_intf CE";
  ATTRIBUTE X_INTERFACE_PARAMETER OF CLK: SIGNAL IS "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 10000000, PHASE 0.000";
  ATTRIBUTE X_INTERFACE_INFO OF CLK: SIGNAL IS "xilinx.com:signal:clock:1.0 clk_intf CLK";
BEGIN
  U0 : c_counter_binary_v12_0_12
    GENERIC MAP (
      C_IMPLEMENTATION => 1,
      C_VERBOSITY => 0,
      C_XDEVICEFAMILY => "artix7",
      C_WIDTH => 3,
      C_HAS_CE => 1,
      C_HAS_SCLR => 1,
      C_RESTRICT_COUNT => 0,
      C_COUNT_TO => "1",
      C_COUNT_BY => "1",
      C_COUNT_MODE => 0,
      C_THRESH0_VALUE => "1",
      C_CE_OVERRIDES_SYNC => 0,
      C_HAS_THRESH0 => 0,
      C_HAS_LOAD => 1,
      C_LOAD_LOW => 0,
      C_LATENCY => 1,
      C_FB_LATENCY => 0,
      C_AINIT_VAL => "0",
      C_SINIT_VAL => "0",
      C_SCLR_OVERRIDES_SSET => 1,
      C_HAS_SSET => 0,
      C_HAS_SINIT => 0
    )
    PORT MAP (
      CLK => CLK,
      CE => CE,
      SCLR => SCLR,
      SSET => '0',
      SINIT => '0',
      UP => '1',
      LOAD => LOAD,
      L => L,
      Q => Q
    );
END c_counter_binary_0_arch;
