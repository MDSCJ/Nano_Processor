----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 02:31:11 PM
-- Design Name: 
-- Module Name: Program_Counter_gr_46 - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_Counter is
    Port (
        D    : in  STD_LOGIC_VECTOR(2 downto 0);  -- Jump address
        Res  : in  STD_LOGIC;
        Clk  : in  STD_LOGIC;
        Sel  : in  STD_LOGIC;                     -- 0: increment, 1: jump
        Q    : out STD_LOGIC_VECTOR(2 downto 0)
    );
end Program_Counter;

architecture Behavioral of Program_Counter is

component c_counter_binary_0
  PORT (
  CLK : IN STD_LOGIC;
  CE : IN STD_LOGIC;
  SCLR : IN STD_LOGIC;
  LOAD : IN STD_LOGIC;
  L : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
  Q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
);
end component;

begin

    PC_Inst : c_counter_binary_0
        port map (
            CLK  => Clk,
            CE   => '1',      -- Always enabled
            SCLR => Res,      -- Active-high reset
            LOAD => Sel,      -- Jump if Sel = '1'
            L    => D,        -- Jump address input
            Q    => Q         -- Current PC value
        );

end Behavioral;
