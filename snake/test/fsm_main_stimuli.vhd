library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.my_package.all;

entity fsm_main_stimuli is
    generic (
        WIDTH       : NATURAL := 8;
        CLK_PERIOD  : TIME := 10ns
    );

    port (
        clk             : out STD_LOGIC;     --from system
        res             : out STD_LOGIC;     --from system
        cnt_rdy         : out STD_LOGIC;     --from system
        cmp_food_flag   : out STD_LOGIC;     --from datapath/comparator module
        fsm_i_done      : out STD_LOGIC;     --from fsm_init
        fsm_f_done      : out STD_LOGIC;     --from fsm_food_spawn
        fsm_s_done      : out STD_LOGIC;     --from fsm_step
        fsm_s_game_over : out STD_LOGIC;      --from fsm_step
        con_sel         : in CONTROL_SELECT; --to internal
        fsm_i_start     : in STD_LOGIC;      --to fsm_init
        fsm_f_start     : in STD_LOGIC;      --to fsm_food
        fsm_s_start     : in STD_LOGIC       --to fsm_start
    );

end fsm_main_stimuli ;

architecture test of fsm_main_stimuli  is
    signal clk_s : STD_LOGIC;

    component clock
        generic (
            CLK_PERIOD  : TIME := 10ns
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
        procedure check_fsm(fsm_i_done_value, fsm_f_done_value,
            fsm_s_done_value, fsm_s_game_over_value, cmp_food_flag_value,
            cnt_rdy_value : in STD_LOGIC) is
        begin
            -- Assign values to estimuli_module´s outputs.
            fsm_i_done <= fsm_i_done_value;
            fsm_f_done <= fsm_f_done_value;
            fsm_s_done <= fsm_s_done_value;
            fsm_s_game_over <= fsm_s_game_over_value;
            cmp_food_flag <= cmp_food_flag_value;
            cnt_rdy <= cnt_rdy_value;

            wait until rising_edge (clk_s);
            -- Events at the rising edge of next clock cycle
            end procedure check_fsm;

        procedure reset_activate is    -- reset activation procedure
        begin
            wait until falling_edge(CLK_s);
            res <= '1';
            wait for CLK_PERIOD;
            res <= '0';
        end procedure reset_activate;

    begin
        -- Apply test vectors

        check_fsm('0', '0', '0', '0', '0', '0');    -- analyze state transitions
        reset_activate;

    -- **initialization state** protocol

        while (fsm_i_start /= '1')
            loop
            check_fsm('0', '0', '0', '0', '0', '0');    -- guaranteeing fsm_i_done='0'
        end loop;

        -- 25 ns

        -- emulate some action

        wait for 50*CLK_PERIOD;

        -- 525 ns

        -- forcing fsm_i_done='1'

        check_fsm('1', '0', '0', '0', '0', '0');     -- forcing fsm_i_done='1' and fsm_f_done='0'

        wait for CLK_PERIOD;

        -- 540 ns

    -- **food state** protocol

        while (fsm_f_start /= '1')
            loop
            check_fsm('1', '0', '0', '0', '0', '0');  -- maintaining fsm_i_done='1' and fsm_f_done='0'
        end loop;

        -- FOOD_ACTIVATION

        -- 540 ns

        -- emulate some action

        wait for 50*CLK_PERIOD;

        check_fsm('0', '1', '0', '0', '0', '0');    -- forcing fsm_f_done='1' and fsm_s_done='0'

        wait for CLK_PERIOD;

        -- 1050 ns

    -- **step state** protocol


        while (fsm_f_start /= '0')
            loop
            check_fsm('0', '1', '0', '0', '0', '0');  -- maintaining fsm_f_done='1' and fsm_s_done='0'
        end loop;

        -- IDLE

        check_fsm('0', '0', '0', '0', '0', '0');

        wait for 50*CLK_PERIOD;

        while (fsm_s_start /= '1')
            loop
            check_fsm('0', '0', '0', '0', '0', '1');  -- maintaining fsm_f_done='1' and fsm_s_done='0'
        end loop;

        -- STEP ACTIVATION

        wait for 50*CLK_PERIOD;

        while (fsm_s_start /= '0')
            loop
            check_fsm('0', '0', '0', '1', '0', '0');
        end loop;

        wait;
    end process sim;
end architecture test;
