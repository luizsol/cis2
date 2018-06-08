library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.snake_package.all;

entity button_handler_tb is
end button_handler_tb;

architecture test of button_handler_tb is
    component button_handler
        port (
            clk             : in STD_LOGIC;
            res             : in STD_LOGIC;
            load_regs       : in STD_LOGIC;
            sys_direction   : in STD_LOGIC_VECTOR(3 downto 0);
            sys_step_jumper : in STD_LOGIC;
            direction_sync  : out direction;
            step_jumper_sync: out STD_LOGIC
        );
    end component;

    component button_handler_stimuli is
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
    end component;

    signal clk_s, res_s, load_regs_s, sys_step_jumper_s,
        step_jumper_sync_s: STD_LOGIC;
    signal sys_direction_s: STD_LOGIC_VECTOR(3 downto 0);
    signal direction_sync_s: direction;

begin
    -- Instantiate DUT
    dut : button_handler
        port map (
            clk => clk_s,
            res => res_s,
            load_regs => load_regs_s,
            sys_direction => sys_direction_s,
            sys_step_jumper => sys_step_jumper_s,
            direction_sync => direction_sync_s,
            step_jumper_sync => step_jumper_sync_s
        );

    -- Instantiate stimuli generation module
    test : button_handler_stimuli
        port map (
            clk => clk_s,
            res => res_s,
            load_regs => load_regs_s,
            sys_direction => sys_direction_s,
            sys_step_jumper => sys_step_jumper_s,
            direction_sync => direction_sync_s,
            step_jumper_sync => step_jumper_sync_s
        );

end architecture test;
