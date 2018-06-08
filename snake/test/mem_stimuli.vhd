library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_stimuli is
    generic (
        CLK_PERIOD  : TIME := 10ns
    );

    port (
        address_a   : out STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
        address_b   : out STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
        byteena_a   : out STD_LOGIC_VECTOR(0 DOWNTO 0) := (OTHERS => '1');
        clk         : out STD_LOGIC := '1';
        data_a      : out STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
        data_b      : out STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
        wren_a      : out STD_LOGIC := '0';
        wren_b      : out STD_LOGIC := '0';
        q_a         : in STD_LOGIC_VECTOR(7 DOWNTO 0);
        q_b         : in STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end mem_stimuli;

architecture test of mem_stimuli  is
    signal clk_s : STD_LOGIC;

    component clock
        generic (
            CLK_PERIOD  : TIME := 10ns
        );

        port (
            clk : out STD_LOGIC
        );
    end component ;

begin
    clk <= clk_s;

    clock_cmp : clock
        port map (
            clk => clk_s
        );

    sim : process
        procedure write_value(
            x_addr, y_addr  : STD_LOGIC_VECTOR(2 DOWNTO 0);
            data            : STD_LOGIC_VECTOR(7 DOWNTO 0)
        ) is
        begin
            wait until falling_edge(clk_s);
            address_a <= x_addr & y_addr;
            byteena_a <= "1";
            wren_a <= '1';
            data_a <= data;
            wait until falling_edge(clk_s);
            wren_a <= '0';
        end procedure write_value;

        procedure read_value(
            x_addr, y_addr  : STD_LOGIC_VECTOR(2 DOWNTO 0)
        ) is
        begin
            wait until falling_edge(clk_s);
            address_b <= x_addr & y_addr;
            wren_b <= '0';
            wait until falling_edge(clk_s);
        end procedure read_value;

    begin
        -- Apply test vectors

        write_value("010", "101", "01010101");
        wait for CLK_PERIOD;
        read_value("010", "101");
        wait for CLK_PERIOD;

        assert q_b = "01010101"  report "1st write or read failed";

        write_value("000", "011", "11111111");
        wait for CLK_PERIOD;
        read_value("000", "011");
        wait for CLK_PERIOD;

        assert q_b = "11111111"  report "2nd write or read failed";

        wait;
    end process sim;
end architecture test;
