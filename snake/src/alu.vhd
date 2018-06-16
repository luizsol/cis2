--******************************************************************************
--*                                                                            *
--* Title   : alu.vhd                                                          *
--* Design  :                                                                  *
--* Author  :                                                                  *
--* Email   :                                                                  *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.snake_package.all;

entity alu is
    generic(
        WIDTH: NATURAL := 8
    );

    port (
        op_first        : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        rb_op           : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        ctrl_x_y        : in  STD_LOGIC;
        ctrl_pass_calc  : in  STD_LOGIC;
        ofc_result      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
    );
end alu;

architecture arch of alu is
    component rc_adder
        generic (
            WIDTH : integer := 32
        );

        port (
            a_i : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            b_i : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            c_i : in STD_LOGIC;
            z_o : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            c_o : out STD_LOGIC
        );
    end component;

    signal shift_op_s   : UNSIGNED(WIDTH - 1 downto 0);
    signal result_s     : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal carry_out_s  : STD_LOGIC;

begin
    add: rc_adder
        generic map (
            WIDTH => WIDTH
        )

        port map (
            a_i => STD_LOGIC_VECTOR(shift_op_s),
            b_i => rb_op,
            c_i => '0',
            z_o => result_s,
            c_o => carry_out_s
        );

    shift_op_s <= UNSIGNED(op_first) sll WIDTH / 2
        when (ctrl_x_y = '1')
        else
            UNSIGNED(op_first) when (ctrl_x_y = '0')
            else
                (others => 'X');

    ofc_result <= rb_op when (ctrl_pass_calc = '0')
        else
            result_s when (ctrl_pass_calc = '1')
            else
                (others => 'X');

end arch;


