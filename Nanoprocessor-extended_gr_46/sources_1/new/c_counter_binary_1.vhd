library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Required for unsigned arithmetic

entity c_counter_binary_1 is
  Port ( 
    CLK : in STD_LOGIC;
    CE  : in STD_LOGIC;
    Q   : out STD_LOGIC_VECTOR ( 25 downto 0 )
  );
end c_counter_binary_1;

architecture Behavioral of c_counter_binary_1 is
    -- Internal signal to hold the 26-bit count value
    signal count_reg : unsigned(25 downto 0) := (others => '0');
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if CE = '1' then
                -- Increment the counter only when Clock Enable is high
                count_reg <= count_reg + 1;
            end if;
        end if;
    end process;

    -- Assign the internal count to the output port
    Q <= std_logic_vector(count_reg);

end Behavioral;