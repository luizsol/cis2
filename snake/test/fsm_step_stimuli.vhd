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
            cmp_flags_s     : in STD_LOGIC_VECTOR(1 downto 0);
            sync            : in BOOLEAN
        ) is
        begin
            if sync then
                wait until falling_edge(clk_s);
            end if;
            fsm_m_start     <= fsm_m_start_s;
            cmp_body_flag   <= cmp_body_flag_s;
            sys_direction   <= sys_direction_s;
            cmp_flags       <= cmp_flags_s;
            if sync then
                wait until falling_edge(clk_s);
            end if;
        end procedure set_fsm;

        procedure check_fsm_signals(
            ng_one_gen          : in STD_LOGIC;
            ng_pos_neg          : in STD_LOGIC;
            ng_one_three        : in STD_LOGIC;
            alu_x_y             : in STD_LOGIC;
            alu_pass_calc       : in STD_LOGIC;
            rb_head_en          : in STD_LOGIC;
            rb_reg2_en          : in STD_LOGIC;
            rb_fifo_en          : in STD_LOGIC;
            rb_fifo_pop         : in STD_LOGIC;
            rb_out_sel          : in RB_SEL;
            cg_sel              : in CODE;
            mem_w_e             : in STD_LOGIC;
            fsm_m_done_s        : in STD_LOGIC;
            fsm_m_game_over_s   : in STD_LOGIC;
            message             : in STRING(1 to 15);
            sync                : in BOOLEAN
        ) is
        begin
            if sync then
                wait until falling_edge(clk_s);
            end if;
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
            "00",   -- cmp_flags
            true    -- sync
        );

        wait until rising_edge(clk_s);

        -- Test 1 - when at the READY state, if fsm_m_start is 0 whe sould stay
        --  at the READY state

        set_fsm(
            '0',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_UP,   -- sys_direction
            "00",   -- cmp_flags
            true    -- sync
        );
        check_fsm_signals(  -- At the READY state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc
            '0',                -- rb_head_en
            '0',                -- rb_reg2_en -- PREVIOUS VALUE
            '0',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            BLANK,              -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 001",  -- message
            false               -- sync
        );

        set_fsm(
            '0',    -- fsm_m_start
            '1',    -- cmp_body_flag    -- CHANGE
            S_UP,   -- sys_direction
            "10",   -- cmp_flags        -- CHANGE
            true    -- sync
        );
        check_fsm_signals( -- At the READY state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc
            '0',                -- rb_head_en
            '0',                -- rb_reg2_en -- PREVIOUS VALUE
            '0',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            BLANK,              -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 002",  -- message
            false               -- sync
        );

        -- Test 2 - when at the READY state, if fsm_m_start is 1 the fsm should
        --  go to the NEW_POSITION state.

        set_fsm(
            '1',    -- fsm_m_start      -- CHANGE
            '0',    -- cmp_body_flag    -- CHANGE
            S_UP,   -- sys_direction
            "00",   -- cmp_flags        -- CHANGE
            true    -- sync
        );
        check_fsm_signals( -- At the NEW_POSITION state
            '0',                -- ng_one_gen
            '1',                -- ng_pos_neg       -- CHANGE
            '0',                -- ng_one_three
            '1',                -- alu_x_y          -- CHANGE
            '1',                -- alu_pass_calc    -- CHANGE
            '1',                -- rb_head_en       -- CHANGE
            '0',                -- rb_reg2_en
            '1',                -- rb_fifo_en       -- CHANGE
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            BLANK,              -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 003",  -- message
            false               -- sync
        );

        -- Test 3 - as this is a Mealy FSM, the value of the outputs at any
        --  given time depend on the current state and on the inputs, therefore
        --  if during the NEW_POSITION state whe change the value of the
        --  sys_direction output whe should see the value of both pos_neg and
        --  alu_x_y change.

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_DOWN, -- sys_direction    -- CHANGE
            "00",   -- cmp_flags
            false   -- sync
        );
        wait for 1 ps;
        check_fsm_signals( -- At the NEW_POSITION state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg       -- CHANGE
            '0',                -- ng_one_three
            '1',                -- alu_x_y
            '1',                -- alu_pass_calc
            '1',                -- rb_head_en
            '0',                -- rb_reg2_en
            '1',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            BLANK,              -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 004",  -- message
            false               -- sync
        );

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_LEFT, -- sys_direction    -- CHANGE
            "00",   -- cmp_flags
            false   -- sync
        );
        wait for 1 ps;
        check_fsm_signals( -- At the NEW_POSITION state
            '0',                -- ng_one_gen
            '1',                -- ng_pos_neg       -- CHANGE
            '0',                -- ng_one_three
            '0',                -- alu_x_y          -- CHANGE
            '1',                -- alu_pass_calc
            '1',                -- rb_head_en
            '0',                -- rb_reg2_en
            '1',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            BLANK,              -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 005",  -- message
            false               -- sync
        );

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_RIGHT,-- sys_direction    -- CHANGE
            "00",   -- cmp_flags
            false   -- sync
        );
        wait for 1 ps;
        check_fsm_signals( -- At the NEW_POSITION state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg       -- CHANGE
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '1',                -- alu_pass_calc
            '1',                -- rb_head_en
            '0',                -- rb_reg2_en
            '1',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            BLANK,              -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 006",  -- message
            false               -- sync
        );

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_UP,   -- sys_direction    -- CHANGE
            "00",   -- cmp_flags
            false   -- sync
        );
        wait for 1 ps;

        -- Test 3 - when at the NEW_POSITION state the fsm should go
        --  automatically to the CHECK state, and depending on the value of
        --  cmp_flags and sys_direction we should see differents outputs on
        -- fsm_m_game, fsm_m_done, and dp_ctrl.cg_sel

        check_fsm_signals( -- At the CHECK state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc    -- CHANGE
            '0',                -- rb_head_en       -- CHANGE
            '0',                -- rb_reg2_en
            '0',                -- rb_fifo_en       -- CHANGE
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            HEAD_UP,            -- cg_sel           -- CHANGE
            '1',                -- mem_w_e          -- CHANGE
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 007",  -- message
            true                -- sync
        );

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_RIGHT,-- sys_direction    -- CHANGE
            "10",   -- cmp_flags        -- CHANGE
            false   -- sync
        );
        wait for 1 ps;
        check_fsm_signals( -- At the CHECK state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc
            '0',                -- rb_head_en
            '0',                -- rb_reg2_en
            '0',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            HEAD_RIGHT,         -- cg_sel           -- CHANGE
            '1',                -- mem_w_e
            '1',                -- fsm_m_done       -- CHANGE
            '0',                -- fsm_m_game_over
            "Failed test 008",  -- message
            false                -- sync
        );

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_DOWN,-- sys_direction     -- CHANGE
            "01",   -- cmp_flags        -- CHANGE
            false   -- sync
        );
        wait for 1 ps;
        check_fsm_signals( -- At the CHECK state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc
            '0',                -- rb_head_en
            '0',                -- rb_reg2_en
            '0',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            HEAD_DOWN,          -- cg_sel           -- CHANGE
            '1',                -- mem_w_e
            '1',                -- fsm_m_done
            '1',                -- fsm_m_game_over  -- CHANGE
            "Failed test 009",  -- message
            false                -- sync
        );

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_LEFT, -- sys_direction    -- CHANGE
            "11",   -- cmp_flags        -- CHANGE
            false   -- sync
        );
        wait for 1 ps;
        check_fsm_signals( -- At the CHECK state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc
            '0',                -- rb_head_en
            '0',                -- rb_reg2_en
            '0',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            HEAD_LEFT,          -- cg_sel           -- CHANGE
            '1',                -- mem_w_e
            '1',                -- fsm_m_done
            '1',                -- fsm_m_game_over
            "Failed test 010",  -- message
            false                -- sync
        );

        set_fsm(
            '1',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_UP,   -- sys_direction    -- CHANGE
            "00",   -- cmp_flags        -- CHANGE
            false   -- sync
        );

        -- Test 4 - when at the CHECK state and if cmp_body_flag is 1 the fsm
        --  should go automatically to the POP_WRITE_TAIL state, and depending
        --  on the value of sys_direction and cmp_flags during the transition
        --  the values of both fsm_m_done and cg_sel will change.

        check_fsm_signals( -- At the POP_WRITE_TAIL state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc        -- CHANGE
            '0',                -- rb_head_en           -- CHANGE
            '0',                -- rb_reg2_en
            '0',                -- rb_fifo_en           -- CHANGE
            '1',                -- rb_fifo_pop          -- CHANGE
            FIFO_OUT,           -- rb_out_sel           -- CHANGE
            BLANK,              -- cg_sel
            '1',                -- mem_w_e              -- CHANGE
            '1',                -- fsm_m_done
            '0',                -- fsm_m_game_over      -- CHANGE
            "Failed test 011",  -- message
            true                -- sync
        );

        set_fsm(
            '0',    -- fsm_m_start
            '0',    -- cmp_body_flag
            S_LEFT, -- sys_direction
            "10",   -- cmp_flags
            false    -- sync
        );
        check_fsm_signals(  -- At the READY state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc
            '0',                -- rb_head_en
            '0',                -- rb_reg2_en -- PREVIOUS VALUE
            '0',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            BLANK,              -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 012",  -- message
            true                -- sync
        );

        -- Test 5 - Now we wil try to go from the CHECK state straight to the
        --  READY state.

        set_fsm( -- Now we will test another path
            '1',    -- fsm_m_start
            '1',    -- cmp_body_flag
            S_RIGHT,-- sys_direction
            "00",   -- cmp_flags
            false    -- sync
        );
        check_fsm_signals( -- At the NEW_POSITION state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '1',                -- alu_pass_calc    -- CHANGE
            '1',                -- rb_head_en       -- CHANGE
            '0',                -- rb_reg2_en
            '1',                -- rb_fifo_en       -- CHANGE
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            BLANK,              -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 006",  -- message
            true                -- sync
        );

        set_fsm( -- Now we will test another path
            '1',    -- fsm_m_start
            '1',    -- cmp_body_flag
            S_RIGHT,-- sys_direction
            "00",   -- cmp_flags
            false    -- sync
        );
        check_fsm_signals( -- At the CHECK state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc
            '0',                -- rb_head_en
            '0',                -- rb_reg2_en
            '0',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            HEAD_RIGHT,         -- cg_sel
            '1',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 010",  -- message
            true                -- sync
        );

        check_fsm_signals(  -- At the READY state
            '0',                -- ng_one_gen
            '0',                -- ng_pos_neg
            '0',                -- ng_one_three
            '0',                -- alu_x_y
            '0',                -- alu_pass_calc
            '0',                -- rb_head_en
            '0',                -- rb_reg2_en -- PREVIOUS VALUE
            '0',                -- rb_fifo_en
            '0',                -- rb_fifo_pop
            HEAD_OUT,           -- rb_out_sel
            HEAD_RIGHT,         -- cg_sel
            '0',                -- mem_w_e
            '0',                -- fsm_m_done
            '0',                -- fsm_m_game_over
            "Failed test 012",  -- message
            true                -- sync
        );


        wait;
    end process sim;
end architecture test;
