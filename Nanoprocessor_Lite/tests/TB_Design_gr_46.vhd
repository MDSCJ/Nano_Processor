----------------------------------------------------------------------------------
-- Create Date: 05/01/2026 03:15:20 PM
-- Module Name: TB_Design_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Design_gr_46 is
end TB_Design_gr_46;

architecture Behavioral of TB_Design_gr_46 is
    component Design_gr_46 is
        port(
            ClkIn : in std_logic; ResetIn : in std_logic;
            Overflow: out std_logic; Zero: out std_logic;
            Display: out std_logic_vector(3 downto 0);
            seg: out std_logic_vector(6 downto 0);
            led: out std_logic_vector(7 downto 0);
            ram_addr_led: out std_logic_vector(3 downto 0);
            ram_data_led: out std_logic_vector(7 downto 0));
    end component;
    signal ClkIn : std_logic := '0';
    signal ResetIn : std_logic := '0';
    signal Overflow, Zero: std_logic;
    signal Display: std_logic_vector(3 downto 0);
    signal seg: std_logic_vector(6 downto 0);
    signal led: std_logic_vector(7 downto 0);
    signal ram_addr_led: std_logic_vector(3 downto 0);
    signal ram_data_led: std_logic_vector(7 downto 0);
begin
    uut: Design_gr_46 port map(ClkIn=>ClkIn, ResetIn=>ResetIn, Overflow=>Overflow,
        Zero=>Zero, Display=>Display, seg=>seg, led=>led,
        ram_addr_led=>ram_addr_led, ram_data_led=>ram_data_led);
    Clk_process: process begin
        ClkIn <= '0'; wait for 5 ns; ClkIn <= '1'; wait for 5 ns;
    end process;
    stim_proc: process begin
        ResetIn <= '1'; wait for 100 ns; ResetIn <= '0'; wait;
    end process;
end Behavioral;
