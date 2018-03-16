Library IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY full_adder IS
    PORT (
        a_in, b_in, c_in:   IN STD_LOGIC;
        z_out, c_out:       OUT STD_LOGIC
    );
END full_adder;

ARCHITECTURE behaviour OF full_adder IS
    SIGNAL aux_xor, aux_and_1, aux_and_2, aux_and_3 : STD_LOGIC;

    BEGIN
        PROCESS(a_in, b_in, c_in, aux_and_2, aux_and_3)
            BEGIN
                aux_xor <= a_in XOR b_in;
                aux_and_1 <= a_in AND b_in;
                aux_and_2 <= a_in AND c_in;
                aux_and_3 <= b_in AND c_in;
                c_out <= aux_and_1 OR aux_and_2 OR aux_and_3;
                z_out <= aux_xor XOR c_in;
            END PROCESS;

END behaviour;
