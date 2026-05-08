library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Required for unsigned arithmetic

entity c_counter_binary_0 is
  Port ( 
    CLK  : in STD_LOGIC;
    CE   : in STD_LOGIC;
    SCLR : in STD_LOGIC;
    LOAD : in STD_LOGIC;
    L    : in STD_LOGIC_VECTOR ( 2 downto 0 );
    Q    : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );
end c_counter_binary_0;

architecture Behavioral of c_counter_binary_0 is
    -- Internal signal to hold the current count value
    signal count_reg : unsigned(2 downto 0) := "000";
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if SCLR = '1' then
                -- Synchronous clear resets the counter to 0
                count_reg <= "000";
            elsif LOAD = '1' then
                -- Load the new address/value from L
                count_reg <= unsigned(L);
            elsif CE = '1' then
                -- If enabled and not clearing/loading, increment the counter
                count_reg <= count_reg + 1;
            end if;
            -- If none of the above are '1', the counter holds its current value
        end if;
    end process;

    -- Assign the internal count to the output port
    Q <= std_logic_vector(count_reg);

end Behavioral;