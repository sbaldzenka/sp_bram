-- project     : sp_bram_verilog
-- version     : 1.1
-- date        : 22.04.2026
-- author      : siarhei baldzenka
-- e-mail      : sbaldzenka@proton.me
-- description : https://github.com/sbaldzenka/sp_bram

vlib work
vmap work work

vlog ../tb/testbench.v

vlog ../hdl/sp_bram.v

vsim -t 1ps -voptargs=+acc=lprn -lib work testbench

do waves.do
view wave
run 10 us