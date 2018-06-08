LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

use work.snake_package.all;

entity num_gen is
    generic (
        WIDTH  : natural := 8
    );

    port (
        ctrl_ctrl   : in  datapath_ctrl_flags;
        random_num  : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        number      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
    );
end num_gen;


architecture arch of num_gen is

    signal pos_neg_s      : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal one_three_s    : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal one_gen_s      : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

begin
    pos_neg_s <= STD_LOGIC_VECTOR(TO_UNSIGNED(1, pos_neg_s'length))
                 when (ctrl_ctrl.ng_pos_neg = '0')
                 else
                     STD_LOGIC_VECTOR(TO_SIGNED(-1, pos_neg_s'length))
                     when (ctrl_ctrl.ng_pos_neg = '1')
                     else
                         (OTHERS => 'X' );

    one_three_s <= pos_neg_s when (ctrl_ctrl.ng_one_three = '0')
                   else
                       pos_neg_s(WIDTH - 1 downto 2) & (NOT pos_neg_s(1))
                           & pos_neg_s(0) when(ctrl_ctrl.ng_one_three = '1')
                       else
                           (OTHERS => 'X' );

    one_gen_s <= one_three_s when ctrl_ctrl.ng_one_gen = '0'
                 else
                    random_num when ctrl_ctrl.ng_one_gen = '1'
                    else
                        (OTHERS => 'X' );

    number <= one_gen_s;

END arch;
