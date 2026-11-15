----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2026 21:17:26
-- Design Name: 
-- Module Name: Tb_Imm_gen - Behavioral
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

entity Tb_Immediate_gen is
end Tb_Immediate_gen;

architecture Behavioral of Tb_Immediate_gen is

    component Immediate_gen
        Port ( 
            inst : in  STD_LOGIC_VECTOR (31 downto 0);
            imm  : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    signal inst_tb : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal imm_tb  : STD_LOGIC_VECTOR (31 downto 0);

begin

    uut: Immediate_gen
        Port map (
            inst => inst_tb,
            imm  => imm_tb
        );

    stim_proc: process
    begin
        inst_tb <= x"00A00093";
        wait for 10 ns;

        inst_tb <= x"FFB00093";
        wait for 10 ns;

        inst_tb <= x"00312623";
        wait for 10 ns;

        inst_tb <= x"FE312E23";
        wait for 10 ns;

        inst_tb <= x"FE271EE3";
        wait for 10 ns;

        inst_tb <= x"0100006F";
        wait for 10 ns;

        inst_tb <= x"002081B3";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
