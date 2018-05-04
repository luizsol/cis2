library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mem_1 is
end tb_mem_1;

architecture test of tb_mem_1 is

component stimuli_module
  port
  (
    address_a: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    address_b: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    byteena_a: IN STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '1');
    clock    : IN STD_LOGIC  := '1';
    data_a   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    data_b   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    wren_a   : IN STD_LOGIC  := '0';
    wren_b   : IN STD_LOGIC  := '0';
    q_a      : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    q_b      : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
  );
end component ;

component mem_1
  PORT
  (
    address_a: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    address_b: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    byteena_a: IN STD_LOGIC_VECTOR (0 DOWNTO 0) :=  (OTHERS => '1');
    clock    : IN STD_LOGIC  := '1';
    data_a   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    data_b   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    wren_a   : IN STD_LOGIC  := '0';
    wren_b   : IN STD_LOGIC  := '0';
    q_a      : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    q_b      : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
  );
end component ;

  signal address_a_s: STD_LOGIC_VECTOR (5 DOWNTO 0);
  signal address_b_s: STD_LOGIC_VECTOR (5 DOWNTO 0);
  signal byteena_a_s: STD_LOGIC_VECTOR (0 DOWNTO 0);
  signal clock_s    : STD_LOGIC;
  signal data_a_s   : STD_LOGIC_VECTOR (7 DOWNTO 0);
  signal data_b_s   : STD_LOGIC_VECTOR (7 DOWNTO 0);
  signal wren_a_s   : STD_LOGIC;
  signal wren_b_s   : STD_LOGIC;
  signal q_a_s      : STD_LOGIC_VECTOR (7 DOWNTO 0);
  signal q_b_s      : STD_LOGIC_VECTOR (7 DOWNTO 0);

begin

-- Instantiate DUT
  dut : mem_1
    port map(
      address_a => address_a_s,
      address_b => address_b_s,
      byteena_a => byteena_a_s,
      clock => clock_s,
      data_a => data_a_s,
      data_b => data_b_s,
      wren_a => wren_a_s,
      wren_b => wren_b_s,
      q_a => q_a_s,
      q_b => q_b_s
    );

-- Instantiate test module
  test : stimuli_module
    port map(
      address_a => address_a_s,
      address_b => address_b_s,
      byteena_a => byteena_a_s,
      clock => clock_s,
      data_a => data_a_s,
      data_b => data_b_s,
      wren_a => wren_a_s,
      wren_b => wren_b_s
    );

end architecture test;
