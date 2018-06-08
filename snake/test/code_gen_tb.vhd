library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.snake_package.all;

entity code_gen_tb is
end code_gen_tb;

architecture test of code_gen_tb is
    component code_gen
        port (
            code    : in CODE;
            value   : out STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;

    component code_gen_stimuli is
        port (
            code    : out CODE;
            value   : in STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;

    signal code_s: CODE;
    signal value_s: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
    -- Instantiate DUT
    dut : code_gen
        port map (
            code => code_s,
            value => value_s
        );

    -- Instantiate stimuli generation module
    test : code_gen_stimuli
        port map (
            code => code_s,
            value => value_s
        );

end architecture test;
