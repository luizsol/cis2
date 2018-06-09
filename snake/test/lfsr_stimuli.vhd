--******************************************************************************
--*                                                                            *
--* Title   : lfsr_stimuli.vhd                                                 *
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

entity lfsr_stimuli is
    generic (
        WIDTH       : NATURAL := 8;
        CLK_PERIOD  : TIME := 10ns
    );

    port (
        clk : out  STD_LOGIC;
        res : out  STD_LOGIC;
        o   : in STD_LOGIC_VECTOR(7 downto 0)
    );
end lfsr_stimuli;


architecture test of lfsr_stimuli  is
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
        procedure reset_activate is    -- reset activation procedure
        begin
            wait until falling_edge(clk_s);
            res <= '1';
            wait for 2 * CLK_PERIOD;
            res <= '0';
        end procedure reset_activate;

    begin
        -- Apply test vectors

        reset_activate;

        wait for CLK_PERIOD;

        assert o = "00010101"  report "1st iteration failed"; -- 21

        wait for CLK_PERIOD;

        assert o = "00110010"  report "2nd iteration failed"; -- 50

        wait for CLK_PERIOD;

        assert o = "01100100"  report "3rd iteration failed"; -- 100

        wait for CLK_PERIOD;

        assert o = "00100011"  report "4th iteration failed"; -- 35

        wait for CLK_PERIOD;

        assert o = "01010110"  report "5th iteration failed"; -- 86

        wait for CLK_PERIOD;

        assert o = "01010111"  report "6th iteration failed"; -- 87

        wait for CLK_PERIOD;

        assert o = "01010101"  report "7th iteration failed"; -- 85

        wait for CLK_PERIOD;

        assert o = "01000001"  report "8th iteration failed"; -- 65

        wait for CLK_PERIOD;

        assert o = "01110001"  report "9th iteration failed"; -- 113

        wait for CLK_PERIOD;

        assert o = "00000001"  report "10th iteration failed"; -- 1

        reset_activate;

        wait for CLK_PERIOD;

        assert o = "00010101"  report "Reset failed"; -- 21

        wait;
    end process sim;
end architecture test;
