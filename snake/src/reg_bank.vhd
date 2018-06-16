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


architecture process_if_else of reg_bank is

    signal head_out_s   : STD_LOGIC_VECTOR(WIDTH - 1 downto 0) := "11111111";
    signal reg2_out_s   : STD_LOGIC_VECTOR(WIDTH - 1 downto 0) := "00000000";
    signal fifo_out_s   : STD_LOGIC_VECTOR(WIDTH - 1 downto 0) := "01010101";

begin
    process (out_sel)
    begin
        if (out_sel = HEAD_OUT) then
            alu_out <=  head_out_s;
        elsif (out_sel = REG2_OUT ) then
            alu_out <=  reg2_out_s;
        elsif (out_sel = FIFO_OUT ) then
            alu_out   <=  fifo_out_s;
        end if;
    end process;

end process_if_else ;
