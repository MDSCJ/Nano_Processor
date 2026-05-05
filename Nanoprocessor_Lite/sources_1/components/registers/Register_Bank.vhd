library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;
use work.cpu_components.reg;
use work.Logic_Components.Decoder_2_to_4;

entity Register_Bank is
    Port ( Reg_En : in register_address;      -- 2-bit register address (4 registers)
           Res : in STD_LOGIC;                -- Reset
           Clk : in STD_LOGIC;                -- Clock
           Data : in data_bus;                -- 8-bit data input
           Data_Buses : out data_buses);      -- 4 × 8-bit register outputs
end Register_Bank;

architecture Behavioral of Register_Bank is

signal Reg_Sel : STD_LOGIC_VECTOR(3 downto 0);  -- Decoder output for 4 registers

begin
    -- Decoder: 2-bit address to 4 enable lines
    Decoder_2_to_4_0 : Decoder_2_to_4
        port map(
            I => Reg_En,
            EN => '1',  -- Always enabled
            Y => Reg_Sel
        );

    -- Register 0 (Read-Only, always zero)
    reg_inst0: reg
        generic map(
            N => 8  -- 8-bit registers
        )
        port map(
            D => x"00",
            Res => Res,
            EN => '1',
            Clk => Clk,
            Q => Data_Buses(0)
        );

    -- Registers 1-3 (Read-Write)
    registers : for i in 1 to 3 generate
       reg_inst: reg
            generic map(
                N => 8  -- 8-bit registers
            )
            port map(
                D => Data,
                Res => Res,
                EN => Reg_Sel(i),
                Clk => Clk,
                Q => Data_Buses(i)
            );
    end generate registers;

end Behavioral;
