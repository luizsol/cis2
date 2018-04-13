library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is

GENERIC (WIDTH: natural := 8);

end tb_alu;

architecture test of tb_alu is

component stimuli_module
  generic
  (
  WIDTH: natural := 8
  );

  port
  (
    op_first:       out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    rb_op:          out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    ctrl_x_y:       out STD_LOGIC;
    ctrl_pass_calc: out STD_LOGIC
  );
end component ;

component alu
  generic
  (
  WIDTH    : NATURAL  := 8
  );

  port
  (
  op_first:       in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  rb_op:          in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  ctrl_x_y:       in STD_LOGIC;
  ctrl_pass_calc: in STD_LOGIC;
  ofc_result:     out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
  );
end component ;

  signal op_first_i, rb_op_i, ofc_result_o: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  signal ctrl_x_y_i, ctrl_pass_calc_i : STD_LOGIC;

begin

-- Instantiate DUT
  dut : alu
    generic map(WIDTH => WIDTH)
    port map(
      op_first => op_first_i,
      rb_op => rb_op_i,
      ctrl_x_y => ctrl_x_y_i,
      ctrl_pass_calc => ctrl_pass_calc_i,
      ofc_result => ofc_result_o
    );

-- Instantiate test module
  test : stimuli_module
    generic map(WIDTH => WIDTH)
    port map(
      op_first => op_first_i,
      rb_op => rb_op_i,
      ctrl_x_y => ctrl_x_y_i,
      ctrl_pass_calc => ctrl_pass_calc_i
    );


end architecture test;
