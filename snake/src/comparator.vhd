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
        dp_flags: out datapath_flags
    );
end comparator;

architecture arch of comparator is
begin
    dp_flags.cmp_food_flag  <= value(7);
    dp_flags.cmp_body_flag  <= value(4);

end arch;
