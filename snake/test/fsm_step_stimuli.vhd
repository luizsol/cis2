--******************************************************************************
--*                                                                            *
--* Title   : fsm_step_stimuli.vhd                                             *
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

-- TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
-- FIXME this is a work in progress! not working yet

entity fsm_step_stimuli is
    generic (
        CLK_PERIOD: TIME := 10 ns
    );

    port (
        clk             : out STD_LOGIC;
        res             : out STD_LOGIC;
        fsm_m_start     : out STD_LOGIC;
        cmp_body_flag   : out STD_LOGIC;
        sys_direction   : out direction;
        cmp_flags       : out STD_LOGIC_VECTOR(1 downto 0);
        dp_ctrl         : in  datapath_ctrl_flags;
        fsm_m_done      : in  STD_LOGIC;
        fsm_m_game_over : in  STD_LOGIC
    );
end fsm_step_stimuli;

architecture test of fsm_step_stimuli is
    type STATE_TYPE_INIT is (
        READY, NEW_POSITION, CHECK, POP_WRITE_TAIL
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
            fsm_m_start_s   : in STD_LOGIC;
            cmp_body_flag_s : in STD_LOGIC;
            sys_direction_s : in direction;
            cmp_flags_s     : in STD_LOGIC_VECTOR(1 downto 0)
        ) is
        begin
            wait until falling_edge(clk_s);
            fsm_m_start     <= fsm_m_start_s;
            cmp_body_flag   <= cmp_body_flag_s;
            sys_direction   <= sys_direction_s;
            cmp_flags       <= cmp_flags_s;
            wait until falling_edge(clk_s);
        end procedure set_fsm;

        procedure check_fsm_signals(
            ng_one_gen, ng_pos_neg, ng_one_three, alu_x_y, alu_pass_calc,
            rb_head_en, rb_reg2_en, rb_fifo_en, rb_fifo_pop: in STD_LOGIC;
            rb_out_sel: in RB_SEL; cg_sel: in CODE; mem_w_e, fsm_m_done_s,
            fsm_m_game_over_s: in STD_LOGIC; message: in STRING(1 to 15)
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
            assert fsm_m_done = fsm_m_done_s report "fsm_m_done: " & message;
            assert fsm_m_game_over = fsm_m_game_over_s
                report "fsm_m_game_over_s: " & message;

        end procedure check_fsm_signals;

        procedure reset_activate is    -- reset activation procedure
        begin
            wait until falling_edge(clk_s);
            res <= '1';
            wait until falling_edge(clk_s);
            res <= '0';
        end procedure reset_activate;

    begin
        --Let's wait for the fsm signals to settle
        reset_activate;
        set_fsm(
            '0',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_UP,   -- sys_direction
            "00"    -- cmp_flags
        );

        wait until rising_edge(clk_s);

        -- Test 1 - when at the READY state, if fsm_m_start is 0 whe sould stay
        --  at the READY state

        set_fsm(
            '0',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_UP,   -- sys_direction
            "00"    -- cmp_flags
        );
        check_fsm_signals(  -- At the READY state
            '0',        -- ng_one_gen
            '0',        -- ng_pos_neg
            '0',        -- ng_one_three
            '0',        -- alu_x_y
            '0',        -- alu_pass_calc
            '0',        -- rb_head_en
            'X',        -- rb_reg2_en -- PREVIOUS VALUE
            '0',        -- rb_fifo_en
            '0',        -- rb_fifo_pop
            HEAD_OUT,   -- rb_out_sel
            BLANK,      -- cg_sel
            '0',        -- mem_w_e
            '0',        -- fsm_m_done
            '0',        -- fsm_m_game_over
            "Failed test 001"
        );

        set_fsm(
            '0',    -- fsm_m_start
            '1',    -- cmp_body_flag
            S_UP,   -- sys_direction
            "10"    -- cmp_flags
        );
        check_fsm_signals( -- At the READY state
            '0',        -- ng_one_gen
            '0',        -- ng_pos_neg
            '0',        -- ng_one_three
            '0',        -- alu_x_y
            '0',        -- alu_pass_calc
            '0',        -- rb_head_en
            'X',        -- rb_reg2_en -- PREVIOUS VALUE
            '0',        -- rb_fifo_en
            '0',        -- rb_fifo_pop
            HEAD_OUT,   -- rb_out_sel
            BLANK,      -- cg_sel
            '0',        -- mem_w_e
            '0',        -- fsm_m_done
            '0',        -- fsm_m_game_over
            "Failed test 002"
        );

        -- Test 2 - when at the READY state, if fsm_m_start is 1 the fsm should
        --  go to the NEW_POSITION state.

        set_fsm(
            '1',    -- fsm_m_start
            '1',    -- cmp_body_flag
            S_UP,   -- sys_direction
            "00"    -- cmp_flags
        );
        check_fsm_signals( -- At the NEW_POSITION state
            '0',        -- ng_one_gen
            '0',        -- ng_pos_neg -- PREVIOUS VALUE
            '0',        -- ng_one_three
            '0',        -- alu_x_y -- PREVIOUS VALUE
            '1',        -- alu_pass_calc
            '1',        -- rb_head_en
            '0',        -- rb_reg2_en
            '1',        -- rb_fifo_en
            '0',        -- rb_fifo_pop
            HEAD_OUT,   -- rb_out_sel
            BLANK,      -- cg_sel
            '0',        -- mem_w_e
            '0',        -- fsm_m_done
            '0',        -- fsm_m_game_over
            "Failed test 003"
        );

        -- Test 3 - when at the NEW_POSITION state the fsm should go
        --  automatically to the CHECK state, and depending on the value of
        --  sys_direction during the transition the values of both ng_pos_neg
        --  and alu_x_y will change.

        check_fsm_signals( -- At the CHECK state
            '0',        -- ng_one_gen
            '1',        -- ng_pos_neg
            '0',        -- ng_one_three
            '1',        -- alu_x_y
            '1',        -- alu_pass_calc
            '1',        -- rb_head_en
            '0',        -- rb_reg2_en
            '1',        -- rb_fifo_en
            '0',        -- rb_fifo_pop
            HEAD_OUT,   -- rb_out_sel
            BLANK,      -- cg_sel
            '0',        -- mem_w_e
            '0',        -- fsm_m_done
            '0',        -- fsm_m_game_over
            "Failed test 004"
        );

        -- Test 4 - when at the CHECK state and if cmp_body_flag is 1 the fsm
        --  should go automatically to the POP_WRITE_TAIL state, and depending
        --  on the value of sys_direction and cmp_flags during the transition
        --  the values of both fsm_m_done and cg_sel will change.

        check_fsm_signals( -- At the POP_WRITE_TAIL state
            '0',        -- ng_one_gen
            '0',        -- ng_pos_neg
            '0',        -- ng_one_three
            '0',        -- alu_x_y
            '0',        -- alu_pass_calc
            '0',        -- rb_head_en
            '0',        -- rb_reg2_en
            '0',        -- rb_fifo_en
            '0',        -- rb_fifo_pop
            HEAD_OUT,   -- rb_out_sel
            HEAD_UP,    -- cg_sel
            '1',        -- mem_w_e
            '0',        -- fsm_m_done
            '0',        -- fsm_m_game_over
            "Failed test 005"
        );

        -- Test 5 - when at the POP_WRITE_TAIL state the fsm should go
        -- automatically to the READY state.

        check_fsm_signals(  -- At the POP_WRITE_TAIL state
            '0',        -- ng_one_gen
            '0',        -- ng_pos_neg
            '0',        -- ng_one_three
            '0',        -- alu_x_y
            '0',        -- alu_pass_calc
            '0',        -- rb_head_en
            '0',        -- rb_reg2_en
            '0',        -- rb_fifo_en
            '1',        -- rb_fifo_pop
            FIFO_OUT,   -- rb_out_sel
            BLANK,      -- cg_sel
            '1',        -- mem_w_e
            '1',        -- fsm_m_done
            '0',        -- fsm_m_game_over -- PREVIOUS VALUE
            "Failed test 006"
        );

        set_fsm( -- Now we will test another path
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_LEFT, -- sys_direction
            "10"    -- cmp_flags
        );

        check_fsm_signals(  -- At the READY state
            '0',        -- ng_one_gen
            '0',        -- ng_pos_neg
            '0',        -- ng_one_three
            '0',        -- alu_x_y
            '0',        -- alu_pass_calc
            '0',        -- rb_head_en
            '0',        -- rb_reg2_en -- PREVIOUS VALUE
            '0',        -- rb_fifo_en
            '0',        -- rb_fifo_pop
            HEAD_OUT,   -- rb_out_sel
            BLANK,      -- cg_sel
            '0',        -- mem_w_e
            '0',        -- fsm_m_done
            '0',        -- fsm_m_game_over
            "Failed test 007"
        );

        -- Test 5 - Now we wil test the other possible loops

        wait;
    end process sim;
end architecture test;
