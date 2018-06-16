--******************************************************************************
--*                                                                            *
--* Title   : alu_stimuli.vhd                                                  *
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

entity alu_stimuli is
    generic(
        WIDTH: NATURAL := 8
    );

    port (
        op_first        : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        rb_op           : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        ctrl_x_y        : out STD_LOGIC;
        ctrl_pass_calc  : out STD_LOGIC;
        ofc_result      : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
    );
end alu_stimuli;

architecture test of alu_stimuli  is
    type MODE is (
        BYPASS,
        SUM,
        SHIFT_AND_SUM
    );
begin

    sim : process
        procedure select_and_write(
            m : in MODE;
            op, rb: STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        ) is
        begin
            case m is
                when BYPASS => ctrl_pass_calc <= '0';
                when SUM =>
                    ctrl_pass_calc <= '1';
                    ctrl_x_y <= '0';
                when SHIFT_AND_SUM =>
                    ctrl_pass_calc <= '1';
                    ctrl_x_y <= '1';
                when others => null;
            end case;
            op_first <= op;
            rb_op <= rb;

            wait for 5 ns;
        end procedure select_and_write;

    begin
        -- > Behaviours to be tested:
        -- 1) ctrl_pass_calc = '0' => ofc_result <= rb_op
        -- 2) ctrl_pass_calc ='1' and ctrl_x_y = '0' =>
        --    ofc_result <= rb_op + op_first
        -- 3) ctrl_pass_calc ='1' and ctrl_x_y = '1' =>
        --    ofc_result <= rb_op + (op_first << 4)

         -- Start behaviour test 1:
        select_and_write(BYPASS, "01010101", "00001111");
        assert ofc_result = "00001111" report "Test 1: The bypass mode failed";

        -- Start behaviour test 2:
        select_and_write(SUM, "01010101", "00001111");
        assert ofc_result = "01100100"
            report "Test 2: The non-shifting sum failed";

        -- Start behaviour test 3:
        select_and_write(SHIFT_AND_SUM, "00001111", "00001111");
        assert ofc_result = "11111111" report "Test 3: The shifting sum failed";

        wait;
    end process sim;
end architecture test;
