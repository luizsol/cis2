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
        alu_result  : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        rb_result   : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        ctrl_of_x   : out STD_LOGIC;
        ctrl_of_y   : out STD_LOGIC
    );
end overflow_correction;


architecture arch of overflow_correction is
begin
    rb_result <= "0" & alu_result(WIDTH - 2 downto WIDTH / 2) & "0"
        & alu_result(WIDTH / 2 - 2 downto 0);

    ctrl_of_y <= alu_result(WIDTH - 1);
    ctrl_of_x <= alu_result(WIDTH / 2 - 1);

END arch;
