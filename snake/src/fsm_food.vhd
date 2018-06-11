--******************************************************************************
--*                                                                            *
--* Title   : fsm_food.vhd                                                     *
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

use work.snake_package.all;

entity fsm_food is
    port (
        clk             : in STD_LOGIC;
        res             : in STD_LOGIC;
        fsm_m_start     : in STD_LOGIC;
        cmp_body_flag   : in STD_LOGIC;
        ofc_of_x        : in STD_LOGIC;
        dp_ctrl         : out datapath_ctrl_flags;
        fsm_m_done      : out STD_LOGIC
    );
end fsm_food;

architecture arch of fsm_food is

    type STATE_TYPE_FOOD is (
        READY, GEN_NUM, ADD_X, ADD_Y, FOOD_OK
    );

    signal STATE, NEXT_STATE: STATE_TYPE_FOOD;

begin
    upd_next_state: process (fsm_m_start, ofc_of_x, cmp_body_flag, STATE)
    begin
        case STATE is
            when READY =>
                if (fsm_m_start = '1') then
                    NEXT_STATE <= GEN_NUM;
                else
                    NEXT_STATE <= READY;
                end if;

            when GEN_NUM => NEXT_STATE <= ADD_X;

            when ADD_X =>
                if (cmp_body_flag = '0') then
                    NEXT_STATE <= FOOD_OK;
                else
                    if (ofc_of_x = '0') then
                        NEXT_STATE <= ADD_X;
                    else
                        NEXT_STATE <= ADD_Y;
                    end if;
                end if;

            when FOOD_OK => NEXT_STATE <= READY;

            when ADD_Y =>
                if (cmp_body_flag = '1') then
                    NEXT_STATE <= ADD_X;
                else
                    NEXT_STATE <= FOOD_OK;
                end if;

            when others => null;
        end case;
    end process;

    upd_state:  process (clk)
    begin
        if clk'event and clk = '1' then
            if (res = '1')   then
                STATE <= READY;
            else
                STATE <= NEXT_STATE;
            end if;
        end if;
    end process;

    upd_output: process (STATE)
    begin
        case STATE is
            when READY =>
                dp_ctrl <= (
                    ng_one_gen      => '1',
                    ng_pos_neg      => '0',
                    ng_one_three    => '0',
                    alu_x_y         => '0',
                    alu_pass_calc   => '1',
                    rb_head_en      => '0',
                    rb_reg2_en      => '1',
                    rb_fifo_en      => '0',
                    rb_fifo_pop     => '0',
                    rb_out_sel      => REG2_OUT,
                    cg_sel          => FOOD,
                    mem_w_e         => '0'
                );
                fsm_m_done <= '0';

            when GEN_NUM =>
                dp_ctrl <= (
                    ng_one_gen      => '1',
                    ng_pos_neg      => '0',
                    ng_one_three    => '0',
                    alu_x_y         => '0',
                    alu_pass_calc   => '1',
                    rb_head_en      => '0',
                    rb_reg2_en      => '1',
                    rb_fifo_en      => '0',
                    rb_fifo_pop     => '0',
                    rb_out_sel      => REG2_OUT,
                    cg_sel          => FOOD,
                    mem_w_e         => '0'
                );
                fsm_m_done <= '0';

            when ADD_X =>
                dp_ctrl <= (
                    ng_one_gen      => '0',
                    ng_pos_neg      => '0',
                    ng_one_three    => '1',
                    alu_x_y         => '0',
                    alu_pass_calc   => '1',
                    rb_head_en      => '0',
                    rb_reg2_en      => '1',
                    rb_fifo_en      => '0',
                    rb_fifo_pop     => '0',
                    rb_out_sel      => REG2_OUT,
                    cg_sel          => FOOD,
                    mem_w_e         => '0'
                );
                fsm_m_done <= '0';

            when ADD_Y =>
                dp_ctrl <= (
                    ng_one_gen      => '0',
                    ng_pos_neg      => '0',
                    ng_one_three    => '0',
                    alu_x_y         => '1',
                    alu_pass_calc   => '1',
                    rb_head_en      => '0',
                    rb_reg2_en      => '1',
                    rb_fifo_en      => '0',
                    rb_fifo_pop     => '0',
                    rb_out_sel      => REG2_OUT,
                    cg_sel          => FOOD,
                    mem_w_e         => '0'
                );
                fsm_m_done <= '0';

            when FOOD_OK =>
                dp_ctrl <= (
                    ng_one_gen      => '0',
                    ng_pos_neg      => '0',
                    ng_one_three    => '0',
                    alu_x_y         => '1',
                    alu_pass_calc   => '0',
                    rb_head_en      => '0',
                    rb_reg2_en      => '1',
                    rb_fifo_en      => '0',
                    rb_fifo_pop     => '0',
                    rb_out_sel      => REG2_OUT,
                    cg_sel          => FOOD,
                    mem_w_e         => '1'
                );
                fsm_m_done <= '1';

            when others => null;
        end case;
    end process;

end arch;
