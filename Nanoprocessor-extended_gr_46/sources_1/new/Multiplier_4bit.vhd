


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier_6bit is
    Port (
        A        : in  STD_LOGIC_VECTOR(11 downto 0);
        B        : in  STD_LOGIC_VECTOR(11 downto 0);
        Product  : out STD_LOGIC_VECTOR(11 downto 0)
    );
    
    attribute use_dsp : string;
    attribute use_dsp of Multiplier_6bit : entity is "yes";
end Multiplier_6bit;

architecture Behavioral of Multiplier_6bit is
begin

    process (A, B)
        variable A_6bit : unsigned(5 downto 0);
        variable B_6bit : unsigned(5 downto 0);
        variable Result : unsigned(11 downto 0);
    begin
        A_6bit := unsigned(A(5 downto 0));  -- extract 2-bit value
        B_6bit := unsigned(B(5 downto 0));  -- extract 2-bit value
        Result := A_6bit * B_6bit;
        Product <= std_logic_vector(Result);  -- assign to output
    end process;

end Behavioral;
