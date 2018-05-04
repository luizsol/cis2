library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stimuli_module is
  port
  (
    address_a: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
    address_b: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
    byteena_a: OUT STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '1');
    clock    : OUT STD_LOGIC  := '1';
    data_a   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    data_b   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    wren_a   : OUT STD_LOGIC  := '0';
    wren_b   : OUT STD_LOGIC  := '0'
  );
end stimuli_module ;

architecture test of stimuli_module  is
  -- "Time" that will elapse between test vectors we submit to the component.
  constant TIME_DELTA  : time := 60 ns;
  constant CLOCK_PERIOD: time := 10 ns;

  begin simulation : process
    -- procedure for writing to memory
    procedure mem_write(
      a_write  : IN STD_LOGIC ;
      a_address: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
      a_data   : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      b_write  : IN STD_LOGIC;
      b_address: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
      b_data   : IN STD_LOGIC_VECTOR (7 DOWNTO 0)
    ) is
    begin
      -- Assign values to estimuli_module´s outputs.
      if a_write = '1' then
        wren_a    <= '1';
        address_a <= a_address;
        data_a    <= a_data;
      end if;

      if b_write = '1' then
        wren_b    <= '1';
        address_b <= a_address;
        data_b    <= b_data;
      end if;

      WAIT FOR TIME_DELTA;

      wren_a    <= '0';
      wren_b    <= '0';
    end procedure mem_write;

    -- procedure for reading from memory
    procedure mem_read(
      a_read   : IN STD_LOGIC ;
      a_address: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
      b_read   : IN STD_LOGIC;
      b_address: IN STD_LOGIC_VECTOR (5 DOWNTO 0)
    ) is
    begin
      -- Assign values to estimuli_module´s outputs.
      if a_read = '1' then
        wren_a    <= '0';
        address_a <= a_address;
      end if;

      if b_read = '1' then
        wren_b    <= '0';
        address_b <= b_address;
      end if;

      WAIT FOR TIME_DELTA;
    end procedure mem_read;

  begin
    -- test vectors application

    for I in 0 to 63 loop
      mem_write(
        '1',
        std_logic_vector(to_unsigned(I, 6)),
        std_logic_vector(to_unsigned(I, 8)),
        '0',
        std_logic_vector(to_unsigned(I, 6)),
        std_logic_vector(to_unsigned(I, 8))
      );
    end loop;

    for I in 0 to 63 loop
      mem_read(
        '0',
        std_logic_vector(to_unsigned(I, 6)),
        '1',
        std_logic_vector(to_unsigned(I, 6))
      );
    end loop;

    wait;
  end process simulation;

  clk_generation: process
    begin
      clock <= '1';
      wait FOR CLOCK_PERIOD / 2;
      clock <= '0';
      wait FOR CLOCK_PERIOD / 2;

  end process clk_generation;

end architecture test;
