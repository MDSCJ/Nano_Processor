----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 09:10:33
-- Design Name: 
-- Module Name: TB_Mux_2_Way_3_bit_gr_46 - Behavioral
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

entity TB_Mux_2_Way_3_bit_gr_46 is
--  Port ( );
end TB_Mux_2_Way_3_bit_gr_46;

architecture Behavioral of TB_Mux_2_Way_3_bit_gr_46 is

component Mux_2_way_3_bit_gr_46
        Port (
            I0 : in STD_LOGIC_VECTOR(2 downto 0);
            I1 : in STD_LOGIC_VECTOR(2 downto 0);
            Sel : in STD_LOGIC;
            RegOut : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;
signal I0_tb : STD_LOGIC_VECTOR(2 downto 0) ;
signal I1_tb : STD_LOGIC_VECTOR(2 downto 0) ;
signal Sel_tb : STD_LOGIC := '0';
signal RegOut_tb : STD_LOGIC_VECTOR(2 downto 0);

begin
uut: Mux_2_way_3_bit_gr_46
        port map (
            I0 => I0_tb,
            I1 => I1_tb,
            Sel => Sel_tb,
            RegOut => RegOut_tb
        );
process
    begin
    -- 240272 = 11 1010 1010 1001 010 000
    -- 240278 = 11 1010 1010 1001 010 110
    -- 240255 = 11 1010 1010 011 111 111
    -- 240238 = 11 1010 1010 011 101 110
 
    -- 240272
    I0_tb <= "000";
    I1_tb <= "010";
    Sel_tb <= '0';
    wait for 100 ns;
    Sel_tb <= '1';
    wait for 100 ns;
    
    -- 240278
    I0_tb <= "110";
    I1_tb <= "010";
    Sel_tb <= '0';
    wait for 100 ns;
    Sel_tb <= '1';
    wait for 100 ns;    
    
    -- 240255
    I0_tb <= "111";
    I1_tb <= "111";
    Sel_tb <= '0';
    wait for 100 ns;
    Sel_tb <= '1';
    wait for 100 ns;

    -- 240238
    I0_tb <= "110";
    I1_tb <= "101";
    Sel_tb <= '0';
    wait for 100 ns;
    Sel_tb <= '1';
    wait for 100 ns;
    
    
    Sel_tb <= '0';
    wait; 
       
    end process;

end Behavioral;