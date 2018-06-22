--******************************************************************************
--*                                                                            *
--* Title   : address_counter.vhd                                              *
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity address_counter is
    generic (
        WIDTH : natural := 6
    );

    port (
        clk      : in  STD_LOGIC;
        res      : in  STD_LOGIC;
        addr     : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        cnt_done : out STD_LOGIC
    );
end address_counter;

architecture arch of address_counter is

    signal temp : UNSIGNED(WIDTH - 1 downto 0) := to_unsigned(0, WIDTH);

begin

    addr <= STD_LOGIC_VECTOR(temp);

    process(clk)
    begin
        if clk'event and clk = '1' then
            if (res = '1') then
                temp        <= to_unsigned(0, WIDTH);
                cnt_done    <= '0';
            elsif (temp = 63) then
                cnt_done    <= '1';
            else
                temp <= temp + 1;
            end if;
        end if;
    end process;

end arch;
