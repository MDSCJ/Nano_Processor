library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;

-- 8-Bit Nanoprocessor Top-Level Design for Basys3
entity Design is
    port(
        ClkIn : in std_logic;                   -- 100 MHz Clock from Basys3
        ResetIn : in std_logic;                 -- Reset Button
        Overflow : out std_logic;               -- Overflow Flag
        Zero : out std_logic;                   -- Zero Flag
        Display : out std_logic_vector(3 downto 0);  -- Seven-segment select
        seg : out std_logic_vector(6 downto 0);     -- Seven-segment output
        led : out std_logic_vector(7 downto 0);     -- 8 LEDs for data output
        ram_addr_led : out std_logic_vector(3 downto 0);  -- RAM address display
        ram_data_led : out std_logic_vector(7 downto 0)   -- RAM data display
    );
end Design;

architecture Behavioral of Design is

component Nanoprocessor is
    port(
        Clk : in std_logic;
        Res : in std_logic;
        Overflow : out std_logic;
        Zero : out std_logic;
        Data : out data_bus;
        RAM_Addr : out std_logic_vector(3 downto 0);
        RAM_Dout : out data_bus
    );
end component;

-- Slow clock
component Slow_Clk is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end component;

-- Seven Segment Display LUT
component SevenSegmentLUT is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0));
end component;

-- Slow clock signal to Nanoprocessor
signal Clk : std_logic;
signal ProgramOut : std_logic_vector(7 downto 0);
signal RAM_Addr_Out : std_logic_vector(3 downto 0);
signal RAM_Data_Out : std_logic_vector(7 downto 0);

begin
    -- Slow clock
    SlowClock_inst : Slow_Clk
    port map(
        Clk_in => ClkIn,
        Clk_out => Clk
    );

    -- Nanoprocessor
    Nanoprocessor_inst : Nanoprocessor
    port map(
        Clk => Clk,
        Res => ResetIn,
        Overflow => Overflow,
        Zero => Zero,
        Data => ProgramOut,
        RAM_Addr => RAM_Addr_Out,
        RAM_Dout => RAM_Data_Out
    );

    -- Seven Segment Display LUT (show lower 4 bits of result)
    SevenSegmentLUT_inst : SevenSegmentLUT
    port map(
        address => ProgramOut(3 downto 0),
        data => seg
    );

    Display <= "0111";           -- Select digit 0
    led <= ProgramOut;           -- Display processor output on 8 LEDs
    ram_addr_led <= RAM_Addr_Out;  -- Display RAM address
    ram_data_led <= RAM_Data_Out;  -- Display RAM data

end Behavioral;

