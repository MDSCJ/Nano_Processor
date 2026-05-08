----------------------------------------------------------------------------------
-- Module Name: IDecoder_gr_46 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Buses_gr_46.all;
use work.Constants_gr_46.all;
use work.ALU_H_gr_46.all;

entity IDecoder_gr_46 is
    port(
        I : in instruction_bus;
        RCJump : in data_bus;
        Zero_Flag : in std_logic;
        Carry_Flag : in std_logic;
        Negative_Flag : in std_logic;
        REn : out register_address;
        RSA : out register_address;
        RSB : out register_address;
        OpS : out Operation_Sel;
        IM : out data_bus;
        J : out std_logic;
        JA : out instruction_address;
        L : out std_logic;
        RAM_Addr : out ram_address;
        RAM_WE : out std_logic;
        RAM_OE : out std_logic
    );
end IDecoder_gr_46;

architecture Behavioral of IDecoder_gr_46 is
    signal Op_Type : std_logic_vector(1 downto 0);
    signal Sub_Op : std_logic_vector(1 downto 0);
    signal Dest_Reg : register_address;
    signal Addr_Lo : std_logic_vector(1 downto 0);
begin
    Op_Type <= I(7 downto 6);
    Sub_Op <= I(5 downto 4);
    Dest_Reg <= I(3 downto 2);
    Addr_Lo <= I(1 downto 0);

    decode : process(Op_Type, Sub_Op, Dest_Reg, Addr_Lo, I, Zero_Flag, Carry_Flag, Negative_Flag)
    begin
        J <= '0';
        RAM_WE <= '0';
        RAM_OE <= '0';
        RAM_Addr <= (others => '0');
        JA <= (others => '0');
        IM <= (others => '0');
        REn <= (others => '0');
        RSA <= (others => '0');
        RSB <= (others => '0');
        OpS <= AU_ADD_SIGNAL;
        L <= Immediate_Load;

        case Op_Type is
            when ARITHMETIC_OP =>
                REn <= Dest_Reg;
                RSA <= Dest_Reg;
                RSB <= Addr_Lo;
                L <= Register_Load;
                case Sub_Op is
                    when ADD_SUBOP => OpS <= AU_ADD_SIGNAL;
                    when SUB_SUBOP => OpS <= AU_SUB_SIGNAL;
                    when MUL_SUBOP => OpS <= AU_MUL_SIGNAL;
                    when DIV_SUBOP => OpS <= AU_DIV_SIGNAL;
                    when others => OpS <= AU_ADD_SIGNAL;
                end case;

            when LOAD_OP =>
                REn <= Sub_Op;
                RAM_Addr <= I(3 downto 0);
                RAM_OE <= '1';
                RAM_WE <= '0';
                L <= RAM_Load;

            when STORE_OP =>
                RSA <= Sub_Op;
                RAM_Addr <= I(3 downto 0);
                RAM_WE <= '1';
                RAM_OE <= '0';
                REn <= (others => '0');

            when JUMP_OP =>
                JA <= I(3 downto 0);
                case Sub_Op is
                    when JUMP_UNCOND => J <= '1';
                    when JUMP_ZERO => J <= Zero_Flag;
                    when JUMP_CARRY => J <= Carry_Flag;
                    when JUMP_NEGATIVE => J <= Negative_Flag;
                    when others => J <= '0';
                end case;

            when others => null;
        end case;
    end process decode;
end Behavioral;
