-- project     : sp_bram
-- date        : 30.08.2024
-- author      : siarhei baldzenka
-- e-mail      : sbaldzenka@proton.me
-- description : https://github.com/sbaldzenka/sp_bram/sp_bram_vhdl

vlib work
vmap work work

vcom -93 ../tb/testbench.vhd

vcom -93 ../hdl/sp_bram.vhd

vsim -t 1ps -voptargs=+acc=lprn -lib work testbench

do waves.do 
view wave
run 1 ms