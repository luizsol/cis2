--******************************************************************************
--*                                                                            *
--* Title   : comparator_tb.vhd                                                *
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

entity comparator_tb is
end comparator_tb;

architecture test of comparator_tb is
    component comparator
        port (
            value   : in  STD_LOGIC_VECTOR(7 downto 0);
            is_food : out STD_LOGIC := '0';
            is_body : out STD_LOGIC := '0'
        );
    end component;

    component comparator_stimuli is
        port (
            value   : out STD_LOGIC_VECTOR(7 downto 0);
            is_food : in  STD_LOGIC := '0';
            is_body : in  STD_LOGIC := '0'
        );
    end component;

    signal is_food_s, is_body_s: STD_LOGIC;
    signal value_s: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
    -- Instantiate DUT
    dut : comparator
        port map (
            value   => value_s,
            is_food => is_food_s,
            is_body => is_body_s
        );

    -- Instantiate stimuli generation module
    test : comparator_stimuli
        port map (
            value   => value_s,
            is_food => is_food_s,
            is_body => is_body_s
        );

end architecture test;
