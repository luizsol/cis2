--******************************************************************************
--*                                                                            *
--* Title   : overflow_correction_stimuli.vhd                                  *
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

entity overflow_correction_stimuli is
    generic(
        WIDTH: NATURAL := 8
    );

    port (
        ofc_result  : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        result      : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        dp_flags    : in  datapath_flags
    );
end overflow_correction_stimuli;

architecture test of overflow_correction_stimuli is
begin
    sim : process
    begin
        -- Test 1

        ofc_result <= "11111111";
        wait for 1 ns;
        assert result = "01110111" report "Test 1.1: Wrong result";
        assert dp_flags.ofc_of_x = '1' report "Test 1.2: Wrong ofc_of_x";
        assert dp_flags.ofc_of_y = '1' report "Test 1.3: Wrong ofc_of_y";

        ofc_result <= "00110011";
        wait for 1 ns;
        assert result = "00110011" report "Test 2.1: Wrong result";
        assert dp_flags.ofc_of_x = '0' report "Test 2.2: Wrong ofc_of_x";
        assert dp_flags.ofc_of_y = '0' report "Test 2.3: Wrong ofc_of_y";

        ofc_result <= "10110011";
        wait for 1 ns;
        assert result = "00110011" report "Test 3.1: Wrong result";
        assert dp_flags.ofc_of_x = '0' report "Test 3.2: Wrong ofc_of_x";
        assert dp_flags.ofc_of_y = '1' report "Test 3.3: Wrong ofc_of_y";

        ofc_result <= "00111011";
        wait for 1 ns;
        assert result = "00110011" report "Test 3.1: Wrong result";
        assert dp_flags.ofc_of_x = '1' report "Test 3.2: Wrong ofc_of_x";
        assert dp_flags.ofc_of_y = '0' report "Test 3.3: Wrong ofc_of_y";


        wait;
    end process sim;
end architecture test;
