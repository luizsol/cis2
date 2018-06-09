--******************************************************************************
--*                                                                            *
--* Title   : alu_tb.vhd                                                       *
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

entity alu_tb is
    generic(
        WIDTH: NATURAL := 8
    );
end alu_tb;

architecture test of alu_tb is
    component alu
        generic(
            WIDTH: NATURAL := 8
        );

        port (
            op_first    : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            rb_op       : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            ctrl_ctrl   : in  datapath_ctrl_flags;
            ofc_result  : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    component alu_stimuli is
       generic(
            WIDTH: NATURAL := 8
        );

        port (
            op_first    : out  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            rb_op       : out  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            ctrl_ctrl   : out  datapath_ctrl_flags;
            ofc_result  : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    signal op_first_s, rb_op_s,
        ofc_result_s: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

    signal ctrl_ctrl_s: datapath_ctrl_flags;

begin
    -- Instantiate DUT
    dut : alu
        port map (
            op_first    => op_first_s,
            rb_op       => rb_op_s,
            ctrl_ctrl   => ctrl_ctrl_s,
            ofc_result  => ofc_result_s
        );

    -- Instantiate stimuli generation module
    test : alu_stimuli
        port map (
            op_first    => op_first_s,
            rb_op       => rb_op_s,
            ctrl_ctrl   => ctrl_ctrl_s,
            ofc_result  => ofc_result_s
        );

end architecture test;
