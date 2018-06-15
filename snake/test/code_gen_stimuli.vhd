--******************************************************************************
--*                                                                            *
--* Title   : code_gen_stimuli.vhd                                             *
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

entity code_gen_stimuli is
    port (
        ctrl_code_sel   : out CODE;
        mem_code_w      : in  STD_LOGIC_VECTOR(7 downto 0)
    );
end code_gen_stimuli;

architecture test of code_gen_stimuli  is
begin
    sim : process
    begin
        ctrl_code_sel <= BLANK;
        wait for 1 ns;
        assert mem_code_w = BLANK_VEC report "Wrong translation of BLANK";

        ctrl_code_sel <= FOOD;
        wait for 1 ns;
        assert mem_code_w = FOOD_VEC report "Wrong translation of FOOD";

        ctrl_code_sel <= S_BODY;
        wait for 1 ns;
        assert mem_code_w = BODY_VEC report "Wrong translation of S_BODY";

        ctrl_code_sel <= HEAD_UP;
        wait for 1 ns;
        assert mem_code_w = HEAD_UP_VEC report "Wrong translation of HEAD_UP";

        ctrl_code_sel <= HEAD_DOWN;
        wait for 1 ns;
        assert mem_code_w = HEAD_DOWN_VEC
            report "Wrong translation of HEAD_DOWN";

        ctrl_code_sel <= HEAD_LEFT;
        wait for 1 ns;
        assert mem_code_w = HEAD_LEFT_VEC
            report "Wrong translation of HEAD_LEFT";

        ctrl_code_sel <= HEAD_RIGHT;
        wait for 1 ns;
        assert mem_code_w = HEAD_RIGHT_VEC
            report "Wrong translation of HEAD_RIGHT";

        wait;
    end process sim;
end architecture test;
