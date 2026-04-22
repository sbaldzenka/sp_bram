-- project     : sp_bram
-- date        : 30.08.2024
-- author      : siarhei baldzenka
-- e-mail      : sbaldzenka@proton.me
-- description : https://github.com/sbaldzenka/sp_bram/sp_bram_vhdl

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity testbench is
generic
(
    ADDR_WIDTH : integer := 4;
    DATA_WIDTH : integer := 8
);
end testbench;

architecture behavioral of testbench is

    component sp_bram is
    generic
    (
        ADDR_WIDTH : integer;
        DATA_WIDTH : integer
    );
    port
    (
        i_clk  : in  std_logic;
        i_we   : in  std_logic;
        i_addr : in  std_logic_vector(ADDR_WIDTH - 1 downto 0);
        i_data : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
        o_data : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
    end component;

    -- constants
    constant SYS_CLK_PERIOD : time := 10.000 ns; -- 100 MHz

    -- signals
    signal system_clk : std_logic := '0';
    signal we         : std_logic;
    signal addr       : std_logic_vector(ADDR_WIDTH - 1 downto 0);
    signal data_in    : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal data_out   : std_logic_vector(DATA_WIDTH - 1 downto 0);

begin

    CLK_GEN: process
    begin
        system_clk <= not system_clk;
        wait for (SYS_CLK_PERIOD / 2);
    end process;

    TEST_DATA_PROC: process
    begin
        we      <= '0';
        addr    <= (others => '0');
        data_in <= (others => '0');
        wait for 100 us;
        wait until falling_edge(system_clk);
        we      <= '1';

        for index in 0 to ((2**ADDR_WIDTH) - 1) loop
            wait for SYS_CLK_PERIOD;
            addr    <= addr + '1';
            data_in <= data_in + '1';
        end loop;

        we      <= '0';
        addr    <= (others => '0');
        wait for 100 us;
        wait until falling_edge(system_clk);

        for index in 0 to ((2**ADDR_WIDTH) - 1) loop
            wait for SYS_CLK_PERIOD;
            addr <= addr + '1';
        end loop;
        wait;
    end process;

    DUT_inst: sp_bram
    generic map
    (
        ADDR_WIDTH => ADDR_WIDTH,
        DATA_WIDTH => DATA_WIDTH
    )
    port map
    (
        i_clk  => system_clk,
        i_we   => we,
        i_addr => addr,
        i_data => data_in,
        o_data => data_out
    );

end behavioral;