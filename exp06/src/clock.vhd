library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity clock is
    port (
        clk: out  STD_LOGIC
    );
end clock;

architecture arch of clock is
    constant CLOCK_PERIOD: time := 10 ns;
begin
    clk_generation: process
    begin
        clk <= '1';
        wait FOR CLOCK_PERIOD / 2;
        clk <= '0';
        wait FOR CLOCK_PERIOD / 2;

    end process clk_generation;

end architecture arch;
