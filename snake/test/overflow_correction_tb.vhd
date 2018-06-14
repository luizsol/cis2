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
            ofc_result  : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            result      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            dp_flags    : out datapath_flags
        );
    end component;

    component overflow_correction_stimuli is
        generic(
            WIDTH: NATURAL := 8
        );

        port (
            ofc_result  : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            result      : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            dp_flags    : in  datapath_flags
        );
    end component;

    signal dp_flags_s: datapath_flags;
    signal ofc_result_s, result_s : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

begin
    -- Instantiate DUT
    dut : overflow_correction
        generic map (
            WIDTH => WIDTH
        )
        port map (
            ofc_result  => ofc_result_s,
            result      => result_s,
            dp_flags    => dp_flags_s
        );

    -- Instantiate stimuli generation module
    test : overflow_correction_stimuli
        generic map (
            WIDTH => WIDTH
        )
        port map (
            ofc_result  => ofc_result_s,
            result      => result_s,
            dp_flags    => dp_flags_s
        );

end architecture test;
