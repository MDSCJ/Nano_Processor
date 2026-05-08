library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Add_Sub_Unit is
--  Port ( );
end TB_Add_Sub_Unit;

architecture Behavioral of TB_Add_Sub_Unit is

component Add_Sub_Unit
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
    UUT: Add_Sub_Unit port map(
    A => a,
    B => b,
    Add_Sub_Sel => sub,
    S => s,
    Carry => c,
    Zero => z
    );

process begin

-- 3 + 2 = 5 --
a <= "0011";
b <= "0010";
sub <= '0';
wait for 100 ns;

-- 5 + 4 = 9 (Testing carry/overflow potential) --
a <= "0101";
b <= "0100";
sub <= '0';
wait for 100 ns;

-- 6 - 2 = 4 --
a <= "0110";
b <= "0010";
sub <= '1';
wait for 100 ns;

-- 3 - 3 = 0 (Testing Zero flag) --
a <= "0011";
b <= "0011";
sub <= '1';
wait for 100 ns;

-- 2 - 5 = -3 (Resulting in negative/2's complement) --
a <= "0010";
b <= "0101";
sub <= '1';
wait for 100 ns;

-- (-2) + 3 = 1 --
a <= "1110";
b <= "0011";
sub <= '0';
wait for 100 ns;

-- (-4) - 3 = -7 --
a <= "1100";
b <= "0011";
sub <= '1';
wait ;

end process;

end Behavioral;