library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_Bank is
    Port (
        Clk    : in  STD_LOGIC;
        RegEN  : in  STD_LOGIC_VECTOR (2 downto 0);
        Data   : in  STD_LOGIC_VECTOR (11 downto 0);
        Reset  : in  STD_LOGIC;
        Reg0   : out STD_LOGIC_VECTOR (11 downto 0);
        Reg1   : out STD_LOGIC_VECTOR (11 downto 0);
        Reg2   : out STD_LOGIC_VECTOR (11 downto 0);
        Reg3   : out STD_LOGIC_VECTOR (11 downto 0);
        Reg4   : out STD_LOGIC_VECTOR (11 downto 0);
        Reg5   : out STD_LOGIC_VECTOR (11 downto 0);
        Reg6   : out STD_LOGIC_VECTOR (11 downto 0);
        Reg7   : out STD_LOGIC_VECTOR (11 downto 0)
    );
end Register_Bank;

architecture Behavioral of Register_Bank is
    type Reg_Array is array(1 to 7) of STD_LOGIC_VECTOR(11 downto 0);
    signal Regs : Reg_Array := (others => (others => '0'));
begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Reset = '1' then
                Regs <= (others => (others => '0'));
            else
                if RegEN /= "000" then  -- Reg0 is not writable
                    Regs(to_integer(unsigned(RegEN))) <= Data;
                end if;
            end if;
        end if;
    end process;

    -- Outputs
    Reg0 <= (others => '0');      -- Hardwired zero
    Reg1 <= Regs(1);
    Reg2 <= Regs(2);
    Reg3 <= Regs(3);
    Reg4 <= Regs(4);
    Reg5 <= Regs(5);
    Reg6 <= Regs(6);
    Reg7 <= Regs(7);
end Behavioral;

