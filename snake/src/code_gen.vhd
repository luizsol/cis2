--******************************************************************************
--*                                                                            *
--* Title   : code_gen.vhd                                                     *
--* Design  :                                                                  *
--* Author  : Luiz Sol                                                         *
--* Email   : luizedusol@gmail.com                                             *
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
        ctrl_code_sel   : in CODE;
        mem_code_w      : out STD_LOGIC_VECTOR(7 downto 0)
    );
end code_gen;

architecture arch of code_gen is
begin

    upd_output: process (ctrl_code_sel)
    begin
        case ctrl_code_sel is
            when BLANK      => mem_code_w <= BLANK_VEC;
            when FOOD       => mem_code_w <= FOOD_VEC;
            when S_BODY     => mem_code_w <= BODY_VEC;
            when HEAD_UP    => mem_code_w <= HEAD_UP_VEC;
            when HEAD_DOWN  => mem_code_w <= HEAD_DOWN_VEC;
            when HEAD_LEFT  => mem_code_w <= HEAD_LEFT_VEC;
            when HEAD_RIGHT => mem_code_w <= HEAD_RIGHT_VEC;
            when others     => null;
        end case;
    end process;

end arch;
