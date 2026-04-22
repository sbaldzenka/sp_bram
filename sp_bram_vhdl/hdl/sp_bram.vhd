-- project     : sp_bram
-- date        : 30.08.2024
-- author      : siarhei baldzenka
-- e-mail      : sbaldzenka@proton.me
-- description : https://github.com/sbaldzenka/sp_bram/sp_bram_vhdl

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sp_bram is
generic
(
    ADDR_WIDTH : integer := 4;
    DATA_WIDTH : integer := 8
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
    type mem_array is array((2**ADDR_WIDTH) - 1 downto 0) of std_logic_vector(DATA_WIDTH - 1 downto 0);

    -- signals
    signal mem : mem_array;

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