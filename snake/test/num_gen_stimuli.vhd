library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.snake_package.all;

entity num_gen_stimuli is
    generic (
        WIDTH  : natural := 8
    );

    port (
        ctrl_ctrl   : out datapath_ctrl_flags;
        random_num  : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        number      : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
    );
end num_gen_stimuli;

architecture test of num_gen_stimuli is
begin
    sim : process
        procedure write_value(data: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0)) is
        begin
            random_num <= data;
        end procedure write_value;

        procedure select_function(one_gen, pos_neg, one_three: STD_LOGIC) is
        begin
            ctrl_ctrl.ng_one_gen <= one_gen;
            ctrl_ctrl.ng_pos_neg <= pos_neg;
            ctrl_ctrl.ng_one_three <= one_three;
        end procedure select_function;

    begin
        -- The truth table of this device must be:
        --
        -- | test | one_gen | pos_neg | one_three |   number   |
        -- |------|---------|---------|-----------|------------|
        -- |  1   |    1    |    x    |     x     | random_num |
        -- |  2   |    0    |    0    |     0     |     +1     |
        -- |  3   |    0    |    0    |     1     |     +3     |
        -- |  4   |    0    |    1    |     0     |     -1     |
        -- |  5   |    0    |    1    |     1     |     -3     |

        -- Test 1

        select_function('1', '0', '0');
        write_value("11110000");
        wait for 1 ns;
        assert number = "11110000" report
            "Test 1.1: The output was different from random_num";

        select_function('1', '0', '1');
        wait for 1 ns;
        assert number = "11110000" report
            "Test 1.2: The output was different from random_num";

        select_function('1', '1', '0');
        wait for 1 ns;
        assert number = "11110000" report
            "Test 1.3: The output was different from random_num";

        select_function('1', '1', '1');
        wait for 1 ns;
        assert number = "11110000" report
            "Test 1.4: The output was different from random_num";

        -- Test 2

        select_function('0', '0', '0');
        wait for 1 ns;
        assert number = STD_LOGIC_VECTOR(TO_UNSIGNED(1, WIDTH)) report
            "Test 2: The output was different from +1";

        -- Test 3

        select_function('0', '0', '1');
        wait for 1 ns;
        assert number = STD_LOGIC_VECTOR(TO_UNSIGNED(3, WIDTH)) report
            "Test 3: The output was different from +1";

        -- Test 4

        select_function('0', '1', '0');
        wait for 1 ns;
        assert number = STD_LOGIC_VECTOR(TO_SIGNED(-1, WIDTH)) report
            "Test 4: The output was different from +1";

        -- Test 5

        select_function('0', '1', '1');
        wait for 1 ns;
        assert number = STD_LOGIC_VECTOR(TO_SIGNED(-3, WIDTH)) report
            "Test 5: The output was different from +1";

        wait;
    end process sim;
end architecture test;
