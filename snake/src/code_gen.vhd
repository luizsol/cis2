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
        code    : in CODE;
        value   : out STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end code_gen;

architecture arch of code_gen is
begin

    upd_output: process (code)
    begin
        case code is
            when BLANK      => value <= "00000000";
            when FOOD       => value <= "10000000";
            when S_BODY     => value <= "00001000";
            when HEAD_UP    => value <= "00001001";
            when HEAD_DOWN  => value <= "00001010";
            when HEAD_LEFT  => value <= "00001100";
            when HEAD_RIGHT => value <= "00001101";
            when others     => null;
        end case;
    end process;

end arch;
