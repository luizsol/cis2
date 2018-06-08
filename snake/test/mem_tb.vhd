library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_tb is
end mem_tb;

architecture test of mem_tb is
    component mem
        port (
            address_a   : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            address_b   : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            byteena_a   : IN STD_LOGIC_VECTOR(0 DOWNTO 0) := (OTHERS => '1');
            clk         : IN STD_LOGIC := '1';
            data_a      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_b      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            wren_a      : IN STD_LOGIC := '0';
            wren_b      : IN STD_LOGIC := '0';
            q_a         : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            q_b         : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;

    component mem_stimuli is
        port (
            address_a   : out STD_LOGIC_VECTOR(5 DOWNTO 0);
            address_b   : out STD_LOGIC_VECTOR(5 DOWNTO 0);
            byteena_a   : out STD_LOGIC_VECTOR(0 DOWNTO 0) := (OTHERS => '1');
            clk         : out STD_LOGIC := '1';
            data_a      : out STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_b      : out STD_LOGIC_VECTOR(7 DOWNTO 0);
            wren_a      : out STD_LOGIC := '0';
            wren_b      : out STD_LOGIC := '0';
            q_a         : in STD_LOGIC_VECTOR(7 DOWNTO 0);
            q_b         : in STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;

    signal clk_s, wren_a_s, wren_b_s: STD_LOGIC;
    signal address_a_s, address_b_s: STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal data_a_s, data_b_s, q_a_s, q_b_s: STD_LOGIC_VECTOR(7 downto 0);
    signal byteena_a_s: STD_LOGIC_VECTOR(0 DOWNTO 0);

begin
    -- Instantiate DUT
    dut : mem
        port map (
            address_a   => address_a_s,
            address_b   => address_b_s,
            byteena_a   => byteena_a_s,
            clk         => clk_s,
            data_a      => data_a_s,
            data_b      => data_b_s,
            wren_a      => wren_a_s,
            wren_b      => wren_b_s,
            q_a         => q_a_s,
            q_b         => q_b_s
        );

    -- Instantiate stimuli generation module
    test : mem_stimuli
        port map (
            address_a   => address_a_s,
            address_b   => address_b_s,
            byteena_a   => byteena_a_s,
            clk         => clk_s,
            data_a      => data_a_s,
            data_b      => data_b_s,
            wren_a      => wren_a_s,
            wren_b      => wren_b_s,
            q_a         => q_a_s,
            q_b         => q_b_s
        );

end architecture test;
