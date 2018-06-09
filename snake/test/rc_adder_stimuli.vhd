--******************************************************************************
--*                                                                            *
--* Title   : rc_adder_stimuli.vhd                                             *
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

entity rc_adder_stimuli is
    generic (
        WIDTH : integer
    );

    port (
        a_i : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        b_i : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        c_i : out STD_LOGIC;
        z_o : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        c_o : in STD_LOGIC
    );
end rc_adder_stimuli;

architecture test of rc_adder_stimuli is

begin
    sim : process
        procedure write_value(a, b: unsigned; c: STD_LOGIC) is
        begin
            a_i <= STD_LOGIC_VECTOR(a);
            b_i <= STD_LOGIC_VECTOR(b);
            c_i <= c;
            wait for 5 ns;
        end procedure write_value;

    begin
        -- Test 1
        write_value(TO_UNSIGNED(0, WIDTH), TO_UNSIGNED(0, WIDTH), '0');
        assert ((z_o = STD_LOGIC_VECTOR(TO_UNSIGNED(0, WIDTH))) and (c_o = '0'))
            report "Test 1: 0 + 0 != 0";

        write_value(TO_UNSIGNED(100, WIDTH), TO_UNSIGNED(12, WIDTH), '1');
        assert ((z_o = STD_LOGIC_VECTOR(TO_UNSIGNED(113, WIDTH))) and (c_o = '0'))
            report "Test 2: 100 + 12 + 1 != 113";

        write_value(TO_UNSIGNED(65535, WIDTH), TO_UNSIGNED(1, WIDTH), '0');
        assert ((z_o = STD_LOGIC_VECTOR(TO_UNSIGNED(0, WIDTH))) and (c_o = '1'))
            report "Test 3: 2147483647 + 1 != 0 + c_out";

        write_value(TO_UNSIGNED(65535, WIDTH), TO_UNSIGNED(65535, WIDTH), '1');
        assert ((z_o = STD_LOGIC_VECTOR(TO_UNSIGNED(65535, WIDTH)))
            and (c_o = '1')) report "Test 3: 2147483647 + 1 != 0 + c_out";

        wait;
    end process sim;
end architecture test;
