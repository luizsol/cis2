library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.snake_package.all;

entity code_gen_stimuli is
    port (
        ctrl_ctrl   : out datapath_ctrl_flags;
        value       : in STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end code_gen_stimuli;

architecture test of code_gen_stimuli  is
begin
    sim : process
    begin
        ctrl_ctrl.cg_sel <= BLANK;
        wait for 1 ns;
        assert value = BLANK_VEC report "Wrong translation of BLANK";

        ctrl_ctrl.cg_sel <= FOOD;
        wait for 1 ns;
        assert value = FOOD_VEC report "Wrong translation of FOOD";

        ctrl_ctrl.cg_sel <= S_BODY;
        wait for 1 ns;
        assert value = BODY_VEC report "Wrong translation of S_BODY";

        ctrl_ctrl.cg_sel <= HEAD_UP;
        wait for 1 ns;
        assert value = HEAD_UP_VEC report "Wrong translation of HEAD_UP";

        ctrl_ctrl.cg_sel <= HEAD_DOWN;
        wait for 1 ns;
        assert value = HEAD_DOWN_VEC report "Wrong translation of HEAD_DOWN";

        ctrl_ctrl.cg_sel <= HEAD_LEFT;
        wait for 1 ns;
        assert value = HEAD_LEFT_VEC report "Wrong translation of HEAD_LEFT";

        ctrl_ctrl.cg_sel <= HEAD_RIGHT;
        wait for 1 ns;
        assert value = HEAD_RIGHT_VEC report "Wrong translation of HEAD_RIGHT";

        wait;
    end process sim;
end architecture test;
