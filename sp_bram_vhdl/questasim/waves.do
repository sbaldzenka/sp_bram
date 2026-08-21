-- project     : sp_bram_vhdl
-- version     : 1.1
-- date        : 30.08.2024
-- author      : siarhei baldzenka
-- e-mail      : sbaldzenka@proton.me
-- description : https://github.com/sbaldzenka/sp_bram

-- Waves
add wave -noupdate -divider testbench
add wave -noupdate -format Logic -radix HEXADECIMAL -group {testbench} /testbench/*

add wave -noupdate -divider DUT
add wave -noupdate -format Logic -radix HEXADECIMAL -group {DUT} /testbench/DUT_inst/*

-- Toggle leaf names command
config wave -signalnamewidth 1