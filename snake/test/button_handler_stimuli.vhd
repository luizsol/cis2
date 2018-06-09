--******************************************************************************
--*                                                                            *
--* Title   : button_handler_stimuli.vhd                                       *
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

entity button_handler_stimuli is
    generic (
        CLK_PERIOD  : TIME := 10ns
    );

    port (
        clk             : out STD_LOGIC;
        res             : out STD_LOGIC;
        load_regs       : out STD_LOGIC;
        sys_direction   : out STD_LOGIC_VECTOR(3 downto 0);
        sys_step_jumper : out STD_LOGIC;
        direction_sync  : in direction;
        step_jumper_sync: in STD_LOGIC
    );
end button_handler_stimuli;

architecture test of button_handler_stimuli  is
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
        procedure set_direction(direction : in direction) is
        begin
            case direction is
                when S_RIGHT => sys_direction <= "0001";
                when S_LEFT => sys_direction <= "0010";
                when S_UP => sys_direction <= "0100";
                when S_DOWN => sys_direction <= "1000";
                when others => null ;
            end case;
        end procedure set_direction;

        procedure set_sys_step_jumper(sys_step_jumper_s: in STD_LOGIC) is
        begin
            load_regs <= '1';
            sys_step_jumper <= sys_step_jumper_s;
            wait until rising_edge(clk_s);
            wait until falling_edge(clk_s);
            load_regs <= '0';
        end procedure set_sys_step_jumper;

        procedure send_direction is
        begin
            load_regs <= '1';
            wait until rising_edge(clk_s);
            wait until falling_edge(clk_s);
            load_regs <= '0';
            wait for CLK_PERIOD;
        end procedure send_direction;

        procedure reset_activate is    -- reset activation procedure
        begin
            wait until falling_edge(clk_s);
            res <= '1';
            wait for CLK_PERIOD;
            res <= '0';
        end procedure reset_activate;

    begin
        -- > Behaviours to be tested:
        -- 1) When reset is pressed the direction must be S_RIGHT
        -- 2) Setting and syncyng the direction yields the correct result
        -- 3) Choosing two different directions before syncing will send only
        --    the last one
        -- 4) Choosing a direction backwards to the current one doesn't alter
        --    the direction output
        -- 5) step_jumper_sync must always be equal to sys_step_jumper when
        --    load_regs <= '1'

         -- Start behaviour test 1:
        reset_activate;

        assert direction_sync = S_RIGHT report
            "Test 1: RIGHT direction when reset was not set properlly";

        -- Start behaviour test 2:
        reset_activate;
        set_direction(S_UP);
        send_direction;

        assert direction_sync = S_UP report
            "Test 2: UP direction was not set properlly";

        set_direction(S_LEFT);
        send_direction;

        assert direction_sync = S_LEFT report
            "Test 2: LEFT direction was not set properlly";

        set_direction(S_DOWN);
        send_direction;

        assert direction_sync = S_DOWN report
            "Test 2: DOWN direction was not set properlly";

        set_direction(S_RIGHT);
        send_direction;

        assert direction_sync = S_RIGHT report
            "Test 2: RIGHT direction was not set properlly";

        -- Start behaviour test 3:
        reset_activate;
        set_direction(S_UP);
        set_direction(S_DOWN);
        send_direction;

        assert direction_sync = S_DOWN report
            "Test 3: DOWN direction was not set properlly";

        set_direction(S_DOWN);
        set_direction(S_RIGHT);
        send_direction;

        assert direction_sync = S_RIGHT report
            "Test 3: RIGHT direction was not set properlly";


        -- Start behaviour test 4:
        reset_activate;
        set_direction(S_LEFT);
        send_direction;

        assert direction_sync = S_RIGHT report
            "Test 4: RIGHT direction was not set properlly";

        set_direction(S_DOWN);
        send_direction;
        set_direction(S_UP);
        send_direction;

        assert direction_sync = S_DOWN report
            "Test 4: DOWN direction was not set properlly";

        set_direction(S_LEFT);
        send_direction;
        set_direction(S_RIGHT);
        send_direction;

        assert direction_sync = S_LEFT report
            "Test 4: LEFT direction was not set properlly";

        set_direction(S_UP);
        send_direction;
        set_direction(S_DOWN);
        send_direction;

        assert direction_sync = S_UP report
            "Test 4: UP direction was not set properlly";

        -- Start behaviour test 5:

        set_sys_step_jumper('1');
        wait for CLK_PERIOD;
        assert step_jumper_sync = '1' report
            "Test 5: step_jumper_sync 1 value was not set properlly";

        set_sys_step_jumper('0');
        wait for CLK_PERIOD;
        assert step_jumper_sync = '0' report
            "Test 5: step_jumper_sync 0 value was not set properlly";

        wait;
    end process sim;
end architecture test;
