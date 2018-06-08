--******************************************************************************
--*                                                                            *
--* Title   : lfsr.vhd                                                         *
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

entity lfsr is
    generic(
        WIDTH   : natural := 12;
        POL     : STD_LOGIC_VECTOR(12 downto 0) := "1110011011011"
    );

    port (
        clk : in  STD_LOGIC;
        res : in  STD_LOGIC;
        o   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end lfsr;

architecture arch of lfsr is
    COMPONENT xor2
        PORT (
            x, y: IN STD_LOGIC;
            z:    OUT STD_LOGIC
        );
    END COMPONENT;

    signal prev_state: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal next_state: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal or_signals: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

begin
    seq : process(clk)
    begin
        if clk'EVENT AND clk = '1' then
            prev_state <= next_state;
        end if;
    end process;

    layout: for I in 1 to (WIDTH - 1) generate
        zeros: if POL(I) = '0' generate
            next_state(I) <= prev_state(I - 1) or res;
        end generate zeros;
        ones: if POL(I) = '1' generate
            generated_xor2: xor2 port map (
                prev_state(I - 1),
                prev_state(WIDTH - 1),
                or_signals(I)
            );

            next_state(I) <= or_signals(I) or res;
        end generate ones;
    end generate layout;
    next_state(0) <= prev_state(WIDTH - 1) or res;

    o <= '0' & prev_state(WIDTH - 1 downto WIDTH - 3) & '0'
        & prev_state(2 downto 0);
end arch;
