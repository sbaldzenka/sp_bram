-- project     : sp_bram_vhdl
-- version     : 1.0
-- date        : 30.08.2024
-- author      : siarhei baldzenka
-- e-mail      : sbaldzenka@proton.me
-- description : https://github.com/sbaldzenka/sp_bram

vlib work
vmap work work

vcom -93 ../tb/testbench.vhd

vcom -93 ../hdl/sp_bram.vhd

vsim -t 1ps -voptargs=+acc=lprn -lib work testbench

do waves.do
view wave
run 1 ms