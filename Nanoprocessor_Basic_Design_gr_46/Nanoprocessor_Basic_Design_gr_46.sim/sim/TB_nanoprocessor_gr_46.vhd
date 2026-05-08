----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2026 01:14:48
-- Design Name: 
-- Module Name: TB_nanoprocessor_gr_46 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_nanoprocessor_gr_46 is
--  Port ( );
end TB_nanoprocessor_gr_46;

architecture Behavioral of TB_nanoprocessor_gr_46 is

    component Nanoprocessor
        Port (
            Clk        : in STD_LOGIC;
            Reset      : in STD_LOGIC;
            Overflow   : out STD_LOGIC;
            Zero       : out STD_LOGIC;
            Reg_7_Out  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

signal Clk        : STD_LOGIC := '0';
signal Reset      : STD_LOGIC := '1';
signal Overflow   : STD_LOGIC;
signal Zero       : STD_LOGIC;
signal Reg_7_Out  : STD_LOGIC_VECTOR(3 downto 0);

begin
    uut: Nanoprocessor
        port map (
            Clk       => Clk,
            Reset     => Reset,
            Overflow  => Overflow,
            Zero      => Zero,
            Reg_7_Out => Reg_7_Out
        );

Clk_Process : process
begin
    while now < 500 ns loop
        Clk <= '0';
        wait for 10 ns;
        Clk <= '1';
        wait for 10 ns;
    end loop;
    wait;
end process;

process
    begin
        -- Initial Reset
        Reset <= '1';
        wait for 40 ns;
        Reset <= '0';
   
        wait for 400 ns;
        wait;
end process;

end Behavioral;

