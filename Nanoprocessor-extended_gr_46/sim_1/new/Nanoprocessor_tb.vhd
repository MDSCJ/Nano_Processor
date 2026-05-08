library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Nanoprocessor_tb is
end Nanoprocessor_tb;

architecture Behavioral of Nanoprocessor_tb is

    -- Component under test
    component Nanoprocessor
        Port (
            Clk        : in  STD_LOGIC;
            Reset      : in  STD_LOGIC;
            Overflow   : out STD_LOGIC;
            Zero       : out STD_LOGIC;
            Reg_7_Out  : out STD_LOGIC_VECTOR (11 downto 0);
            Reg_0_Out  : out STD_LOGIC_VECTOR (11 downto 0);
            Reg_1_Out  : out STD_LOGIC_VECTOR (11 downto 0);
            Reg_2_Out  : out STD_LOGIC_VECTOR (11 downto 0);
            Reg_3_Out  : out STD_LOGIC_VECTOR (11 downto 0);
            Reg_4_Out  : out STD_LOGIC_VECTOR (11 downto 0);
            Reg_5_Out  : out STD_LOGIC_VECTOR (11 downto 0);
            Reg_6_Out  : out STD_LOGIC_VECTOR (11 downto 0);
            PC_out     : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Signals
    signal Clk        : STD_LOGIC := '0';
    signal Reset      : STD_LOGIC := '1';
    signal Overflow   : STD_LOGIC;
    signal Zero       : STD_LOGIC;
    signal Reg_7_Out  : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_0_Out  : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_1_Out  : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_2_Out  : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_3_Out  : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_4_Out  : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_5_Out  : STD_LOGIC_VECTOR (11 downto 0);
    signal Reg_6_Out  : STD_LOGIC_VECTOR (11 downto 0);
    signal PC_out     : STD_LOGIC_VECTOR (2 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Nanoprocessor
        port map (
            Clk        => Clk,
            Reset      => Reset,
            Overflow   => Overflow,
            Zero       => Zero,
            Reg_7_Out  => Reg_7_Out,
            Reg_0_Out  => Reg_0_Out,
            Reg_1_Out  => Reg_1_Out,
            Reg_2_Out  => Reg_2_Out,
            Reg_3_Out  => Reg_3_Out,
            Reg_4_Out  => Reg_4_Out,
            Reg_5_Out  => Reg_5_Out,
            Reg_6_Out  => Reg_6_Out,
            PC_out     => PC_out
        );

    -- Clock generation
    clk_process :process
    begin
        while true loop
            Clk <= '0';
            wait for clk_period/2;
            Clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset pulse
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';
        
        -- Run simulation for some cycles
        wait for 2000 ns;

        -- You can manually inspect values or set breakpoints in a simulator here
        assert false report "End of simulation" severity failure;
    end process;

end Behavioral;
