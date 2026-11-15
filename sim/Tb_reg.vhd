----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 11:09:23
-- Design Name: 
-- Module Name: Tb_reg - Behavioral
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

entity Tb_reg is
end Tb_reg;

architecture Behavioral of Tb_reg is

    component reg
        Port ( 
            clk   : in  STD_LOGIC;
            WR    : in  STD_LOGIC;
            SR1   : in  STD_LOGIC_VECTOR (4 downto 0);
            SR2   : in  STD_LOGIC_VECTOR (4 downto 0);
            DR    : in  STD_LOGIC_VECTOR (4 downto 0);
            data  : in  STD_LOGIC_VECTOR (31 downto 0);
            read1 : out STD_LOGIC_VECTOR (31 downto 0);
            read2 : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    signal clk_tb   : STD_LOGIC := '0';
    signal WR_tb    : STD_LOGIC := '0';
    signal SR1_tb   : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal SR2_tb   : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal DR_tb    : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal data_tb  : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal read1_tb : STD_LOGIC_VECTOR (31 downto 0);
    signal read2_tb : STD_LOGIC_VECTOR (31 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: reg
        Port map (
            clk   => clk_tb,
            WR    => WR_tb,
            SR1   => SR1_tb,
            SR2   => SR2_tb,
            DR    => DR_tb,
            data  => data_tb,
            read1 => read1_tb,
            read2 => read2_tb
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
        WR_tb   <= '1';
        DR_tb   <= "00001";
        data_tb <= x"0000000A";
        wait for CLK_PERIOD;

        DR_tb   <= "00010";
        data_tb <= x"00000014";
        wait for CLK_PERIOD;

        DR_tb   <= "00000";
        data_tb <= x"FFFFFFFF";
        wait for CLK_PERIOD;

        WR_tb  <= '0';
        SR1_tb <= "00001";
        SR2_tb <= "00010";
        wait for CLK_PERIOD;

        SR1_tb <= "00000";
        SR2_tb <= "00001";
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;

