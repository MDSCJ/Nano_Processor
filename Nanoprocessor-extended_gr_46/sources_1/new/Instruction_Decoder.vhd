
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Decoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (20 downto 0);
           Reg_Check_Jump : in STD_LOGIC_VECTOR (11 downto 0);
           Add_Sub_Sel : out STD_LOGIC;
           RegA: out STD_LOGIC_VECTOR (2 downto 0);
           RegB : out STD_LOGIC_VECTOR (2 downto 0);
           Immediate_Value : out STD_LOGIC_VECTOR (11 downto 0);
           Load_Sel : out STD_LOGIC_VECTOR (2 downto 0);
           Reg_EN : out STD_LOGIC_VECTOR (2 downto 0);
           Jump_Flag : out STD_LOGIC;
           Jump_Address : out STD_LOGIC_VECTOR (2 downto 0));
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
    signal Operator : std_logic_vector(2 downto 0);
begin

    Operator <= Instruction(20 downto 18);  -- OPCODE bits

    process (Operator, Instruction, Reg_Check_Jump)
    begin
        -- Default values
        Add_Sub_Sel      <= '1';
        Jump_Flag        <= '0';
        Load_Sel         <= "000";
        RegA             <= "000"; 
        RegB             <= "000";
        Immediate_Value  <= (others => '0');
        Reg_EN           <= "000";
        Jump_Address     <= "000";

        case Operator is

            when "000" =>  -- ADD
                RegA   <= Instruction(17 downto 15);
                RegB   <= Instruction(14 downto 12);
                Reg_EN <= Instruction(17 downto 15);

            when "001" =>  -- NEG
                RegB         <= Instruction(17 downto 15);
                Reg_EN       <= Instruction(17 downto 15);
                Add_Sub_Sel  <= '0';

            when "010" =>  -- MOVI
                Reg_EN          <= Instruction(17 downto 15);
                Immediate_Value <= Instruction(11 downto 0);
                Load_Sel        <= "001";

            when "011" =>  -- JZR
                RegA         <= Instruction(17 downto 15);
                Jump_Address <= Instruction(2 downto 0);
                if Reg_Check_Jump = Instruction(14 downto 3) then
                    Jump_Flag <= '1';
                end if;

            when "100" =>  -- COMP
                RegA   <= Instruction(17 downto 15);
                RegB   <= Instruction(14 downto 12);
                Reg_EN <= Instruction(17 downto 15);
                Load_Sel <= "010";

            when "101" =>  -- EVEN/ODD
                RegA   <= Instruction(17 downto 15);
                Reg_EN <= Instruction(17 downto 15);
                Load_Sel <= "011";

            when "110" =>  -- MUL
                RegA   <= Instruction(17 downto 15);
                RegB   <= Instruction(14 downto 12);
                Reg_EN <= Instruction(17 downto 15);
                Load_Sel <= "100";

            when "111" =>  -- DIV
                RegA   <= Instruction(17 downto 15);
                RegB   <= Instruction(14 downto 12);
                Reg_EN <= Instruction(17 downto 15);
                Load_Sel <= "101";

            when others =>
                null;
        end case;
    end process;

end Behavioral;
