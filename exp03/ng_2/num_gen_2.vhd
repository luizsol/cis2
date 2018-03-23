library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;


ENTITY num_gen_with_function IS
    GENERIC
    (
    WIDTH: natural := 8
    );

    PORT
    (
    pos_neg     : in STD_LOGIC;
    one_three   : in STD_LOGIC;
    one_num_gen : in STD_LOGIC;
    number      : out STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0)
    );
END num_gen_with_function ;


ARCHITECTURE arch OF num_gen_with_function IS
--***********************************
--* SIMPLIFIED FUNTION DECLARATION   *
--***********************************
    FUNCTION rand_num_f(width : NATURAL) RETURN STD_LOGIC_VECTOR IS

        VARIABLE res_v: STD_LOGIC_VECTOR(WIDTH - 1 DOWNTO 0);
        -- Meu numero usp, em decimal, eh 8586861
        -- Meu numero usp mod 64, em decimal eh 45
        VARIABLE n_usp_mod: UNSIGNED(WIDTH - 1 DOWNTO 0);

    BEGIN
      n_usp_mod := TO_UNSIGNED(45, WIDTH);
      res_v := STD_LOGIC_VECTOR(n_usp_mod);
      RETURN res_v;
    END FUNCTION;

--***********************************
--* INTERNAL SIGNAL DECLARATIONS    *
--***********************************
    SIGNAL pos_neg_s  : STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
    SIGNAL one_three_s: STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);
    SIGNAL one_gen_s  : STD_LOGIC_VECTOR(WIDTH-1 DOWNTO 0);

BEGIN
    --*******************************
    --*    SIGNAL ASSIGNMENTS        *
    --*******************************
    pos_neg_s <= STD_LOGIC_VECTOR(to_unsigned(1, pos_neg_s'length))
                 WHEN (pos_neg = '0')
                 ELSE
                     STD_LOGIC_VECTOR(to_signed(-1, pos_neg_s'length))
                     WHEN (pos_neg = '1')
                     ELSE
                         (others => 'X' );

    one_three_s <= pos_neg_s
                   WHEN (one_three = '0')
                   ELSE
                       pos_neg_s(WIDTH-1 DOWNTO 2) & (not pos_neg_s(1))
                           & pos_neg_s(0)
                       WHEN (one_three = '1')
                       ELSE
                         (others => 'X' );

    one_gen_s <= one_three_s
                 WHEN (one_num_gen = '0')
                 ELSE
                     rand_num_f(WIDTH) AFTER 8ns
                     WHEN (one_num_gen = '1')
                     ELSE
                         (others => 'X' );

    number <= one_gen_s ;
END arch;
