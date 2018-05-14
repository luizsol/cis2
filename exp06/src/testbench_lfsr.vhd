library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_lfsr is
    generic (
        WIDTH: natural := 12
    );
end tb_lfsr;

architecture test of tb_lfsr is

    component stimuli_module
        port (
            c: out STD_LOGIC;
            res  : out STD_LOGIC
        );
    end component ;

    component lfsr
        generic(
            WIDTH: natural := 12;
            POL  : STD_LOGIC_VECTOR (12 downto 0) := "1110011011011"
        );
        port (
            clk: in  STD_LOGIC;
            res: in  STD_LOGIC;
            o  : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component ;

    signal clk_s, res_s: STD_LOGIC;
    signal o_s: STD_LOGIC_VECTOR(7 downto 0);


begin
    -- Instantiate DUT
    dut : lfsr
        generic map(WIDTH => WIDTH)
        port map(
            clk => clk_s,
            res => res_s,
            o => o_s
        );

    -- Instantiate test module
    test : stimuli_module
        port map(
            c => clk_s,
            res => res_s
        );

end architecture test;
