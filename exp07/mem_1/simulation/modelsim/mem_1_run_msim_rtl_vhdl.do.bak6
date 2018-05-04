transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {X:/projects/cis2/exp07/mem_1/mem_1.vhd}

vcom -93 -work work {X:/projects/cis2/exp07/mem_1/mem_1.vhd}
vcom -93 -work work {X:/projects/cis2/exp07/mem_1/stimuli_mem_1.vhd}
vcom -93 -work work {X:/projects/cis2/exp07/mem_1/testbench_mem_1.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc" tb_mem_1

add wave *
view structure
view signals
run 100 ns
