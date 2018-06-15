--******************************************************************************
--*                                                                            *
--* Title   : overflow_correction_tb.vhd                                       *
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

entity overflow_correction_tb is
    generic (
        WIDTH  : natural := 8
    );
end overflow_correction_tb;

architecture test of overflow_correction_tb is
    component overflow_correction
        generic(
            WIDTH: NATURAL := 8
        );

        port (
            alu_result  : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            rb_result   : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            ctrl_of_x   : out STD_LOGIC;
            ctrl_of_y   : out STD_LOGIC
        );
    end component;

    component overflow_correction_stimuli is
        generic(
            WIDTH: NATURAL := 8
        );

        port (
            alu_result  : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            rb_result   : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            ctrl_of_x   : in  STD_LOGIC;
            ctrl_of_y   : in  STD_LOGIC
        );
    end component;

    signal ctrl_of_x_s, ctrl_of_y_s: STD_LOGIC;
    signal alu_result_s, rb_result_s : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

begin
    -- Instantiate DUT
    dut : overflow_correction
        generic map (
            WIDTH => WIDTH
        )
        port map (
            alu_result  => alu_result_s,
            rb_result   => rb_result_s,
            ctrl_of_x   => ctrl_of_x_s,
            ctrl_of_y   => ctrl_of_y_s
        );

    -- Instantiate stimuli generation module
    test : overflow_correction_stimuli
        generic map (
            WIDTH => WIDTH
        )
        port map (
            alu_result  => alu_result_s,
            rb_result   => rb_result_s,
            ctrl_of_x   => ctrl_of_x_s,
            ctrl_of_y   => ctrl_of_y_s
        );

end architecture test;
