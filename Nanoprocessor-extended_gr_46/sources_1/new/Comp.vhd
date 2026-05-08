

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comp is
    Port (
        H_or_L   : in  STD_LOGIC;
        A        : in  STD_LOGIC_VECTOR(11 downto 0);
        B        : in  STD_LOGIC_VECTOR(11 downto 0);
        Max_Out  : out STD_LOGIC_VECTOR(11 downto 0)
    );
end Comp;

architecture Behavioral of Comp is
begin
    process (A, B, H_or_L)
    begin
        if H_or_L = '1' then
            -- Output the higher value
            if unsigned(A) >= unsigned(B) then
                Max_Out <= A;
            else
                Max_Out <= B;
            end if;
        else
            -- Output the lower value
            if unsigned(A) <= unsigned(B) then
                Max_Out <= A;
            else
                Max_Out <= B;
            end if;
        end if;
    end process;
end Behavioral;
