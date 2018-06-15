--***************************************************************
--*																*
--*	Title	:													*
--*	Design	:													*
--*	Author	:													*
--*	Email	:													*
--*																*
--***************************************************************
--*																*
--*	Description :												*
--*																*
--***************************************************************
library IEEE;
use IEEE.std_logic_1164.all;


entity overflow_correction is 
	generic
	(
	WIDTH		: NATURAL	:= 8
	);

	port
	(
	alu_result		: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	rb_result		: out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	ctrl_of_x		: out STD_LOGIC;
	ctrl_of_y		: out STD_LOGIC
	);
end overflow_correction;


architecture arch of overflow_correction is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************

--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************

begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	ctrl_of_x <= alu_result(WIDTH/2 - 1);
	ctrl_of_y <= alu_result(WIDTH - 1);
	rb_result <= '0' & alu_result(WIDTH-2 downto WIDTH/2) & '0' & alu_result(WIDTH/2-2 downto 0);
	
	
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
	
end arch;
