Library IEEE;
USE IEEE.STD_LOGIC_1164.all;

entity full_adder is
    port (
        a_in    : in  STD_LOGIC;
        b_in    : in  STD_LOGIC;
        c_in    : in  STD_LOGIC;
        z_out   : out STD_LOGIC;
        c_out   : out STD_LOGIC
    );
end full_adder;

architecture dataflow of full_adder is

    signal aux_xor, aux_and_1, aux_and_2, aux_and_3: STD_LOGIC;

begin

    z_out       <= aux_xor XOR c_in;
    aux_xor     <= a_in XOR b_in;
    aux_and_1   <= a_in AND b_in;
    aux_and_2   <= a_in AND c_in;
    c_out       <= aux_and_1 OR aux_and_2 OR aux_and_3;
    aux_and_3   <= b_in AND c_in;

end dataflow;
