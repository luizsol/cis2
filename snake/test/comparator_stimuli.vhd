--******************************************************************************
--*                                                                            *
--* Title   : comparator_stimuli.vhd                                           *
--* Design  :                                                                  *
--* Author  : Luiz Sol                                                         *
--* Email   : luizedusol@gmail.com                                             *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.snake_package.all;

entity comparator_stimuli is
    port (
        value   : out STD_LOGIC_VECTOR(7 downto 0);
        is_food : in  STD_LOGIC := '0';
        is_body : in  STD_LOGIC := '0'
    );
end comparator_stimuli;

architecture test of comparator_stimuli  is
begin
    sim : process
    begin
        value <= BODY_VEC;
        wait for 1 ns;
        assert is_food = '0' report "BODY detection: false positive";
        assert is_body = '1' report "BODY detection: false negative";

        value <= FOOD_VEC;
        wait for 1 ns;
        assert is_food = '1' report "FOOD detection: false negative";
        assert is_body = '0' report "FOOD detection: false positive";

        value <= BLANK_VEC;
        wait for 1 ns;
        assert is_food = '0' report "BLANK detection: false positive";
        assert is_body = '0' report "BLANK detection: false positive";

        wait;
    end process sim;
end architecture test;
