-- project     : sp_bram_verilog
-- version     : 1.0
-- date        : 22.04.2026
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