library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stimuli_module is
    port (
        c: out STD_LOGIC;
        res  : out STD_LOGIC
    );
end stimuli_module ;

architecture test of stimuli_module  is
-- "Time" that will elapse between test vectors we submit to the component.
constant TIME_DELTA : time := 10 ns;      -- choose any value

    component clock
        port (
            clk: out STD_LOGIC
        );
    end component ;

begin
    clock_component : clock
        port map(
            clk => c
        );

    simulation : process
        procedure assign_reset (filler: in STD_LOGIC) is
        begin
        -- Assign values to estimuli_module´s outputs.
            res <= '1';
            wait for 2 * TIME_DELTA;
            res <= '0';
        end procedure assign_reset;

        begin
            -- test vectors application
            wait for 15 * TIME_DELTA;
            assign_reset('1');
            wait for 20 * TIME_DELTA;
            assign_reset('1');
            wait for 25 * TIME_DELTA;
            -- wait;
    end process simulation;
end architecture test;
