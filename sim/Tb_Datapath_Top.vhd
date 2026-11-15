----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 15:09:14
-- Design Name: 
-- Module Name: Tb_Datapath_Top - Behavioral
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

entity Tb_Datapath_Top is
end Tb_Datapath_Top;

architecture Behavioral of Tb_Datapath_Top is

    component DataPath
        port (
            clk : in std_logic;
            rst : in std_logic
        );
    end component;

    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: DataPath
        port map (
            clk => clk_tb,
            rst => rst_tb
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
        rst_tb <= '0';
        wait for CLK_PERIOD * 2;

        rst_tb <= '1';
        wait for CLK_PERIOD * 80;

        wait;
    end process;

end Behavioral;

