--******************************************************************************
--*                                                                            *
--* Title   : reg_bank.vhd                                                     *
--* Design  :                                                                  *
--* Author  :                                                                  *
--* Email   :                                                                  *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

-- TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
-- Add flags and constants
-- Create tests

library IEEE;
use IEEE.std_logic_1164.all;

use work.snake_package.all;

entity reg_bank is
    generic (
        WIDTH : NATURAL := 8
    );

    port (
        clk         : in  STD_LOGIC;
        res         : in  STD_LOGIC;
        ofc_address : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        load_head   : in  STD_LOGIC;
        load_reg2   : in  STD_LOGIC;
        load_fifo   : in  STD_LOGIC;
        fifo_pop    : in  STD_LOGIC;
        out_sel     : in  RB_SEL;
        alu_out     : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
    );
end reg_bank;


architecture arch of reg_bank is

    signal head_out_s   : STD_LOGIC_VECTOR(WIDTH - 1 downto 0) := "11111111";
    signal reg2_out_s   : STD_LOGIC_VECTOR(WIDTH - 1 downto 0) := "00000000";
    signal fifo_out_s   : STD_LOGIC_VECTOR(WIDTH - 1 downto 0) := "01010101";
    signal fifo_empty	: STD_LOGIC;

    component fifo is
        generic (
            FIFO_DEPTH  : natural := 64;
            WIDTH       : natural := 8
        );

        port (
            clk     : in STD_LOGIC := '0';
            data    : in STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
            rdreq   : in STD_LOGIC := '0';
            res     : in STD_LOGIC := '0';
            wrreq   : in STD_LOGIC := '0';
            empty   : out STD_LOGIC;
            q       : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component reg is
        generic (
            WIDTH : natural := 8
        );

        port (
            clk : in  STD_LOGIC := '0';
            clr : in  STD_LOGIC := '0';
            load: in  STD_LOGIC := '0';
            d   : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0) := (others => '0');
            q   : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

begin
    fifo_cmp : fifo
        generic map (
            FIFO_DEPTH  => 64,
            WIDTH       => WIDTH
        )
        port map (clk, ofc_address, fifo_pop, res, load_fifo, fifo_empty,
                  fifo_out_s);
    head_cmp : reg
        generic map (
            WIDTH => WIDTH
        )
        port map (clk, res, load_head, ofc_address, head_out_s);
    reg2_cmp : reg
        generic map (
            WIDTH => WIDTH
        )
        port map (clk, res, load_reg2, ofc_address, reg2_out_s);

    process (out_sel, clk)
    begin
        if (out_sel = HEAD_OUT) then
            alu_out <= head_out_s;
        elsif (out_sel = REG2_OUT) then
            alu_out <= reg2_out_s;
        elsif (out_sel = FIFO_OUT) then
            alu_out <= fifo_out_s;
        end if;
    end process;

end arch;
