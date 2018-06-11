--******************************************************************************
--*                                                                            *
--* Title   : fsm_food_stimuli.vhd                                             *
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

entity fsm_food_stimuli is
    generic (
        CLK_PERIOD: TIME := 10 ns
    );

    port (
        clk             : out STD_LOGIC;
        res             : out STD_LOGIC;
        fsm_m_start     : out STD_LOGIC;
        cmp_body_flag   : out STD_LOGIC;
        ofc_of_x        : out STD_LOGIC;
        dp_ctrl         : in  datapath_ctrl_flags;
        fsm_m_done      : in  STD_LOGIC
    );
end fsm_food_stimuli;

architecture test of fsm_food_stimuli is
    type STATE_TYPE_FOOD is (
        READY, GEN_NUM, ADD_X, ADD_Y, FOOD_OK
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
            fsm_m_start_s, cmp_body_flag_s, ofc_of_x_s: in STD_LOGIC
        ) is
        begin
            wait until falling_edge(clk_s);
                fsm_m_start <= fsm_m_start_s;
                cmp_body_flag <= cmp_body_flag_s;
                ofc_of_x <= ofc_of_x_s;
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
            state: in STATE_TYPE_FOOD;
            message: in STRING(1 to 15) --Failed test 000
        ) is
        begin

            case state is
                when READY =>
                    check_fsm_signals(
                        '1',        -- ng_one_gen
                        '0',        -- ng_pos_neg
                        '0',        -- ng_one_three
                        '0',        -- alu_x_y
                        '1',        -- alu_pass_calc
                        '0',        -- rb_head_en
                        '1',        -- rb_reg2_en
                        '0',        -- rb_fifo_en
                        '0',        -- rb_fifo_pop
                        REG2_OUT,   -- rb_out_sel
                        FOOD,      -- cg_sel
                        '0',        -- mem_w_e
                        message
                    );
                    assert fsm_m_done = '0' report "fsm_m_done: " & message;
                when GEN_NUM =>
                    check_fsm_signals(
                        '1',        -- ng_one_gen
                        '0',        -- ng_pos_neg
                        '0',        -- ng_one_three
                        '0',        -- alu_x_y
                        '1',        -- alu_pass_calc
                        '0',        -- rb_head_en
                        '1',        -- rb_reg2_en
                        '0',        -- rb_fifo_en
                        '0',        -- rb_fifo_pop
                        REG2_OUT,   -- rb_out_sel
                        FOOD,      -- cg_sel
                        '0',        -- mem_w_e
                        message
                    );
                    assert fsm_m_done = '0' report "fsm_m_done: " & message;
                when ADD_X =>
                    check_fsm_signals(
                        '0',        -- ng_one_gen
                        '0',        -- ng_pos_neg
                        '1',        -- ng_one_three
                        '0',        -- alu_x_y
                        '1',        -- alu_pass_calc
                        '0',        -- rb_head_en
                        '1',        -- rb_reg2_en
                        '0',        -- rb_fifo_en
                        '0',        -- rb_fifo_pop
                        REG2_OUT,   -- rb_out_sel
                        FOOD,      -- cg_sel
                        '0',        -- mem_w_e
                        message
                    );
                    assert fsm_m_done = '0' report "fsm_m_done: " & message;
                when ADD_Y =>
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
                        FOOD,      -- cg_sel
                        '0',        -- mem_w_e
                        message
                    );
                    assert fsm_m_done = '0' report "fsm_m_done: " & message;
                when FOOD_OK =>
                    check_fsm_signals(
                        '0',        -- ng_one_gen
                        '0',        -- ng_pos_neg
                        '0',        -- ng_one_three
                        '1',        -- alu_x_y
                        '0',        -- alu_pass_calc
                        '0',        -- rb_head_en
                        '1',        -- rb_reg2_en
                        '0',        -- rb_fifo_en
                        '0',        -- rb_fifo_pop
                        REG2_OUT,   -- rb_out_sel
                        FOOD,      -- cg_sel
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
        check_fsm_state(READY, "Failed test 001");

        set_fsm(
            '0',    -- fsm_m_start
            '0',    -- cmp_body_flag
            '1'     -- ofc_of_x
        );
        check_fsm_state(READY, "Failed test 002");

        set_fsm(
            '0',    -- fsm_m_start
            '1',    -- cmp_body_flag
            '0'     -- ofc_of_x
        );
        check_fsm_state(READY, "Failed test 003");

        set_fsm(
            '0',    -- fsm_m_start
            '1',    -- cmp_body_flag
            '1'     -- ofc_of_x
        );
        check_fsm_state(READY, "Failed test 004");

        --Test 2 - when the state is Ready, changing fsm_m_start to 1 should
        --  transition the fsm to the Gen_num state

        set_fsm(
            '1',    -- fsm_m_start
            '1',    -- cmp_body_flag
            '0'     -- ofc_of_x
        );
        check_fsm_state(GEN_NUM, "Failed test 005");

        -- Test 3 - end then the fsm should automatically go to the ADD_X state
        wait until falling_edge(clk_s);

        check_fsm_state(ADD_X, "Failed test 006");

        -- Test 4 - keeping cmp_body_flag on 0 and ofc_of_x on 1 should make the
        --  fsm stay on the ADD_X state

        wait until falling_edge(clk_s);

        check_fsm_state(ADD_X, "Failed test 007");

        -- Test 5 - making cmp_body_flag = 1 and pfc_of_x = 1 should make the
        --  fsm go to the ADD_Y

        set_fsm(
            '0',    -- fsm_m_start
            '1',    -- cmp_body_flag
            '1'     -- ofc_of_x
        );
        check_fsm_state(ADD_Y, "Failed test 008"); --

        -- Test 6 - keeping cmp_body_flag on 1 should make the fsm go back to
        --  state ADD_X

        wait until falling_edge(clk_s);

        check_fsm_state(ADD_X, "Failed test 009");

        -- Test 7 - making cmp_body_flag = 0 should make the fsm got to the
        --  FOOD_OK state

        set_fsm(
            '0',    -- fsm_m_start
            '0',    -- cmp_body_flag
            '0'     -- ofc_of_x
        );
        check_fsm_state(FOOD_OK, "Failed test 010");

        -- Test 8 - now the fsm should go directly to the READY state

        wait until falling_edge(clk_s);

        check_fsm_state(READY, "Failed test 011");

        -- Test 9 -- when rst we should go directly to the Ready state

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            '0'     -- ofc_of_x
        );

        check_fsm_state(GEN_NUM, "Failed test 013");

        wait until falling_edge(clk_s);

        check_fsm_state(ADD_X, "Failed test 014");

        reset_activate;

        check_fsm_state(READY, "Failed test 015");

        wait;
    end process sim;
end architecture test;
