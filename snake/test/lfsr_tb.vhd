library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lfsr_tb is
end lfsr_tb;

architecture test of lfsr_tb is
    component lfsr
        generic(
            WIDTH   : natural := 12;
            POL     : STD_LOGIC_VECTOR (12 downto 0) := "1110011011011"
        );

        port (
            clk : in  STD_LOGIC;
            res : in  STD_LOGIC;
            o   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component lfsr_stimuli is
        port (
            clk : out  STD_LOGIC;
            res : out  STD_LOGIC;
            o   : in STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal clk_s, rst_s: STD_LOGIC;
    signal o_s: STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate DUT
    dut : lfsr
        port map (
            clk => clk_s,
            res => rst_s,
            o   => o_s
        );

    -- Instantiate stimuli generation module
    test : lfsr_stimuli
        port map (
            clk => clk_s,
            res => rst_s,
            o   => o_s
        );

end architecture test;
