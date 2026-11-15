----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 11:29:49
-- Design Name: 
-- Module Name: Tb_mux_32b - Behavioral
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

entity Tb_mux_32b is
end Tb_mux_32b;

architecture Behavioral of Tb_mux_32b is

    component mux_32b
        Port ( 
            I0 : in  STD_LOGIC_VECTOR (31 downto 0);
            I1 : in  STD_LOGIC_VECTOR (31 downto 0);
            S  : in  STD_LOGIC;
            Y  : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    signal I0_tb : STD_LOGIC_VECTOR (31 downto 0) := x"AAAAAAAA";
    signal I1_tb : STD_LOGIC_VECTOR (31 downto 0) := x"55555555";
    signal S_tb  : STD_LOGIC := '0';
    signal Y_tb  : STD_LOGIC_VECTOR (31 downto 0);

begin

    uut: mux_32b
        Port map (
            I0 => I0_tb,
            I1 => I1_tb,
            S  => S_tb,
            Y  => Y_tb
        );

    stim_proc: process
    begin
        S_tb <= '0';
        wait for 10 ns;

        S_tb <= '1';
        wait for 10 ns;

        I0_tb <= x"12345678";
        I1_tb <= x"87654321";
        S_tb  <= '0';
        wait for 10 ns;

        S_tb <= '1';
        wait for 10 ns;

        wait;
    end process;

end Behavioral;

