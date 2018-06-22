# Saindo de uma possível simulação anterior
quit -sim
# Apangando a library work atual
vmap -del work
vdel -all -lib work
# Definindo variáveis da compilação e simulação
set diretorio "~/projects/cis2/snake"

set arquivos {"src/snake_package.vhd" "src/address_counter.vhd" "src/reg.vhd" "src/fifo.vhd" "src/full_adder.vhd" "src/rc_adder.vhd" "src/alu.vhd" "src/step_counter.vhd" "src/reg_bank.vhd" "src/overflow_correction.vhd" "src/xor2.vhd" "src/lfsr.vhd" "src/num_gen.vhd" "src/mem.vhd" "src/comparator.vhd" "src/code_gen.vhd" "src/datapath.vhd" "src/fsm_food.vhd" "src/fsm_init.vhd" "src/fsm_main.vhd" "src/fsm_step.vhd" "src/control_snake.vhd" "src/button_handler.vhd" "src/snake_hw.vhd" "src/map_monitor.vhd" "test/snake_stimuli.vhd" "test/snake_tb.vhd"}

set componente "snake_tb"

set duration [expr {10000}]
# Definindo o diretório do projeto
cd $diretorio
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
[foreach arquivo $arquivos {
    vcom -reportprogress 300 -work work $diretorio/$arquivo
}]

# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.$componente
# view wave
# Configurando os sinais a serem apresentados
# add wave -position insertpoint sim:/$componente/*
# run $duration ns

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /snake_tb/clk_s
add wave -noupdate -label RESET /snake_tb/res_s
add wave -noupdate -label DIRECTION /snake_tb/dut/sys_direction_synched_s
add wave -noupdate /snake_tb/sys_direction_s
add wave -noupdate -label STEP_READY /snake_tb/dut/cntrl_unit/cnt_rdy
add wave -noupdate -group REG_BANK -label REG_HEAD -radix hexadecimal /snake_tb/dut/dp_dummy/rb/head_cmp/q
add wave -noupdate -group REG_BANK -label REG2 -radix hexadecimal /snake_tb/dut/dp_dummy/rb/reg2_cmp/q
add wave -noupdate -group REG_BANK -label RB_IN -radix hexadecimal /snake_tb/dut/dp_dummy/ofc_2_rb_s
add wave -noupdate -group MEM_A -label DATA_WRITE -radix hexadecimal /snake_tb/dut/dp_dummy/field_map/data_a
add wave -noupdate -group MEM_A -color Gray90 -label CODE_SEL /snake_tb/dut/cntrl_unit/dp_ctrl.cg_sel
add wave -noupdate -group MEM_A -label ADDRESS -radix octal /snake_tb/dut/dp_dummy/field_map/address_a
add wave -noupdate -group MEM_A -label W_EN /snake_tb/dut/dp_dummy/field_map/wren_a
add wave -noupdate -group MEM_A -label READ /snake_tb/dut/dp_dummy/field_map/q_a
add wave -noupdate -group {CONTROL SIGNALS} -group NUMBER_GEN_CTRL -color Gray90 -label ONE_GEN /snake_tb/dut/cntrl_unit/dp_ctrl.ng_one_gen
add wave -noupdate -group {CONTROL SIGNALS} -group NUMBER_GEN_CTRL -color Gray90 -label POS_NEG /snake_tb/dut/cntrl_unit/dp_ctrl.ng_pos_neg
add wave -noupdate -group {CONTROL SIGNALS} -group NUMBER_GEN_CTRL -color Gray90 -label 1_3 /snake_tb/dut/cntrl_unit/dp_ctrl.ng_one_three
add wave -noupdate -group {CONTROL SIGNALS} -expand -group ALU_CTRL -color Gray90 -label X_Y /snake_tb/dut/cntrl_unit/dp_ctrl.alu_x_y
add wave -noupdate -group {CONTROL SIGNALS} -expand -group ALU_CTRL -color Gray90 -label PASS_CALC /snake_tb/dut/cntrl_unit/dp_ctrl.alu_pass_calc
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label LOAD_HEAD /snake_tb/dut/cntrl_unit/dp_ctrl.rb_head_en
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label LOAD_REG2 /snake_tb/dut/cntrl_unit/dp_ctrl.rb_reg2_en
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label LOAD_FIFO /snake_tb/dut/cntrl_unit/dp_ctrl.rb_fifo_en
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label POP_FIFO /snake_tb/dut/cntrl_unit/dp_ctrl.rb_fifo_pop
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label RB_OUT /snake_tb/dut/cntrl_unit/dp_ctrl.rb_out_sel
add wave -noupdate -group {CONTROL SIGNALS} -expand -group CODE_GEN_CTRL -color Gray90 -label CODE_SEL /snake_tb/dut/cntrl_unit/dp_ctrl.cg_sel
add wave -noupdate -group {CONTROL SIGNALS} -group MEM_CTRL -color Gray90 -label MEM_W_EN /snake_tb/dut/cntrl_unit/dp_ctrl.mem_w_e
add wave -noupdate -group FLAGS -color Gray70 -label X_OVERFLOW /snake_tb/dut/cntrl_unit/dp_flags.ofc_of_x
add wave -noupdate -group FLAGS -color Gray70 -label Y_OVERFLOW /snake_tb/dut/cntrl_unit/dp_flags.ofc_of_y
add wave -noupdate -group FLAGS -color Gray70 -label FOOD /snake_tb/dut/cntrl_unit/dp_flags.cmp_food_flag
add wave -noupdate -group FLAGS -color Gray70 -label BODY /snake_tb/dut/cntrl_unit/dp_flags.cmp_body_flag
add wave -noupdate -expand -group STATE_MACHINES -color {Medium Violet Red} -label MAIN /snake_tb/dut/cntrl_unit/main/STATE
add wave -noupdate -expand -group STATE_MACHINES -group INIT -color {Cadet Blue} -label INIT_START /snake_tb/dut/cntrl_unit/main/fsm_i_start
add wave -noupdate -expand -group STATE_MACHINES -group INIT -color {Cadet Blue} -label INIT /snake_tb/dut/cntrl_unit/init/STATE
add wave -noupdate -expand -group STATE_MACHINES -group INIT -color {Cadet Blue} -label INIT_DONE /snake_tb/dut/cntrl_unit/main/fsm_i_done
add wave -noupdate -expand -group STATE_MACHINES -group FOOD -color {Cadet Blue} -label FOOD_START /snake_tb/dut/cntrl_unit/main/fsm_f_start
add wave -noupdate -expand -group STATE_MACHINES -group FOOD -color {Cadet Blue} -label FOOD /snake_tb/dut/cntrl_unit/food/STATE
add wave -noupdate -expand -group STATE_MACHINES -group FOOD -color {Cadet Blue} -label FOOD_DONE /snake_tb/dut/cntrl_unit/main/fsm_f_done
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label STEP_START /snake_tb/dut/cntrl_unit/main/fsm_s_start
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label STEP /snake_tb/dut/cntrl_unit/step/STATE
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label STEP_DONE /snake_tb/dut/cntrl_unit/main/fsm_s_done
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label FOUND_FOOD /snake_tb/dut/cntrl_unit/main/cmp_food_flag
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label GAME_OVER /snake_tb/dut/cntrl_unit/main/fsm_s_game_over
add wave -noupdate -expand -group MONITOR -color Pink -label PRINT_RDY /snake_tb/mon/print_rdy
add wave -noupdate -expand -group MONITOR -color Pink -label ADDRESS -radix octal /snake_tb/mon/mem_b_addr
add wave -noupdate -expand -group MONITOR -color Pink -label DATA /snake_tb/mon/mem_b_data
add wave -noupdate -expand -group MONITOR -color Pink -label STR_DATA -radix ascii /snake_tb/mon/str_of_field_s
add wave -noupdate -expand -group MONITOR -color Pink -label {PRINT_RDY} /snake_tb/mon/print_rdy_delay_s
add wave -noupdate -expand -group MONITOR -color Pink -label PRINT_DONE /snake_tb/mon/print_done_delay_s
add wave -noupdate -expand -group MONITOR -color Pink -label LINE_WRITTEN /snake_tb/mon/written_s
add wave /snake_tb/dut/dp_dummy/alu_un/*
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {979383 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 332
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {4939801 ps} {4979366 ps}
# run 10000 ns
# run 20 ns
run $duration ns
