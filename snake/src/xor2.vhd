--******************************************************************************
--*                                                                            *
--* Title   : xor2.vhd                                                         *
--* Design  :                                                                  *
--* Author  :                                                                  *
--* Email   :                                                                  *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY xor2 IS
    PORT(
        x : IN STD_LOGIC;
        y : IN STD_LOGIC;
        z : OUT STD_LOGIC
    );
END xor2;

ARCHITECTURE arch OF xor2 IS
BEGIN
    z <= x XOR y;
END arch;
