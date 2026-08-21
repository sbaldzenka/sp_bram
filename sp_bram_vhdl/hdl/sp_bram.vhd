-- ---------------------------------------------------------------------------------------
--
-- MIT License
--
-- Copyright (c) 2026 Siarhei Baldzenka
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- ---------------------------------------------------------------------------------------
--
-- project     : sp_bram_vhdl
-- version     : 1.1
-- date        : 30.08.2024
-- author      : siarhei baldzenka
-- e-mail      : sbaldzenka@proton.me
-- description : https://github.com/sbaldzenka/sp_bram
--
-- ---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity sp_bram is
generic
(
    ADDR_WIDTH : integer := 4;
    DATA_WIDTH : integer := 8;
    MEM_FILE   : string  := "path_to_mem_file/file.mem"
);
port
(
    -- global signal
    i_clk  : in  std_logic;
    -- wr/rd data
    i_we   : in  std_logic;
    i_addr : in  std_logic_vector(ADDR_WIDTH - 1 downto 0);
    i_data : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
    o_data : out std_logic_vector(DATA_WIDTH - 1 downto 0)
);
end sp_bram;

architecture rtl of sp_bram is

    -- types
    type mem_array is array(0 to (2**ADDR_WIDTH) - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);

    -- functions
    impure function init_mem_from_file (file_name : in string) return mem_array is
        FILE     init_mem_file  : text is in file_name;
        variable file_name_line : line;
        variable memory         : mem_array;
    begin
        if (file_name /= "") then
            for index in mem_array'range loop
                readline (init_mem_file, file_name_line);
                read (file_name_line, memory(index));
            end loop;
        end if;

        return memory;
    end function;

    -- signals
    signal mem : mem_array := init_mem_from_file(MEM_FILE);

begin

    MEMORY_PROC: process(i_clk)
    begin
        if rising_edge(i_clk) then
            if (i_we = '1') then
                mem(to_integer(unsigned(i_addr))) <= i_data;
            end if;

            o_data <= mem(to_integer(unsigned(i_addr)));
        end if;
    end process;

end rtl;