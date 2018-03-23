LIBRARY IEEE;
-- USE IEEE.std_logic_1164.all; Comentário solicitado no exercício
USE IEEE.numeric_std.all;


ENTITY num_gen_direct IS
    GENERIC
    (
    WIDTH  : natural := 6
    );

    PORT
    (
    pos_neg     : IN STD_LOGIC;
    one_three   : IN STD_LOGIC;
    one_num_gen : IN STD_LOGIC;
    number      : OUT STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0)
    );
END num_gen_direct;


ARCHITECTURE arch OF num_gen_direct IS
--***********************************
--* INTERNAL SIGNAL DECLARATIONS    *
--***********************************
SIGNAL pos_neg_s      : STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0);
SIGNAL one_three_s    : STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0);
SIGNAL one_gen_s      : STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0);
SIGNAL rand_num_direct: UNSIGNED (WIDTH - 1 DOWNTO 0);

BEGIN
    --*******************************
    --*    SIGNAL ASSIGNMENTS        *
    --*******************************

    rand_num_direct <= (to_unsigned(45, number'length));
    --  Meu numero usp, em decimal, eh 8586861
    --  Meu numero usp mod 64, em decimal eh 45

    pos_neg_s <= std_logic_vector (to_unsigned(1, pos_neg_s'length))
                 WHEN (pos_neg = '0')
                 ELSE
                     std_logic_vector (to_signed(-1, pos_neg_s'length))
                     WHEN (pos_neg = '1')
                     ELSE
                         (OTHERS => 'X' );

    one_three_s <= pos_neg_s
                   WHEN (one_three = '0')
                   ELSE
                       pos_neg_s(WIDTH - 1 DOWNTO 2) & (NOT pos_neg_s(1))
                           & pos_neg_s(0)
                       WHEN (one_three = '1')
                       ELSE
                           (OTHERS => 'X' );

    one_gen_s <= one_three_s
                 WHEN (one_num_gen = '0')
                 ELSE
                     std_logic_vector (rand_num_direct)
                     WHEN (one_num_gen = '1')
                     ELSE
                         (OTHERS => 'X' );

    number <= one_gen_s ;

END arch;
