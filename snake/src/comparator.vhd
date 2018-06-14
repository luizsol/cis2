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
        value   : in  STD_LOGIC_VECTOR(7 downto 0);
        is_food : out STD_LOGIC := '0';
        is_body : out STD_LOGIC := '0'
    );
end comparator;

architecture arch of comparator is
begin
    is_food <= value(7);
    is_body <= value(4);

end arch;
