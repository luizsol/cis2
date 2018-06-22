--******************************************************************************
--*                                                                            *
--* Title   : snake_hw.vhd                                                     *
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
use IEEE.NUMERIC_STD.all;

use work.snake_package.all;

entity snake_hw is
    generic (
        -- Width of one coordinate space addresing
        --  (square of (2 ^ COR_WIDTH) x (2 ^ COR_WIDTH) )
        COR_WIDTH : NATURAL := 3
    );

    port (
        clk             : in STD_LOGIC;
        res             : in STD_LOGIC;
        sys_direction   : in STD_LOGIC_VECTOR(3 downto 0);
        sys_step_jumper : in STD_LOGIC;
        --TESTPINS
        test_mem_b_addr : in STD_LOGIC_VECTOR(2 * COR_WIDTH - 1 downto 0);
        test_idle_state : out STD_LOGIC;
        test_go_state   : out STD_LOGIC;
        test_mem_b_data : out STD_LOGIC_VECTOR(7 downto 0)
    );
end snake_hw;


architecture arch of snake_hw is
    component control_snake
        port (
            clk             : in  STD_LOGIC;
            res             : in  STD_LOGIC;
            sys_direction   : in  direction;
            cnt_rdy         : in  STD_LOGIC;
            dp_flags        : in  datapath_flags;
            dp_ctrl         : out datapath_ctrl_flags;
            --TESTPORTS
            test_idle_state : out STD_LOGIC;
            test_go_state   : out STD_LOGIC
        );
    end component;

    component datapath
        generic (
            COR_WIDTH : NATURAL := 3
        );

        port (
            clk         : in  STD_LOGIC;
            res         : in  STD_LOGIC;
            mem_b_addr  : in  STD_LOGIC_VECTOR(2 * COR_WIDTH - 1 downto 0);
            ctrl_ctrl   : in  datapath_ctrl_flags;
            mem_b_data  : out STD_LOGIC_VECTOR(7 downto 0);
            ctrl_flags  : out datapath_flags
        );
    end component;

    component step_counter
        generic (
            COUNT_MAX   : positive := 10
        );

        port (
            clk         : in  STD_LOGIC;
            res         : in  STD_LOGIC;
            cnt_rdy     : out STD_LOGIC;
            cnt_value	: out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component button_handler
        port (
            clk             : in STD_LOGIC;
            res             : in STD_LOGIC;
            load_regs       : in STD_LOGIC;
            sys_direction   : in STD_LOGIC_VECTOR(3 downto 0);
            sys_step_jumper : in STD_LOGIC;
            direction_sync  : out direction;
            step_jumper_sync: out STD_LOGIC
        );
    end component;

    signal sys_direction_synched_s      : direction;
    signal sys_step_jumper_synched_s    : STD_LOGIC;
    signal cnt_rdy_s                    : STD_LOGIC;
    signal dp_ctrl_s                    : datapath_ctrl_flags;
    signal dp_flags_s                   : datapath_flags;
    signal mem_b_addr_s                 : STD_LOGIC_VECTOR(2 * COR_WIDTH - 1
                                                           downto 0);
    signal mem_b_data_s                 : STD_LOGIC_VECTOR(7 downto 0);
    signal vga_if_clk_s                 : STD_LOGIC;
    signal cnt_value_s : STD_LOGIC_VECTOR(3 downto 0);



begin

    --*******************************
    --*    COMPONENT INSTANTIATIONS    *
    --*******************************

    cntrl_unit: control_snake
        port map (
            clk             => clk,
            res             => res,
            sys_direction   => sys_direction_synched_s,
            cnt_rdy         => cnt_rdy_s,
            dp_flags        => dp_flags_s,
            dp_ctrl         => dp_ctrl_s,
            --TESTPORTS
            test_idle_state => test_idle_state,
            test_go_state   => test_go_state
            );


    step_cnt: step_counter
        port map (
            clk         => clk,
            res         => res,
            cnt_rdy     => cnt_rdy_s,
            cnt_value   => cnt_value_s
        );

    dp_dummy: datapath
        generic map (
            COR_WIDTH => COR_WIDTH
        )

        port map (
            clk         => clk,
            res         => res,
            mem_b_addr  => mem_b_addr_s,
            ctrl_ctrl   => dp_ctrl_s,
            mem_b_data  => mem_b_data_s,
            ctrl_flags  => dp_flags_s
        );

    bh: button_handler
        port map (
            clk                 => clk,
            res                 => res,
            load_regs           => cnt_rdy_s,
            sys_direction       => sys_direction,
            sys_step_jumper     => sys_step_jumper,
            direction_sync      => sys_direction_synched_s,
            step_jumper_sync    => sys_step_jumper_synched_s
        );

    mem_b_addr_s    <= test_mem_b_addr;
    test_mem_b_data <= mem_b_data_s;

end arch;
