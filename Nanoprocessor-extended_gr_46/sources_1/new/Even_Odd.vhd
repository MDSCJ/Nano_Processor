


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Even_Odd is
    Port (
        Data_In         : in  STD_LOGIC_VECTOR(11 downto 0);
        Is_Even         : out STD_LOGIC_VECTOR(11 downto 0)
    );
end Even_Odd;

architecture Behavioral of Even_Odd is
begin
    process(Data_In)
    begin
        if Data_In(0) = '0' then
            Is_Even <= "000000000001";  -- Even number
        else
            Is_Even <= "000000000000";  -- Odd number
        end if;
    end process;
end Behavioral;