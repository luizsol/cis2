library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stimuli_module is
	generic
	(
	WIDTH	: natural := 6
	);

	port
	(
	pos_neg			: out STD_LOGIC;
	one_three			: out STD_LOGIC;
	one_num_gen		: out STD_LOGIC;
	number			: in STD_LOGIC_VECTOR (WIDTH-1 downto 0)
	);

end stimuli_module ;

architecture test of stimuli_module  is
-- "Time" that will elapse between test vectors we submit to the component.
constant TIME_DELTA : time := 100 ns;

signal 	pos_neg_s		:  STD_LOGIC_VECTOR (0 downto 0);
signal 	one_three_s	:  STD_LOGIC_VECTOR (0 downto 0);



begin

pos_neg <= pos_neg_s(0);
one_three <= one_three_s (0);

simulation : process

-- procedure for vector generation

procedure check_num_gen(constant a, b: in INTEGER; c : in STD_LOGIC) is
begin
-- Assign values to estimuli_module´s outputs.
pos_neg_s <= std_logic_vector(to_unsigned(a,1));
one_three_s <= std_logic_vector(to_unsigned(b,1));
one_num_gen <= c;


wait for TIME_DELTA;
end procedure check_num_gen;

begin

-- test vectors application

check_num_gen(0, 0, '0');
check_num_gen(0, 1, '0');
check_num_gen(1, 0, '0');
check_num_gen(1, 1, '0');
check_num_gen(0, 0, '1');
check_num_gen(0, 1, '1');
check_num_gen(1, 0, '1');
check_num_gen(1, 1, '1');

wait;
end process simulation;
end architecture test;
