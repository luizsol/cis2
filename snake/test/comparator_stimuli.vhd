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
        mem_a_read  : out STD_LOGIC_VECTOR(7 downto 0);
        food_flag   : in  STD_LOGIC;
        body_flag   : in  STD_LOGIC
    );
end comparator_stimuli;

architecture test of comparator_stimuli  is
begin
    sim : process
    begin
        mem_a_read <= BODY_VEC;
        wait for 1 ns;
        assert food_flag = '0' report "BODY detection: false positive";
        assert body_flag = '1' report "BODY detection: false negative";

        mem_a_read <= FOOD_VEC;
        wait for 1 ns;
        assert food_flag = '1' report "FOOD detection: false negative";
        assert body_flag = '0' report "FOOD detection: false positive";

        mem_a_read <= BLANK_VEC;
        wait for 1 ns;
        assert food_flag = '0' report "BLANK detection: false positive";
        assert body_flag = '0' report "BLANK detection: false positive";

        wait;
    end process sim;
end architecture test;
