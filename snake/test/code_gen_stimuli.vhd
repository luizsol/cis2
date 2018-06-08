library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.snake_package.all;

entity code_gen_stimuli is
    port (
        code    : out CODE;
        value   : in STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end code_gen_stimuli;

architecture test of code_gen_stimuli  is
begin
    sim : process
    begin
        code <= BLANK;
        wait for 1ns;
        assert value = "00000000" report "Wrong translation of BLANK";
        code <= FOOD;
        wait for 1ns;
        assert value = "10000000" report "Wrong translation of FOOD";
        code <= S_BODY;
        wait for 1ns;
        assert value = "00001000" report "Wrong translation of S_BODY";
        code <= HEAD_UP;
        wait for 1ns;
        assert value = "00001001" report "Wrong translation of HEAD_UP";
        code <= HEAD_DOWN;
        wait for 1ns;
        assert value = "00001010" report "Wrong translation of HEAD_DOWN";
        code <= HEAD_LEFT;
        wait for 1ns;
        assert value = "00001100" report "Wrong translation of HEAD_LEFT";
        code <= HEAD_RIGHT;
        wait for 1ns;
        assert value = "00001101" report "Wrong translation of HEAD_RIGHT";

        wait;
    end process sim;
end architecture test;
