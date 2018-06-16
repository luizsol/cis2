--******************************************************************************
--*                                                                            *
--* Title   : fsm_step.vhd                                                     *
--* Design  :                                                                  *
--* Author  : Frederik Luhrs                                                   *
--* Email   : luizedusol@gmail.com                                             *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description : FSM to execute a step by finding the new head position and   *
--*               checking if there was body or food hit.                      *
--*                                                                            *
--******************************************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

use work.snake_package.all;

entity fsm_step is
    port (
        clk             : in  STD_LOGIC;
        res             : in  STD_LOGIC;
        fsm_m_start     : in  STD_LOGIC;
        cmp_food_flag   : in  STD_LOGIC;
        cmp_body_flag   : in  STD_LOGIC;
        sys_direction   : in  direction;
        dp_ctrl         : out datapath_ctrl_flags;
        fsm_m_done      : out STD_LOGIC;
        fsm_m_game_over : out STD_LOGIC
    );
end fsm_step;

architecture arch of fsm_step is

    type STATE_TYPE_STEP is (
        READY, NEW_POSITION, CHECK, POP_WRITE_TAIL
    );

    signal STATE, NEXT_STATE: STATE_TYPE_STEP;

    signal CMP_FLAGS : STD_LOGIC_VECTOR(1 downto 0);

begin

    CMP_FLAGS <= cmp_food_flag & cmp_body_flag;

    upd_next_state: process (
        fsm_m_start, cmp_body_flag, cmp_food_flag, sys_direction, STATE
    )
    begin
        case STATE is
            when READY =>
                if(fsm_m_start = '1') then
                    NEXT_STATE <= NEW_POSITION;
                else
                    NEXT_STATE <= READY;
                end if;

            when NEW_POSITION => NEXT_STATE <= CHECK;

            when CHECK =>
                if(cmp_food_flag = '1') then
                    NEXT_STATE <= READY;
                else
                    NEXT_STATE <= POP_WRITE_TAIL;
                end if;

            when POP_WRITE_TAIL => NEXT_STATE <= READY;

            when others => null;

        end case;
    end process;

    upd_state: process (clk)
    begin
        if clk'event and clk = '1' then
            if(res = '1')    then
                STATE <= READY;
            else
                STATE <= NEXT_STATE;
            end if;
        end if;
    end process;

    upd_output: process (fsm_m_start, CMP_FLAGS, sys_direction, STATE)
    begin
        case STATE is
            when READY =>
                case fsm_m_start is
                    when '0' =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '0',
                            ng_one_three    => '0',
                            alu_x_y         => '0',
                            alu_pass_calc   => '0',
                            rb_head_en      => '0',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '0',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => BLANK,
                            mem_w_e         => '0'
                        );

                        fsm_m_done      <= '0';
                        fsm_m_game_over <= '0';

                    when '1' =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '0',
                            ng_one_three    => '0',
                            alu_x_y         => '0',
                            alu_pass_calc   => '0',
                            rb_head_en      => '0',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '0',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => S_BODY,
                            mem_w_e         => '1'
                        );

                        fsm_m_done      <= '0';
                        fsm_m_game_over <= '0';

                    when others => null;
                end case;

            when NEW_POSITION =>
                case sys_direction is
                    when S_LEFT =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '1',
                            ng_one_three    => '0',
                            alu_x_y         => '0',
                            alu_pass_calc   => '1',
                            rb_head_en      => '1',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '1',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => BLANK,
                            mem_w_e         => '0'
                        );

                        fsm_m_done      <= '0';
                        fsm_m_game_over <= '0';

                    when S_RIGHT =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '0',
                            ng_one_three    => '0',
                            alu_x_y         => '0',
                            alu_pass_calc   => '1',
                            rb_head_en      => '1',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '1',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => BLANK,
                            mem_w_e         => '0'
                        );

                        fsm_m_done      <= '0';
                        fsm_m_game_over <= '0';

                    when S_UP =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '1',
                            ng_one_three    => '0',
                            alu_x_y         => '1',
                            alu_pass_calc   => '1',
                            rb_head_en      => '1',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '1',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => BLANK,
                            mem_w_e         => '0'
                        );

                        fsm_m_done      <= '0';
                        fsm_m_game_over <= '0';

                    when S_DOWN =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '0',
                            ng_one_three    => '0',
                            alu_x_y         => '1',
                            alu_pass_calc   => '1',
                            rb_head_en      => '1',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '1',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => BLANK,
                            mem_w_e         => '0'
                        );

                        fsm_m_done      <= '0';
                        fsm_m_game_over <= '0';

                    when others => null;
                end case;

            when CHECK =>
                case CMP_FLAGS is
                    when "00" =>
                        fsm_m_done      <= '0';
                        fsm_m_game_over <= '0';

                    when "10" =>
                        fsm_m_done      <= '1';
                        fsm_m_game_over <= '0';

                    when "01" | "11" =>
                        fsm_m_done      <= '0';
                        fsm_m_game_over <= '1';

                    when others => null;

                end case;

                case sys_direction is
                    when S_LEFT =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '0',
                            ng_one_three    => '0',
                            alu_x_y         => '0',
                            alu_pass_calc   => '0',
                            rb_head_en      => '0',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '0',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => HEAD_LEFT,
                            mem_w_e         => '1'
                        );

                    when S_RIGHT =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '0',
                            ng_one_three    => '0',
                            alu_x_y         => '0',
                            alu_pass_calc   => '0',
                            rb_head_en      => '0',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '0',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => HEAD_RIGHT,
                            mem_w_e          => '1'
                        );

                    when S_UP =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '0',
                            ng_one_three    => '0',
                            alu_x_y         => '0',
                            alu_pass_calc   => '0',
                            rb_head_en      => '0',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '0',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => HEAD_UP,
                            mem_w_e         => '1'
                        );

                    when S_DOWN =>
                        dp_ctrl <= (
                            ng_one_gen      => '0',
                            ng_pos_neg      => '0',
                            ng_one_three    => '0',
                            alu_x_y         => '0',
                            alu_pass_calc   => '0',
                            rb_head_en      => '0',
                            rb_reg2_en      => '0',
                            rb_fifo_en      => '0',
                            rb_fifo_pop     => '0',
                            rb_out_sel      => HEAD_OUT,
                            cg_sel          => HEAD_DOWN,
                            mem_w_e         => '1'
                        );

                    when others => null;

                end case;

            when POP_WRITE_TAIL =>
                dp_ctrl <= (
                    ng_one_gen      => '0',
                    ng_pos_neg      => '0',
                    ng_one_three    => '0',
                    alu_x_y         => '0',
                    alu_pass_calc   => '0',
                    rb_head_en      => '0',
                    rb_reg2_en      => '0',
                    rb_fifo_en      => '0',
                    rb_fifo_pop     => '1',
                    rb_out_sel      => FIFO_OUT,
                    cg_sel          => BLANK,
                    mem_w_e         => '1'
                );

                fsm_m_done      <= '1';
                fsm_m_game_over <= '0';

            when others => null;
        end case;
    end process;
end arch;
