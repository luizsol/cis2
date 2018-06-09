--******************************************************************************
--*                                                                            *
--* Title   : rc_adder_tb.vhd                                                  *
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

entity rc_adder_tb is
    generic (
        WIDTH  : natural := 16
    );
end rc_adder_tb;

architecture test of rc_adder_tb is
    component rc_adder
        generic (
            WIDTH : integer
        );

        port (
            a_i : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            b_i : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            c_i : in STD_LOGIC;
            z_o : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            c_o : out STD_LOGIC
        );
    end component;

    component rc_adder_stimuli is
        generic (
            WIDTH : integer
        );

        port (
            a_i : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            b_i : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            c_i : out STD_LOGIC;
            z_o : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            c_o : in STD_LOGIC
        );
    end component;

    signal a_i_s, b_i_s, z_o_s: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal c_i_s, c_o_s: STD_LOGIC;

begin
    -- Instantiate DUT
    dut : rc_adder
        generic map (
            WIDTH => WIDTH
        )

        port map (
            a_i => a_i_s,
            b_i => b_i_s,
            c_i => c_i_s,
            z_o => z_o_s,
            c_o => c_o_s
        );

    -- Instantiate stimuli generation module
    test : rc_adder_stimuli
        generic map (
            WIDTH => WIDTH
        )

        port map (
            a_i => a_i_s,
            b_i => b_i_s,
            c_i => c_i_s,
            z_o => z_o_s,
            c_o => c_o_s
        );

end architecture test;
