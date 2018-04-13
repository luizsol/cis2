Library IEEE;
use ieee.STD_LOGIC_1164.all;

entity rc_adder_3 is
  generic
  (
    WIDTH : integer := 32
  );

  port
  (
    a_i, b_i: in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    c_i:      in STD_LOGIC;
    z_o:      out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    c_o:      out STD_LOGIC;
    ctrl_x_y: in STD_LOGIC
  );

end rc_adder_3;

architecture arch of rc_adder_3 is

  component full_adder_1
    port
    (
      a_in:  in STD_LOGIC;
      b_in:  in STD_LOGIC;
      c_in:  in STD_LOGIC;
      z_out: out STD_LOGIC;
      c_out: out STD_LOGIC
    );
  end component;

  signal cout_s: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
  signal z_s: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
  signal a_aux_s: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

begin

    fa_init:  full_adder_1 port map
                (
                  a_in => a_aux_s(0),
                  b_in => b_i(0),
                  c_in => c_i,
                  z_out => z_s(0),
                  c_out => cout_s(0)
                );

    a_aux_s(0) <= a_i(0) when (ctrl_x_y = '0')
                         else
                           '0' when (ctrl_x_y = '1')
                               else
                                 'X';

  gen_fas: for I in 1 to WIDTH - 2 generate

    gen_fas_if_1:
        if (I < WIDTH / 2) GENERATE
          a_aux_s(I) <= a_i(I) when (ctrl_x_y = '0')
                               else
                                 '0' when (ctrl_x_y = '1')
                                     else
                                       'X';
        END GENERATE gen_fas_if_1;

    gen_fas_if_2:
        if (I >= WIDTH / 2) GENERATE
          a_aux_s(I) <= a_i(I) when (ctrl_x_y = '0')
                               else
                                 a_i(I - (WIDTH / 2)) when (ctrl_x_y = '1')
                                                      else
                                                        'X';
        END GENERATE gen_fas_if_2;

    fa: full_adder_1 port map
            (
              a_in => a_aux_s(i),
              b_in => b_i(i),
              c_in => cout_s(i - 1),
              z_out => z_s(i),
              c_out => cout_s(i)
            );
  end generate;

  fa_last:  full_adder_1 port map
              (
                a_in => a_aux_s(WIDTH - 1),
                b_in => b_i(WIDTH - 1),
                c_in => cout_s(WIDTH-2),
                z_out => z_s(WIDTH - 1),
                c_out => cout_s(WIDTH - 1)
              );

    a_aux_s(WIDTH - 1) <= a_i(WIDTH - 1) when (ctrl_x_y = '0')
                                         else
                                           a_i((WIDTH / 2) - 1) when (ctrl_x_y = '1')
                                                                else
                                                                  'X';

     z_o <= z_s;
     c_o <= cout_s(WIDTH - 1);

end arch;
