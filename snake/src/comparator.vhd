--******************************************************************************
--*                                                                            *
--* Title   : comparator.vhd                                                   *
--* Design  :                                                                  *
--* Author  : Luiz Sol                                                         *
--* Email   : luizedusol@gmail.com                                             *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

library IEEE;
use IEEE.std_logic_1164.all;

use work.snake_package.all;

entity comparator is
    port (
        mem_a_read  : in STD_LOGIC_VECTOR(7 downto 0);
        food_flag   : out STD_LOGIC;
        body_flag   : out STD_LOGIC
    );
end comparator;

architecture arch of comparator is
begin
    food_flag <= mem_a_read(7);
    body_flag  <= mem_a_read(4);

end arch;
