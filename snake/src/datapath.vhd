--******************************************************************************
--*                                                                            *
--* Title   : datapath.vhd                                                     *
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
use IEEE.std_logic_1164.all;

use work.snake_package.all;

entity datapath is
    generic (
        COR_WIDTH : NATURAL := 3
    );

    port (
        sys_clk     : in  STD_LOGIC;
        res         : in  STD_LOGIC;
        mem_b_addr  : in  STD_LOGIC_VECTOR(2 * COR_WIDTH - 1 downto 0);
        ctrl_ctrl   : in  datapath_ctrl_flags;
        mem_b_data  : out STD_LOGIC_VECTOR(7 downto 0);
        ctrl_flags  : out datapath_flags
    );
end datapath;


architecture arch of datapath is

    constant WIDTH : natural := 2 * COR_WIDTH + 2;

    component num_gen is
        generic (
            WIDTH  : natural := 8
        );

        port (
            clk         : in  STD_LOGIC;
            res         : in  STD_LOGIC;
            pos_neg     : in  STD_LOGIC;
            one_three   : in  STD_LOGIC;
            one_num_gen : in  STD_LOGIC;
            number      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    component reg_bank
        generic (
            WIDTH : NATURAL := 8
        );

        port (
            clk         : in  STD_LOGIC;
            res         : in  STD_LOGIC;
            ofc_address : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            load_head   : in  STD_LOGIC;
            load_reg2   : in  STD_LOGIC;
            load_fifo   : in  STD_LOGIC;
            fifo_pop    : in  STD_LOGIC;
            out_sel     : in  RB_SEL;
            alu_out     : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    component alu
        generic (
            WIDTH : NATURAL := 8
        );

        port (
            op_first        : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            rb_op           : in STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            ctrl_x_y        : in STD_LOGIC;
            ctrl_pass_calc  : in STD_LOGIC;
            ofc_result      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    component overflow_correction
        generic (
            WIDTH : NATURAL := 8
        );

        port (
            alu_result  : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            rb_result   : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            ctrl_of_x   : out STD_LOGIC;
            ctrl_of_y   : out STD_LOGIC
        );
    end component;

    component code_gen is
        port (
            ctrl_code_sel   : in  CODE;
            mem_code_w      : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component mem
        port (
            address_a   : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            address_b   : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            byteena_a   : IN STD_LOGIC_VECTOR(0 DOWNTO 0) := (OTHERS => '1');
            clk         : IN STD_LOGIC := '1';
            data_a      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_b      : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            wren_a      : IN STD_LOGIC := '0';
            wren_b      : IN STD_LOGIC := '0';
            q_a         : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            q_b         : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;

    component comparator
        port (
            mem_a_read  : in STD_LOGIC_VECTOR(7 downto 0);
            food_flag   : out STD_LOGIC;
            body_flag   : out STD_LOGIC
        );
    end component;

    signal ng_2_alu_s       : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal rb_2_alu_s       : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal alu_2_ofc_s      : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal ofc_2_rb_s       : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
    signal mem_a_en         : STD_LOGIC_VECTOR (0 downto 0);
    signal mem_a_data_w_s   : STD_LOGIC_VECTOR (7 downto 0);
    signal mem_a_addr_s     : STD_LOGIC_VECTOR (WIDTH - 3 downto 0);
    signal mem_a_read_s     : STD_LOGIC_VECTOR (7 downto 0);

begin

    n_g: num_gen
        generic map (
            WIDTH => WIDTH
        )

        port map (
            clk         => sys_clk,
            res         => res,
            pos_neg     => ctrl_ctrl.ng_pos_neg,
            one_three   => ctrl_ctrl.ng_one_three,
            one_num_gen => ctrl_ctrl.ng_one_gen,
            number      => ng_2_alu_s
        );


    rb: reg_bank
        generic map (
            WIDTH => WIDTH
        )

        port map (
            clk         => sys_clk,
            res         => res,
            ofc_address => ofc_2_rb_s,
            load_head   => ctrl_ctrl.rb_head_en,
            load_reg2   => ctrl_ctrl.rb_reg2_en,
            load_fifo   => ctrl_ctrl.rb_fifo_en,
            fifo_pop    => ctrl_ctrl.rb_fifo_pop,
            out_sel     => ctrl_ctrl.rb_out_sel,
            alu_out     => rb_2_alu_s
        );


    alu_un: entity work.alu(without_pass)
        generic map (
            WIDTH => WIDTH
        )

        port map (
            op_first        => ng_2_alu_s,
            rb_op           => rb_2_alu_s,
            ctrl_x_y        => ctrl_ctrl.alu_x_y,
            ctrl_pass_calc  => ctrl_ctrl.alu_pass_calc,
            ofc_result      => alu_2_ofc_s
        );

    ofc: overflow_correction
        generic map (
            WIDTH => WIDTH
        )

        port map (
            alu_result  => alu_2_ofc_s,
            rb_result   => ofc_2_rb_s,
            ctrl_of_x   => ctrl_flags.ofc_of_x,
            ctrl_of_y   => ctrl_flags.ofc_of_y
                                );

    c_g: code_gen
        port map (
            ctrl_code_sel   => ctrl_ctrl.cg_sel,
            mem_code_w      => mem_a_data_w_s
        );

    field_map: entity work.mem(rtl)
        port map (
            address_a   => mem_a_addr_s,
            address_b   => mem_b_addr,
            byteena_a   => mem_a_en,
            clk         => sys_clk,
            data_a      => mem_a_data_w_s,
            data_b      => (others => '0'),
            wren_a      => ctrl_ctrl.mem_w_e,
            wren_b      => '0',
            q_a         => mem_a_read_s,
            q_b         => mem_b_data
        );

    cmp: comparator
        port map (
            mem_a_read  => mem_a_read_s,
            food_flag   => ctrl_flags.cmp_food_flag,
            body_flag   => ctrl_flags.cmp_body_flag
        );

    -- cut off the overflowbits (msb of every coordinate)
    mem_a_addr_s <= ofc_2_rb_s(WIDTH - 2 downto WIDTH / 2)
        & ofc_2_rb_s(WIDTH / 2 - 2 downto 0);

    mem_a_en <= "1";

end arch;

