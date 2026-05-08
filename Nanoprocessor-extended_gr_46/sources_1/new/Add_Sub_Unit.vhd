

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Add_Sub_Unit is
    Port ( A : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           Add_Sub_Sel : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (11 downto 0);
           Carry : out STD_LOGIC;
           Zero : out STD_LOGIC);
end Add_Sub_Unit;

architecture Behavioral of Add_Sub_Unit is

component c_addsub_0
  PORT (
    A : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    ADD : IN STD_LOGIC;
    C_OUT : OUT STD_LOGIC;
    S : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
end component;

signal B_new, Sum : std_logic_vector(11 downto 0);
signal Cout: std_logic;

begin

c_addsub: c_addsub_0
    Port map ( 
           A => A,
           B => B,
           ADD => Add_Sub_Sel,
           S => Sum,
           C_OUT => Cout);

S <= Sum;
Carry <= Cout;

process(Sum)
begin
    if Sum="000000000000" and Cout='0'  then
        Zero <= '1';
    else 
        Zero <= '0';
    end if;   
end process;

end Behavioral;