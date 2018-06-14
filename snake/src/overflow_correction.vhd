--******************************************************************************
--*                                                                            *
--* Title   : overflow_correction.vhd                                          *
--* Design  :                                                                  *
--* Author  : Luiz Sol                                                         *
--* Email   : luizedusol@gmail.com                                             *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

use work.snake_package.all;

entity overflow_correction is
    generic(
        WIDTH: NATURAL := 8
    );

    port (
        ofc_result  : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        result      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        dp_flags    : out datapath_flags
    );
end overflow_correction;


architecture arch of overflow_correction is
begin
    result <= "0" & ofc_result(WIDTH - 2 downto WIDTH / 2) & "0"
        & ofc_result(WIDTH / 2 - 2 downto 0);

    dp_flags.ofc_of_y <= ofc_result(WIDTH - 1);
    dp_flags.ofc_of_x <= ofc_result(WIDTH / 2 - 1);

END arch;
