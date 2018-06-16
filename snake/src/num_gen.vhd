--******************************************************************************
--*                                                                            *
--* Title   : num_gen.vhd                                                      *
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

entity num_gen is
    generic (
        WIDTH  : natural := 8
    );

    port (
        clk         : in  STD_LOGIC;
        res         : in  STD_LOGIC;
        pos_neg     : in  STD_LOGIC;
        one_three   : in  STD_LOGIC;
        one_num_gen : in  STD_LOGIC;
        number      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
    );
end num_gen;


architecture arch of num_gen is

    signal pos_neg_s    : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal one_three_s  : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal one_gen_s    : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal res_s        : STD_LOGIC;
    signal clk_s        : STD_LOGIC;
    signal random_num_s : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

    component lfsr is
        generic(
            WIDTH   : natural := 12;
            POL     : STD_LOGIC_VECTOR(12 downto 0) := "1110011011011"
        );

        port (
            clk : in  STD_LOGIC;
            res : in  STD_LOGIC;
            o   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin
    clk_s <= clk;
    res_s <= res;

    lfsr_c: lfsr
        port map (
            clk => clk_s,
            res => res_s,
            o   => random_num_s
        );

    upd: process (clk, res, pos_neg, one_three, one_num_gen)
    begin
        if (one_num_gen = '1') then
            number <= random_num_s;
        else
            if (pos_neg = '0') then
                if (one_three = '0') then
                    number <= STD_LOGIC_VECTOR(TO_UNSIGNED(1, WIDTH));
                else
                    number <= STD_LOGIC_VECTOR(TO_UNSIGNED(3, WIDTH));
                end if;
            else
                if (one_three = '0') then
                    number <= STD_LOGIC_VECTOR(TO_SIGNED(-1, WIDTH));
                else
                    number <= STD_LOGIC_VECTOR(TO_SIGNED(-3, WIDTH));
                end if;
            end if;
        end if;
    end process;

END arch;
