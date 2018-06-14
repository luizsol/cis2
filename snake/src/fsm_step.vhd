--******************************************************************************
--*                                                                            *
--* Title   : fsm_step.vhd                                                     *
--* Design  :                                                                  *
--* Author  : Luiz Sol                                                         *
--* Email   : luizedusol@gmail.com                                             *
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

entity fsm_step is
    port (
        clk             : in STD_LOGIC;
        res             : in STD_LOGIC;
        fsm_m_start     : in STD_LOGIC;
        cmp_body_flag   : in STD_LOGIC;
        sys_direction   : in direction;
        cmp_flags       : in STD_LOGIC_VECTOR(1 downto 0);
        dp_ctrl         : out datapath_ctrl_flags;
        fsm_m_done      : out STD_LOGIC;
        fsm_m_game_over : out STD_LOGIC
    );
end fsm_step;

architecture arch of fsm_step is
    type STATE_TYPE_INIT is (
        READY, NEW_POSITION, CHECK, POP_WRITE_TAIL
    );

    signal STATE, NEXT_STATE: STATE_TYPE_INIT;

begin
    upd_state:  process (clk)
    begin
        if clk'event and clk = '1' then
            if(res = '1') then
                STATE <= READY;
            else
                case STATE is
                    when READY =>
                        if (fsm_m_start = '1') then
                            STATE <= NEW_POSITION;
                        else
                            STATE <= READY;
                        end if;

                    when NEW_POSITION =>
                        STATE <= CHECK;

                    when CHECK =>
                        if (cmp_body_flag = '1') then
                            STATE <= READY;
                        else
                            STATE <= POP_WRITE_TAIL;
                        end if;

                    when POP_WRITE_TAIL =>
                        STATE <= READY;
                    when others => null;
                end case;
            end if;
        end if;
    end process;

    upd_state_output:  process (
        fsm_m_start, cmp_body_flag, sys_direction, cmp_flags, STATE
    )
    begin
        case STATE is
            when READY =>
                dp_ctrl.ng_one_gen      <= '0';
                dp_ctrl.ng_pos_neg      <= '0';
                dp_ctrl.ng_one_three    <= '0';
                dp_ctrl.alu_x_y         <= '0';
                dp_ctrl.alu_pass_calc   <= '0';
                dp_ctrl.rb_head_en      <= '0';
                dp_ctrl.rb_reg2_en      <= '0';
                dp_ctrl.rb_fifo_en      <= '0';
                dp_ctrl.rb_fifo_pop     <= '0';
                dp_ctrl.rb_out_sel      <= HEAD_OUT;
                dp_ctrl.mem_w_e         <= '0';
                fsm_m_done              <= '0';
                fsm_m_game_over         <= '0';

                if (fsm_m_start = '0') then
                    dp_ctrl.cg_sel <= BLANK;
                end if;

            when NEW_POSITION =>
                dp_ctrl.ng_one_gen      <= '0';
                dp_ctrl.ng_one_three    <= '0';
                dp_ctrl.alu_pass_calc   <= '1';
                dp_ctrl.rb_head_en      <= '1';
                dp_ctrl.rb_reg2_en      <= '0';
                dp_ctrl.rb_fifo_en      <= '1';
                dp_ctrl.rb_fifo_pop     <= '0';
                dp_ctrl.rb_out_sel      <= HEAD_OUT;
                dp_ctrl.cg_sel          <= BLANK;
                dp_ctrl.mem_w_e         <= '0';

                if (sys_direction = S_LEFT) then
                    dp_ctrl.ng_pos_neg  <= '1';
                    dp_ctrl.alu_x_y     <= '0';
                elsif (sys_direction = S_RIGHT) then
                    dp_ctrl.ng_pos_neg  <= '0';
                    dp_ctrl.alu_x_y     <= '0';
                elsif (sys_direction = S_UP) then
                    dp_ctrl.ng_pos_neg  <= '1';
                    dp_ctrl.alu_x_y     <= '1';
                elsif (sys_direction = S_DOWN) then
                    dp_ctrl.ng_pos_neg  <= '0';
                    dp_ctrl.alu_x_y     <= '1';
                end if;

            when CHECK =>
                dp_ctrl.ng_one_gen      <= '0';
                dp_ctrl.ng_pos_neg      <= '0';
                dp_ctrl.ng_one_three    <= '0';
                dp_ctrl.alu_x_y         <= '0';
                dp_ctrl.alu_pass_calc   <= '0';
                dp_ctrl.rb_head_en      <= '0';
                dp_ctrl.rb_reg2_en      <= '0';
                dp_ctrl.rb_fifo_en      <= '0';
                dp_ctrl.rb_fifo_pop     <= '0';
                dp_ctrl.rb_out_sel      <= HEAD_OUT;
                dp_ctrl.mem_w_e         <= '1';

                if (cmp_flags = "00") then
                    fsm_m_game_over <= '0';
                elsif (cmp_flags = "10") then
                    fsm_m_done <= '1';
                else
                    fsm_m_game_over <= '1';
                end if;

                if (sys_direction = S_LEFT) then
                    dp_ctrl.cg_sel <= HEAD_LEFT;
                elsif (sys_direction = S_RIGHT) then
                    dp_ctrl.cg_sel <= HEAD_RIGHT;
                elsif (sys_direction = S_UP) then
                    dp_ctrl.cg_sel <= HEAD_UP;
                elsif (sys_direction = S_DOWN) then
                    dp_ctrl.cg_sel <= HEAD_DOWN;
                end if;

            when POP_WRITE_TAIL =>
                dp_ctrl.ng_one_gen      <= '0';
                dp_ctrl.ng_pos_neg      <= '0';
                dp_ctrl.ng_one_three    <= '0';
                dp_ctrl.alu_x_y         <= '0';
                dp_ctrl.alu_pass_calc   <= '0';
                dp_ctrl.rb_head_en      <= '0';
                dp_ctrl.rb_reg2_en      <= '0';
                dp_ctrl.rb_fifo_en      <= '0';
                dp_ctrl.rb_fifo_pop     <= '1';
                dp_ctrl.rb_out_sel      <= FIFO_OUT;
                dp_ctrl.cg_sel          <= BLANK;
                dp_ctrl.mem_w_e         <= '1';
                fsm_m_done              <= '1';
            when others => null;
        end case;
    end process;

end arch;
