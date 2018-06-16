--******************************************************************************
--*                                                                            *
--* Title   : fsm_main.vhd                                                     *
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

entity fsm_main is
    port (
        clk             : in STD_LOGIC;
        res             : in STD_LOGIC;
        cnt_rdy         : in STD_LOGIC;
        cmp_food_flag   : in STD_LOGIC;
        fsm_i_done      : in STD_LOGIC;
        fsm_f_done      : in STD_LOGIC;
        fsm_s_done      : in STD_LOGIC;
        fsm_s_game_over : in STD_LOGIC;
        con_sel         : out CONTROL_SELECT;
        fsm_i_start     : out STD_LOGIC;
        fsm_f_start     : out STD_LOGIC;
        fsm_s_start     : out STD_LOGIC
    );
end fsm_main;

architecture arch of fsm_main is
    -- SYMBOLIC ENCODED FSM STATES
    type STATE_TYPE_MAIN is (
        INIT_ATIVATION, FOOD_ACTIVATION, IDLE, STEP_ACTIVATION, GAME_OVER
    );

    signal STATE, NEXT_STATE: STATE_TYPE_MAIN;

begin

    upd_state:  process (clk)
    begin
        if clk'event and clk = '1' then
            if(res = '1') then
                STATE <= INIT_ATIVATION;
            else
                STATE <= NEXT_STATE;
            end if;
        end if;
    end process;

    upd_next_state: process (cnt_rdy, cmp_food_flag, fsm_i_done, fsm_f_done,
        fsm_s_done, fsm_s_game_over, STATE)
    begin
        case STATE is
            when INIT_ATIVATION =>
                if(fsm_i_done = '1') then
                    NEXT_STATE <= FOOD_ACTIVATION;
                else
                    NEXT_STATE <= INIT_ATIVATION;
                end if;

            when FOOD_ACTIVATION =>
                if(fsm_f_done = '1') then
                    NEXT_STATE <= IDLE;
                else
                    NEXT_STATE <= FOOD_ACTIVATION;
                end if;

            when IDLE =>
                if(cnt_rdy = '1') then
                    NEXT_STATE <= STEP_ACTIVATION;
                else
                    NEXT_STATE <= IDLE;
                end if;

            when STEP_ACTIVATION =>
                if (fsm_s_game_over = '1') then
                    NEXT_STATE <= GAME_OVER;
                -- fsm_s_game_over = 0
                elsif(cmp_food_flag = '1') then
                    NEXT_STATE <= FOOD_ACTIVATION;
                 -- fsm_s_game_over = 0 && cmp_food_flag = 0
                elsif(fsm_s_done = '1') then
                    NEXT_STATE <= IDLE;
                else
                    NEXT_STATE <= STEP_ACTIVATION;
                end if;

            when GAME_OVER =>
                NEXT_STATE <= GAME_OVER;

            when others =>
                null;

        end case;
    end process;

    upd_output: process (STATE)
    begin
        case STATE is
            when INIT_ATIVATION =>
                con_sel <= INIT_CON;
                fsm_i_start <= '1';
                fsm_f_start <= '0';
                fsm_s_start <= '0';

            when FOOD_ACTIVATION =>
                con_sel <= FOOD_CON;
                fsm_i_start <= '0';
                fsm_f_start <= '1';
                fsm_s_start <= '0';

            when IDLE =>
                con_sel <= STEP_CON;
                fsm_i_start <= '0';
                fsm_f_start <= '0';
                fsm_s_start <= '0';

            when STEP_ACTIVATION =>
                con_sel <= STEP_CON;
                fsm_i_start <= '0';
                fsm_f_start <= '0';
                fsm_s_start <= '1';

            when GAME_OVER  =>
                con_sel <= STEP_CON;
                fsm_i_start <= '0';
                fsm_f_start <= '0';
                fsm_s_start <= '0';

            when others => null;
        end case;
    end process;
end arch;
