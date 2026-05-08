----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2026 12:22:42
-- Design Name: 
-- Module Name: TB_Add_Sub_unit_gr_46 - Behavioral
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

entity TB_Add_Sub_unit_gr_46 is
--  Port ( );
end TB_Add_Sub_unit_gr_46;

architecture Behavioral of TB_Add_Sub_unit_gr_46 is

component Add_Sub_unit_gr_46
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       Add_Sub_Sel : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       Carry : out STD_LOGIC;
       Zero : out STD_LOGIC);
end component;

signal a,b,s : std_logic_vector (3 downto 0);
signal sub, c, z : std_logic;

begin
    UUT: Add_Sub_unit_gr_46 port map(
    A => a,
    B => b,
    Add_Sub_Sel => sub,
    S => s,
    Carry => c,
    Zero => z
    );

    process begin

-- 240272 => A="1001", B="0000"
-- 240278 => A="1001", B="0110"
-- 240255 => A="0111", B="1111"
-- 240238 => A="0110", B="1110"

-- Test Case 1: 240272 (A + B) --
    a <= "1001";
    b <= "0000";
    sub <= '0';
    wait for 100 ns;

-- Test Case 2: 240272 (A - B) --
    a <= "1001";
    b <= "0000";
    sub <= '1';
    wait for 100 ns;

-- Test Case 3: 240278 (A + B) --
    a <= "1001";
    b <= "0110";
    sub <= '0';
    wait for 100 ns;

-- Test Case 4: 240278 (A - B) --
    a <= "1001";
    b <= "0110";
    sub <= '1';
    wait for 100 ns;

-- Test Case 5: 240255 (A + B) --
    a <= "0111";
    b <= "1111";
    sub <= '0';
    wait for 100 ns;

-- Test Case 6: 240255 (A - B) --
    a <= "0111";
    b <= "1111";
    sub <= '1';
    wait for 100 ns;

-- Test Case 7: 240238 (A + B) --
    a <= "0110";
    b <= "1110";
    sub <= '0';
    wait for 100 ns;

-- Test Case 8: 240238 (A - B) --
    a <= "0110";
    b <= "1110";
    sub <= '1';
    wait; 
    
    end process;

end Behavioral;