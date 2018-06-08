--******************************************************************************
--*                                                                            *
--* Title   : code_gen.vhd                                                     *
--* Design  :                                                                  *
--* Author  :                                                                  *
--* Email   :                                                                  *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

library IEEE;
use IEEE.std_logic_1164.all;

use work.snake_package.all;

entity code_gen is
    port (
        ctrl_ctrl   : in datapath_ctrl_flags;
        value       : out STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end code_gen;

architecture arch of code_gen is
begin

    upd_output: process (ctrl_ctrl.cg_sel)
    begin
        case ctrl_ctrl.cg_sel is
            when BLANK      => value <= BLANK_VEC;
            when FOOD       => value <= FOOD_VEC;
            when S_BODY     => value <= BODY_VEC;
            when HEAD_UP    => value <= HEAD_UP_VEC;
            when HEAD_DOWN  => value <= HEAD_DOWN_VEC;
            when HEAD_LEFT  => value <= HEAD_LEFT_VEC;
            when HEAD_RIGHT => value <= HEAD_RIGHT_VEC;
            when others     => null;
        end case;
    end process;

end arch;
