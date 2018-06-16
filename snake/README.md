# Snake project

The source code files are at the [`src`](src) folder and the test files (testbenches and stimuli) are at the [`test`](test) folder.

The project hierarchy is the following:

* [`snake_hw`](src/snake_hw.vhd)
    * [`button_handler`](src/button_handler.vhd)
    * [`control_snake`](src/control_snake.vhd)
        * [`fsm_food`](src/fsm_food.vhd)
        * [`fsm_init`](src/fsm_init.vhd)
        * [`fsm_main`](src/fsm_main.vhd)
        * [`fsm_step`](src/fsm_step.vhd)
    * [`datapath`](src/datapath.vhd)
        * [`alu`](src/alu.vhd)
            * [`rc_adder`](src/rc_adder.vhd)
                * [`full_adder`](src/full_adder.vhd)
        * [`code_gen`](src/code_gen.vhd)
        * [`comparator`](src/comparator.vhd)
        * [`mem`](src/mem.vhd)
            * `altsyncram` (Altera proprietary)
        * [`num_gen`](src/num_gen.vhd)
            * [`lfsr`](src/lfsr.vhd)
                * [`xor2`](src/xor2.vhd)
        * [`overflow_correction`](src/overflow_correction.vhd)
        * [`reg_bank`](src/reg_bank.vhd)
    * [`step_counter`](src/step_counter.vhd)

## TODO

- [ ] Implementar testbench `datapath`
- [ ] Implementar testbench `control_snake`
- [ ] Implementar testbench `snake_hw`
