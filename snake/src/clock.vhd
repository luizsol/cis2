--******************************************************************************
--*                                                                            *
--* Title   : clock.vhd                                                        *
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
use IEEE.NUMERIC_STD.all;

entity clock is
    generic (
        CLK_PERIOD: TIME := 10 ns
    );

    port (
        clk: out STD_LOGIC
    );
end clock;

architecture arch of clock is
begin
    clk_generation: process
    begin
        clk <= '1';
        wait FOR CLK_PERIOD / 2;
        clk <= '0';
        wait FOR CLK_PERIOD / 2;

    end process clk_generation;

end architecture arch;
