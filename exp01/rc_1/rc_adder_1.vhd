Library IEEE;
USE IEEE.STD_LOGIC_1164.all;

-------------------------- Ripple Carry Adder  --------------------------

ENTITY rc_adder_1 IS
    GENERIC (
        WIDTH  : natural := 4
    );
    PORT (
        a_i, b_i:   IN STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0);
        c_i:        IN STD_LOGIC;
        z_out:      OUT STD_LOGIC_VECTOR (WIDTH - 1 DOWNTO 0);
        c_o:        OUT STD_LOGIC
    );
END rc_adder_1;

ARCHITECTURE structural OF rc_adder_1 IS
     COMPONENT full_adder_2
        PORT (
            a_in, b_in, c_in:   IN STD_LOGIC;
            z_out, c_out:       OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL cout_0, cout_1, cout_2 : STD_LOGIC;

    BEGIN
        adder_0: full_adder_2 PORT MAP (a_in => a_i(0),
                                        b_in => b_i(0),
                                        c_in => c_i,
                                        z_out => z_out(0),
                                        c_out => cout_0);

        adder_1: full_adder_2 PORT MAP (a_in => a_i(1),
                                        b_in => b_i(1),
                                        c_in => cout_0,
                                        z_out => z_out(1),
                                        c_out => cout_1);

        adder_2: full_adder_2 PORT MAP (a_in => a_i(2),
                                        b_in => b_i(2),
                                        c_in => cout_1,
                                        z_out => z_out(2),
                                        c_out => cout_2);

        adder_3: full_adder_2 PORT MAP (a_in => a_i(3),
                                        b_in => b_i(3),
                                        c_in => cout_2,
                                        z_out => z_out(3),
                                        c_out => c_o);
END structural;

-------------------------- Full Adder --------------------------

Library IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY full_adder_2 IS
    PORT (
        a_in, b_in, c_in:   IN STD_LOGIC;
        z_out, c_out:       OUT STD_LOGIC
    );
END full_adder_2;

ARCHITECTURE structural OF full_adder_2 IS
    COMPONENT and2
        GENERIC (t_and: time := 2 ns);
        PORT (
            x, y:   IN STD_LOGIC;
            z:      OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT xor2
        GENERIC (t_xor: time := 4 ns);
        PORT (
            x, y:   IN STD_LOGIC;
            z:      OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT or3
        GENERIC (t_or: time := 4 ns);
        PORT (
            w, x, y:    IN STD_LOGIC;
            z:          OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL aux_xor, aux_and_1, aux_and_2, aux_and_3 : STD_LOGIC;

    BEGIN
        XOR_1: xor2 GENERIC MAP (10 ns) PORT MAP (x => a_in,
                                                  y => b_in,
                                                  z => aux_xor);

        XOR_2: xor2 GENERIC MAP (10 ns) PORT MAP (x => c_in,
                                                  y => aux_xor,
                                                  z => z_out);

        AND_1: and2 GENERIC MAP (10 ns) PORT MAP (x => a_in,
                                                  y => b_in,
                                                  z => aux_and_1);

        AND_2: and2 GENERIC MAP (10 ns) PORT MAP (x => a_in,
                                                  y => c_in,
                                                  z => aux_and_2);

        AND_3: and2 GENERIC MAP (10 ns) PORT MAP (x => b_in,
                                                  y => c_in,
                                                  z => aux_and_3);

        OR_3: or3 GENERIC MAP (10 ns) PORT MAP (w => aux_and_1,
                                                x => aux_and_2,
                                                y => aux_and_3,
                                                z => c_out);
END structural;

-------------------------- 2bit And Gate --------------------------

Library IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY and2 IS
    GENERIC(t_and : time := 2 ns);
    PORT(
        x, y:   IN STD_LOGIC;
        z:      OUT STD_LOGIC
    );
END and2;

ARCHITECTURE dataflow OF and2 IS
    BEGIN
        z <= x AND y AFTER t_and;
END dataflow;

-------------------------- 2bit Xor Gate --------------------------

Library IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY xor2 IS
    GENERIC(t_xor : time := 4 ns);
    PORT(
        x, y:   IN STD_LOGIC;
        z:      OUT STD_LOGIC
    );
END xor2;

ARCHITECTURE dataflow OF xor2 IS
    BEGIN
        z <= x XOR y AFTER t_xor;
END dataflow;

-------------------------- 3bit Or Gate --------------------------

Library IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY or3 IS
    GENERIC(t_or : time := 4 ns);
    PORT(
        w, x, y:    IN STD_LOGIC;
        z:          OUT STD_LOGIC
    );
END or3;

ARCHITECTURE dataflow OF or3 IS
    BEGIN
        z <= w OR x OR y AFTER t_or;
END dataflow;
