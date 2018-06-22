--******************************************************************************
--*                                                                            *
--* Title   : step_counter.vhd                                                 *
--* Design  : snake_hw                                                         *
--* Author  : Frederik Luehrs                                                  *
--* Email   : luehrs.fred@gmail.com                                            *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity step_counter is
    generic (
        COUNT_MAX   : positive := 10
    );

    port (
        clk         : in  STD_LOGIC;
        res         : in  STD_LOGIC;
        cnt_rdy     : out STD_LOGIC;
        cnt_value	: out STD_LOGIC_VECTOR(3 downto 0)
    );
end step_counter;

architecture arch of step_counter is

    signal cnt_s : UNSIGNED(3 downto 0) := to_unsigned(0, 4);

begin
    cnt_rdy <= '1' when (cnt_s = COUNT_MAX)
                   else
                      '0';

    --increment counter each cycle, reset if max reached or clr is set
    process(clk, res)
    begin
        if clk'event and clk = '1' then
            if (res = '1') then
                cnt_s <= to_unsigned(0, cnt_s'length);
            elsif (cnt_s = COUNT_MAX) then
                cnt_s <= to_unsigned(0, cnt_s'length);
            else
                cnt_s <= cnt_s + 1;
            end if;
        end if;
    end process;

    cnt_value <= STD_LOGIC_VECTOR(cnt_s);
end arch;
