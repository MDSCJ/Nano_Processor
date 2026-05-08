library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Required for unsigned arithmetic

entity c_addsub_0 is
  Port ( 
    A     : in STD_LOGIC_VECTOR ( 11 downto 0 );
    B     : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ADD   : in STD_LOGIC;
    C_OUT : out STD_LOGIC;
    S     : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
end c_addsub_0;

architecture Behavioral of c_addsub_0 is
    -- Extend to 13 bits to capture the carry-out/borrow-out
    signal temp_A : unsigned(12 downto 0);
    signal temp_B : unsigned(12 downto 0);
    signal temp_S : unsigned(12 downto 0);
begin
    -- Pad the most significant bit with '0'
    temp_A <= unsigned('0' & A);
    temp_B <= unsigned('0' & B);

    -- Perform addition if ADD = '1', else perform subtraction
    temp_S <= temp_A + temp_B when ADD = '1' else temp_A - temp_B;

    -- Assign the lower 12 bits to the Sum output
    S <= std_logic_vector(temp_S(11 downto 0));
    
    -- Assign the 13th bit to the Carry output
    C_OUT <= std_logic(temp_S(12));

end Behavioral;