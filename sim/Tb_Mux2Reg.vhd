----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 14:50:57
-- Design Name: 
-- Module Name: Tb_Mux2Reg - Behavioral
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

entity Tb_Mux2Reg is
end Tb_Mux2Reg;

architecture Behavioral of Tb_Mux2Reg is

    component Mux2Reg
        Port ( 
            I0  : in  STD_LOGIC_VECTOR (31 downto 0);
            I1  : in  STD_LOGIC_VECTOR (31 downto 0);
            I2  : in  STD_LOGIC_VECTOR (31 downto 0);
            I3  : in  STD_LOGIC_VECTOR (31 downto 0);
            I4  : in  STD_LOGIC_VECTOR (31 downto 0);
            I5  : in  STD_LOGIC_VECTOR (31 downto 0);
            sel : in  STD_LOGIC_VECTOR (2 downto 0);
            Y   : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    signal I0_tb  : STD_LOGIC_VECTOR (31 downto 0) := x"11111111";
    signal I1_tb  : STD_LOGIC_VECTOR (31 downto 0) := x"1234567F";
    signal I2_tb  : STD_LOGIC_VECTOR (31 downto 0) := x"22222222";
    signal I3_tb  : STD_LOGIC_VECTOR (31 downto 0) := x"33333333";
    signal I4_tb  : STD_LOGIC_VECTOR (31 downto 0) := x"44444444";
    signal I5_tb  : STD_LOGIC_VECTOR (31 downto 0) := x"55555555";
    signal sel_tb : STD_LOGIC_VECTOR (2 downto 0)  := "000";
    signal Y_tb   : STD_LOGIC_VECTOR (31 downto 0);

begin

    uut: Mux2Reg
        Port map (
            I0  => I0_tb,
            I1  => I1_tb,
            I2  => I2_tb,
            I3  => I3_tb,
            I4  => I4_tb,
            I5  => I5_tb,
            sel => sel_tb,
            Y   => Y_tb
        );

    stim_proc: process
    begin
        sel_tb <= "000";
        wait for 10 ns;

        sel_tb <= "001";
        wait for 10 ns;

        I1_tb  <= x"12345680";
        wait for 10 ns;

        sel_tb <= "010";
        wait for 10 ns;

        sel_tb <= "011";
        wait for 10 ns;

        sel_tb <= "100";
        wait for 10 ns;

        sel_tb <= "101";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;

