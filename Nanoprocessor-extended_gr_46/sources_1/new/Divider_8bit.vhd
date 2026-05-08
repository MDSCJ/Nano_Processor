

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Divider_12bit is
    Port (
        D_or_R : in std_logic;
        Dividend  : in  STD_LOGIC_VECTOR(11 downto 0);
        Divisor   : in  STD_LOGIC_VECTOR(11 downto 0);
        Quotient_Remainder  : out STD_LOGIC_VECTOR(11 downto 0)
    );

    attribute use_dsp : string;
    attribute use_dsp of Divider_12bit : entity is "yes";
end Divider_12bit;

architecture Behavioral of Divider_12bit is
begin
    process (Dividend, Divisor)
        variable A : unsigned(11 downto 0);
        variable B : unsigned(11 downto 0);
        variable Q : unsigned(11 downto 0);
        variable R : unsigned(11 downto 0);
    begin
        A := unsigned(Dividend);
        B := unsigned(Divisor);

        if B /= 0 then
            Q := A / B;
            R := A mod B;
        else
            Q := (others => '0');
            R := (others => '0');
        end if;
     
        if D_or_R = '1' then
            Quotient_Remainder <= std_logic_vector(R);
        else
            Quotient_Remainder <= std_logic_vector(Q);
        end if;
    end process;
end Behavioral;

