library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_MainProgram is
--  Port ( );
end TB_MainProgram;

architecture Behavioral of TB_MainProgram is

    component MainProgram
        Port (
            Clk                    : in STD_LOGIC;
            Reset                  : in STD_LOGIC;
            SW                     : in STD_LOGIC_VECTOR (2 downto 0);
            Step_Mode_Switch       : in STD_LOGIC;
            Step_Button            : in STD_LOGIC;
            Mode_Switch            : in STD_LOGIC;
            Twos_Complement_Switch : in STD_LOGIC;
            Seg_7_Out              : out STD_LOGIC_VECTOR (7 downto 0); -- FIXED: Upgraded to 8 bits
            Reg_7_Out              : out STD_LOGIC_VECTOR (11 downto 0);
            Overflow               : out STD_LOGIC;
            Zero                   : out STD_LOGIC;
            Anode                  : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Standard Signals
    signal Clk_tb      : STD_LOGIC := '0';
    signal Reset_tb    : STD_LOGIC := '1';
    
    -- New Switch/Button Signals
    signal SW_tb                     : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal Step_Mode_Switch_tb       : STD_LOGIC := '0';
    signal Step_Button_tb            : STD_LOGIC := '0';
    signal Mode_Switch_tb            : STD_LOGIC := '0';
    signal Twos_Complement_Switch_tb : STD_LOGIC := '0';

    -- Output Signals
    signal Seg_7_Out_tb   : STD_LOGIC_VECTOR (7 downto 0); -- FIXED: Upgraded to 8 bits
    signal Reg_7_Out_tb   : STD_LOGIC_VECTOR (11 downto 0);
    signal Overflow_tb    : STD_LOGIC;
    signal Zero_tb        : STD_LOGIC;
    signal Anode_tb       : STD_LOGIC_VECTOR (3 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: MainProgram
        port map (
            Clk                    => Clk_tb,
            Reset                  => Reset_tb,
            SW                     => SW_tb,
            Step_Mode_Switch       => Step_Mode_Switch_tb,
            Step_Button            => Step_Button_tb,
            Mode_Switch            => Mode_Switch_tb,
            Twos_Complement_Switch => Twos_Complement_Switch_tb,
            Seg_7_Out              => Seg_7_Out_tb,
            Reg_7_Out              => Reg_7_Out_tb,
            Overflow               => Overflow_tb,
            Zero                   => Zero_tb,
            Anode                  => Anode_tb
        );

    -- Clock process
    process
    begin
        Clk_tb <= '0';
        wait for clk_period/2;
        Clk_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    process
    begin
        -- Initial Reset
        Reset_tb <= '1';
        wait for 30 ns;
        
        -- Release reset and let program run
        Reset_tb <= '0';
        
        -- Let the processor execute instructions for a while
        wait for 2000 ns;

        wait;
    end process;

end Behavioral;