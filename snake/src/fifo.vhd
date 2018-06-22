--******************************************************************************
--*                                                                            *
--* Title   : fifo.vhd                                                         *
--* Design  :                                                                  *
--* Author  :                                                                  *
--* Email   :                                                                  *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity fifo is
    generic (
        FIFO_DEPTH  : natural := 64;
        WIDTH       : natural := 8
    );

    port (
        clk     : in STD_LOGIC;
        data    : in STD_LOGIC_VECTOR(7 downto 0);
        rdreq   : in STD_LOGIC;
        sclr    : in STD_LOGIC;
        wrreq   : in STD_LOGIC;
        empty   : out STD_LOGIC;
        q       : out STD_LOGIC_VECTOR(7 downto 0)
    );
end fifo;

architecture arch of fifo is

begin

    fifo_proc : process (clk)
        type FIFO_Memory is array (0 to FIFO_DEPTH - 1)
            of STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
        variable Memory : FIFO_Memory;

        variable Head : natural range 0 to FIFO_DEPTH - 1;
        variable Tail : natural range 0 to FIFO_DEPTH - 1;

        variable Looped : boolean;
    begin
        if rising_edge(clk) then
            if sclr = '1' then
                Head := 0;
                Tail := 0;
                Looped := false;
                empty <= '1';
            else
                if (rdreq = '1') then
                    if ((Looped = true) or (Head /= Tail)) then
                        -- Update data output
                        q <= Memory(Tail);

                        -- Update Tail pointer as needed
                        if (Tail = FIFO_DEPTH - 1) then
                            Tail := 0;
                            Looped := false;
                        else
                            Tail := Tail + 1;
                        end if;
                    end if;
                end if;

                if (wrreq = '1') then
                    if ((Looped = false) or (Head /= Tail)) then
                        -- Write Data to Memory
                        Memory(Head) := data;
                        -- Increment Head pointer as needed
                        if (Head = FIFO_DEPTH - 1) then
                            Head := 0;
                            Looped := true;
                        else
                            Head := Head + 1;
                        end if;
                    end if;
                end if;

                -- Update empty and Full flags
                if (Head = Tail) then
                    empty <= '1';
                else
                    empty   <= '0';
                end if;
            end if;
        end if;
    end process;

end arch;



