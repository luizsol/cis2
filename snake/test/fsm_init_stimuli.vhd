--******************************************************************************
--*                                                                            *
--* Title   : fsm_init_stimuli.vhd                                             *
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

entity fsm_init_stimuli is
    generic (
        CLK_PERIOD: TIME := 10 ns
    );

    port (
        clk         : out STD_LOGIC := '0';
        res         : out STD_LOGIC := '0';
        fsm_m_start : out STD_LOGIC := '0';
        ofc_of_x    : out STD_LOGIC := '0';
        ofc_of_y    : out STD_LOGIC := '0';
        dp_ctrl     : in  datapath_ctrl_flags;
        fsm_m_done  : in  STD_LOGIC
    );
end fsm_init_stimuli;

architecture test of fsm_init_stimuli is
    type FSM_INIT_STATES is (
        READY_STATE,
        RESET_ROW_STATE,
        WRITE_HEAD_STATE,
        JUMP_ROW_STATE
    );

    signal clk_s : STD_LOGIC;

    component clock
        generic (
            CLK_PERIOD: TIME := 10 ns
        );
        port (
            clk : out STD_LOGIC
        );
    end component ;

begin
    clk <= clk_s;

    clock_cmp : clock
        port map (
            clk => clk_s
        );

    sim : process
        procedure set_fsm(
            fsm_m_start_s, ofc_of_x_s, ofc_of_y_s: in STD_LOGIC
        ) is
        begin
            wait until falling_edge(clk_s);
                fsm_m_start <= fsm_m_start_s;
                ofc_of_x <= ofc_of_x_s;
                ofc_of_y <= ofc_of_y_s;
            wait until falling_edge(clk_s);
        end procedure set_fsm;

        procedure check_fsm_signals(
            ng_one_gen, ng_pos_neg, ng_one_three, alu_x_y, alu_pass_calc,
            rb_head_en, rb_reg2_en, rb_fifo_en, rb_fifo_pop: in STD_LOGIC;
            rb_out_sel: in RB_SEL; cg_sel: in CODE; mem_w_e: in STD_LOGIC;
            message: in STRING(1 to 15) --Failed test 000
        ) is
        begin

            assert ng_one_gen = dp_ctrl.ng_one_gen report message;
            assert ng_one_gen = dp_ctrl.ng_one_gen report message;
            assert ng_one_gen = dp_ctrl.ng_one_gen
                report "ng_one_gen: " & message;
            assert ng_pos_neg = dp_ctrl.ng_pos_neg
                report "ng_pos_neg: " & message;
            assert ng_one_three = dp_ctrl.ng_one_three
                report "ng_one_three: " & message;
            assert alu_x_y = dp_ctrl.alu_x_y report "alu_x_y: " & message;
            assert alu_pass_calc = dp_ctrl.alu_pass_calc
                report "alu_pass_calc: " & message;
            assert rb_head_en = dp_ctrl.rb_head_en
                report "rb_head_en: " & message;
            assert rb_reg2_en = dp_ctrl.rb_reg2_en
                report "rb_reg2_en: " & message;
            assert rb_fifo_en = dp_ctrl.rb_fifo_en
                report "rb_fifo_en: " & message;
            assert rb_fifo_pop = dp_ctrl.rb_fifo_pop
                report "rb_fifo_pop: " & message;
            assert rb_out_sel = dp_ctrl.rb_out_sel
                report "rb_out_sel: " & message;
            assert cg_sel = dp_ctrl.cg_sel report "cg_sel: " & message;
            assert mem_w_e = dp_ctrl.mem_w_e report "mem_w_e: " & message;

        end procedure check_fsm_signals;

        procedure check_fsm_state(
            state: in FSM_INIT_STATES;
            message: in STRING(1 to 15) --Failed test 000
        ) is
        begin

            case state is
                when READY_STATE =>
                    check_fsm_signals(
                        '0',        -- ng_one_gen
                        '0',        -- ng_pos_neg
                        '0',        -- ng_one_three
                        '0',        -- alu_x_y
                        '1',        -- alu_pass_calc
                        '0',        -- rb_head_en
                        '1',        -- rb_reg2_en
                        '0',        -- rb_fifo_en
                        '0',        -- rb_fifo_pop
                        REG2_OUT,   -- rb_out_sel
                        BLANK,      -- cg_sel
                        '0',        -- mem_w_e
                        message
                    );
                    assert fsm_m_done = '0' report "fsm_m_done: " & message;
                when RESET_ROW_STATE =>
                    check_fsm_signals(
                        '0',        -- ng_one_gen
                        '0',        -- ng_pos_neg
                        '0',        -- ng_one_three
                        '0',        -- alu_x_y
                        '1',        -- alu_pass_calc
                        '0',        -- rb_head_en
                        '1',        -- rb_reg2_en
                        '0',        -- rb_fifo_en
                        '0',        -- rb_fifo_pop
                        REG2_OUT,   -- rb_out_sel
                        BLANK,      -- cg_sel
                        '1',        -- mem_w_e
                        message
                    );
                    assert fsm_m_done = '0' report "fsm_m_done: " & message;
                when JUMP_ROW_STATE =>
                    check_fsm_signals(
                        '0',        -- ng_one_gen
                        '0',        -- ng_pos_neg
                        '0',        -- ng_one_three
                        '1',        -- alu_x_y
                        '1',        -- alu_pass_calc
                        '0',        -- rb_head_en
                        '1',        -- rb_reg2_en
                        '0',        -- rb_fifo_en
                        '0',        -- rb_fifo_pop
                        REG2_OUT,   -- rb_out_sel
                        BLANK,      -- cg_sel
                        '1',        -- mem_w_e
                        message
                    );
                    assert fsm_m_done = '0' report "fsm_m_done: " & message;
                when WRITE_HEAD_STATE =>
                    check_fsm_signals(
                        '0',        -- ng_one_gen
                        '0',        -- ng_pos_neg
                        '0',        -- ng_one_three
                        '0',        -- alu_x_y
                        '0',        -- alu_pass_calc
                        '0',        -- rb_head_en
                        '0',        -- rb_reg2_en
                        '1',        -- rb_fifo_en
                        '0',        -- rb_fifo_pop
                        HEAD_OUT,   -- rb_out_sel
                        HEAD_RIGHT, -- cg_sel
                        '1',        -- mem_w_e
                        message
                    );
                    assert fsm_m_done = '1' report "fsm_m_done: " & message;
                when others => null;
            end case;

        end procedure check_fsm_state;

        procedure reset_activate is    -- reset activation procedure
        begin
            wait until falling_edge(clk_s);
            res <= '1';
            wait until falling_edge(clk_s);
            res <= '0';
        end procedure reset_activate;

    begin
        --Test 1 - while fsm_m_start is 0 the state shoud be ready
        reset_activate;
        check_fsm_state(READY_STATE, "Failed test 001");


        set_fsm(
            '0',    --fsm_m_start_s,
            '1',    --ofc_of_x_s,
            '0'     --ofc_of_y_s
        );
        check_fsm_state(READY_STATE, "Failed test 002");

        set_fsm(
            '0',    --fsm_m_start_s,
            '0',    --ofc_of_x_s,
            '1'     --ofc_of_y_s
        );
        check_fsm_state(READY_STATE, "Failed test 003");

        set_fsm(
            '0',    --fsm_m_start_s,
            '1',    --ofc_of_x_s,
            '1'     --ofc_of_y_s
        );
        check_fsm_state(READY_STATE, "Failed test 004");

        --Test 2 - when the state is Ready, changing fsm_m_main to 1 should
        --  transition the fsm to the Reset_row state

        set_fsm(
            '1',    --fsm_m_start_s,
            '0',    --ofc_of_x_s,
            '0'     --ofc_of_y_s
        );
        check_fsm_state(RESET_ROW_STATE, "Failed test 005");

        -- Test 3 - the fsm should stay on this state as long as ofc_of_x is 0

        set_fsm(
            '0',    --fsm_m_start_s,
            '0',    --ofc_of_x_s,
            '1'     --ofc_of_y_s
        );
        check_fsm_state(RESET_ROW_STATE, "Failed test 006");

        set_fsm(
            '1',    --fsm_m_start_s,
            '0',    --ofc_of_x_s,
            '1'     --ofc_of_y_s
        );
        check_fsm_state(RESET_ROW_STATE, "Failed test 007");

        -- Test 4 - the fsm should transition to Jump_Row when ofc_of_x is 1

        set_fsm(
            '0',    --fsm_m_start_s,
            '1',    --ofc_of_x_s,
            '0'     --ofc_of_y_s
        );
        check_fsm_state(JUMP_ROW_STATE, "Failed test 008");

        -- Test 5 - when at the Jump_Row state, if ofc_of_y is 0 we should go
        --  back to Reset_Row

        set_fsm(
            '0',    --fsm_m_start_s,
            '0',    --ofc_of_x_s,
            '0'     --ofc_of_y_s
        );
        check_fsm_state(RESET_ROW_STATE, "Failed test 009");

        -- Test 6 - going back to the Jump_Row state

        set_fsm(
            '0',    --fsm_m_start_s,
            '1',    --ofc_of_x_s,
            '1'     --ofc_of_y_s
        );
        check_fsm_state(JUMP_ROW_STATE, "Failed test 010");

        -- Test 7 - when at the Jump_Row state, if ofc_of_y is 1 we should go
        --  to the state Write_Head

        wait until falling_edge(clk_s);
        check_fsm_state(WRITE_HEAD_STATE, "Failed test 011");

        -- Test 8 -- the fsm shout transition automatically to Ready

        wait until falling_edge(clk_s);
        check_fsm_state(READY_STATE, "Failed test 012");

        -- Test 9 -- when rst we should go directly to the Ready state

         set_fsm(
            '1',    --fsm_m_start_s,
            '0',    --ofc_of_x_s,
            '0'     --ofc_of_y_s
        );
        check_fsm_state(RESET_ROW_STATE, "Failed test 013");

        reset_activate;
        check_fsm_state(READY_STATE, "Failed test 014");


        wait;
    end process sim;
end architecture test;
