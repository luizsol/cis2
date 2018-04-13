library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stimuli_module is
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

end stimuli_module;

architecture test of stimuli_module  is
-- "Time" that will elapse between test vectors we submit to the component.
constant TIME_DELTA : time := 40 ns;      -- choose any value

begin

simulation : process

-- procedure for vector generation

procedure assign_input_words (constant a, b: in integer) is
begin
-- Assign values to estimuli_module´s outputs.
op_first <= std_logic_vector(to_unsigned(a, WIDTH));
rb_op <= std_logic_vector(to_unsigned(b, WIDTH));

wait for TIME_DELTA;
end procedure assign_input_words;


procedure assign_ctrl_x_y (constant a: in STD_LOGIC) is
begin
-- Assign values to estimuli_module´s outputs.
ctrl_x_y <= a;

-- wait for TIME_DELTA;
end procedure assign_ctrl_x_y;

procedure assign_ctrl_pass_calc (constant a: in STD_LOGIC) is
begin
-- Assign values to estimuli_module´s outputs.
ctrl_pass_calc <= a;

-- wait for TIME_DELTA;
end procedure assign_ctrl_pass_calc;

begin

-- test vectors application

assign_ctrl_x_y('0');
assign_ctrl_pass_calc('0');
assign_input_words(0, 0);

assign_ctrl_x_y('0');
assign_ctrl_pass_calc('1');
assign_input_words(0, 0);

assign_ctrl_x_y('1');
assign_ctrl_pass_calc('0');
assign_input_words(0, 0);

assign_ctrl_x_y('1');
assign_ctrl_pass_calc('1');
assign_input_words(0, 0);

assign_ctrl_x_y('0');
assign_ctrl_pass_calc('0');
assign_input_words(12, 27);

assign_ctrl_x_y('0');
assign_ctrl_pass_calc('1');
assign_input_words(12, 27);

assign_ctrl_x_y('1');
assign_ctrl_pass_calc('0');
assign_input_words(12, 27);

assign_ctrl_x_y('1');
assign_ctrl_pass_calc('1');
assign_input_words(12, 27);


wait;
end process simulation;
end architecture test;
