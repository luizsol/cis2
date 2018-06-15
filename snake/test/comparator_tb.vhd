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
            mem_a_read  : in STD_LOGIC_VECTOR(7 downto 0);
            food_flag   : out STD_LOGIC;
            body_flag   : out STD_LOGIC
        );
    end component;

    component comparator_stimuli is
        port (
            mem_a_read  : out STD_LOGIC_VECTOR(7 downto 0);
            food_flag   : in  STD_LOGIC;
            body_flag   : in  STD_LOGIC
        );
    end component;

    signal food_flag_s, body_flag_s: STD_LOGIC;
    signal mem_a_read_s: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
    -- Instantiate DUT
    dut : comparator
        port map (
            mem_a_read  => mem_a_read_s,
            food_flag   => food_flag_s,
            body_flag   => body_flag_s
        );

    -- Instantiate stimuli generation module
    test : comparator_stimuli
        port map (
            mem_a_read  => mem_a_read_s,
            food_flag   => food_flag_s,
            body_flag   => body_flag_s
        );

end architecture test;
