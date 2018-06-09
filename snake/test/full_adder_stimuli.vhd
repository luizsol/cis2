--******************************************************************************
--*                                                                            *
--* Title   : full_adder_stimuli.vhd                                           *
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

entity full_adder_stimuli is
    port (
        a_in    : out  STD_LOGIC;
        b_in    : out  STD_LOGIC;
        c_in    : out  STD_LOGIC;
        z_out   : in STD_LOGIC;
        c_out   : in STD_LOGIC
    );
end full_adder_stimuli;

architecture test of full_adder_stimuli  is

    signal test_result, z, c_o: STD_LOGIC;

begin

    test_result <= (not (z_out xor z)) and (not (c_out xor c_o));

    sim : process

        procedure set_values(a, b, c_i, z_s, c_o_s : in STD_LOGIC) is
        begin
            a_in <= a;
            b_in <= b;
            c_in <= c_i;
            z <= z_s;
            c_o <= c_o_s;
            wait for 5 ns;
        end procedure set_values;


        begin

            -- The truth table of this device must be:
            --
            -- | test | a_in | b_in | c_in | z_out | c_out |
            -- |------|------|------|------|-------|-------|
            -- |  1   |  0   |  0   |  0   |   0   |   0   |
            -- |  2   |  0   |  0   |  1   |   1   |   0   |
            -- |  3   |  0   |  1   |  0   |   1   |   0   |
            -- |  4   |  0   |  1   |  1   |   0   |   1   |
            -- |  5   |  1   |  0   |  0   |   1   |   0   |
            -- |  6   |  1   |  0   |  1   |   0   |   1   |
            -- |  7   |  1   |  1   |  0   |   0   |   1   |
            -- |  8   |  1   |  1   |  1   |   1   |   1   |


        set_values('0', '0', '0', '0', '0');
        assert test_result = '1' report "1st test failed.";

        wait for 1 ns;

        set_values('0', '0', '1', '1', '0');
        assert test_result = '1' report "2nd test failed.";

        wait for 1 ns;

        set_values('0', '1', '0', '1', '0');
        assert test_result = '1' report "3rd test failed.";

        wait for 1 ns;

        set_values('0', '1', '1', '0', '1');
        assert test_result = '1' report "4th test failed.";

        wait for 1 ns;

        set_values('1', '0', '0', '1', '0');
        assert test_result = '1' report "5th test failed.";

        wait for 1 ns;

        set_values('1', '0', '1', '0', '1');
        assert test_result = '1' report "6th test failed.";

        wait for 1 ns;

        set_values('1', '1', '0', '0', '1');
        assert test_result = '1' report "7th test failed.";

        wait for 1 ns;

        set_values('1', '1', '1', '1', '1');
        assert test_result = '1' report "8th test failed.";

        wait for 1 ns;

        wait;
    end process sim;
end architecture test;
