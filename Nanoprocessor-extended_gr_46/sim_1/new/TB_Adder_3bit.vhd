library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Adder_3bit is
--  Port ( );
end TB_Adder_3bit;

architecture Behavioral of TB_Adder_3bit is

component Adder_3bit 
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0);
           C_out : out STD_LOGIC);
end component;

signal a,s : std_logic_vector (2 downto 0);
signal c : std_logic;

begin
UUT :Adder_3bit port map(
        A => a,
        S => s,
        C_out => c
    );
    
process begin
   -- Test case 1: Start at zero (Expected S = "001")
   a <= "000";
   wait for 100 ns;

   -- Test case 2: Increment from 3 (Expected S = "100")
   a <= "011";
   wait for 100 ns;
   
   -- Test case 3: Increment from 5 (Expected S = "110")
   a <= "101";
   wait for 100 ns;
   
   -- Test case 4: Increment from 6 (Expected S = "111")
   a <= "110";
   wait for 100 ns;
   
   -- Test case 5: Maximum value (Expected S = "000", C_out = '1')
   a <= "111";
   wait for 100 ns;
   
   -- Test case 6: Increment from 2 (Expected S = "011")
   a <= "010";
   wait for 100 ns;
   
   -- Test case 7: Increment from 4 (Expected S = "101")
   a <= "100";
   wait;
   
end process;

end Behavioral;