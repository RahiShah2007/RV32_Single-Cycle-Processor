----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 14:40:07
-- Design Name: 
-- Module Name: Tb_Data_memory - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_Data_memory is
end Tb_Data_memory;

architecture Behavioral of Tb_Data_memory is

    component Data_memory
        Port ( 
            clk      : in  STD_LOGIC;
            wr_en    : in  STD_LOGIC;
            adr      : in  STD_LOGIC_VECTOR (3 downto 0);
            data_in  : in  STD_LOGIC_VECTOR (31 downto 0);
            data_out : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    signal clk_tb      : STD_LOGIC := '0';
    signal wr_en_tb    : STD_LOGIC := '0';
    signal adr_tb      : STD_LOGIC_VECTOR (3 downto 0)  := (others => '0');
    signal data_in_tb  : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal data_out_tb : STD_LOGIC_VECTOR (31 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: Data_memory
        Port map (
            clk      => clk_tb,
            wr_en    => wr_en_tb,
            adr      => adr_tb,
            data_in  => data_in_tb,
            data_out => data_out_tb
        );

    clk_process: process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD / 2;
        clk_tb <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    stim_proc: process
    begin
        wr_en_tb   <= '1';
        adr_tb     <= x"0";
        data_in_tb <= x"12345678";
        wait for CLK_PERIOD;

        adr_tb     <= x"4";
        data_in_tb <= x"AABBCCDD";
        wait for CLK_PERIOD;

        wr_en_tb <= '0';
        adr_tb   <= x"0";
        wait for CLK_PERIOD;

        adr_tb <= x"4";
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;
