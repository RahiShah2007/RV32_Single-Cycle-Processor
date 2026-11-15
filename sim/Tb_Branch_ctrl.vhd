----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 13:51:39
-- Design Name: 
-- Module Name: Tb_Branch_ctrl - Behavioral
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

entity Tb_Branch_ctrl is
end Tb_Branch_ctrl;

architecture Behavioral of Tb_Branch_ctrl is

    component Branch_ctrl
        Port ( 
            br    : in  STD_LOGIC_VECTOR (2 downto 0);
            zero  : in  STD_LOGIC;
            sign  : in  STD_LOGIC;
            PC_op : out STD_LOGIC
        );
    end component;

    signal br_tb    : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal zero_tb  : STD_LOGIC := '0';
    signal sign_tb  : STD_LOGIC := '0';
    signal PC_op_tb : STD_LOGIC;

begin

    uut: Branch_ctrl
        Port map (
            br    => br_tb,
            zero  => zero_tb,
            sign  => sign_tb,
            PC_op => PC_op_tb
        );

    stim_proc: process
    begin
        br_tb   <= "000";
        zero_tb <= '1';
        sign_tb <= '1';
        wait for 10 ns;

        br_tb   <= "001";
        zero_tb <= '0';
        wait for 10 ns;
        zero_tb <= '1';
        wait for 10 ns;

        br_tb   <= "010";
        zero_tb <= '1';
        wait for 10 ns;
        zero_tb <= '0';
        wait for 10 ns;

        br_tb   <= "011";
        sign_tb <= '0';
        wait for 10 ns;
        sign_tb <= '1';
        wait for 10 ns;

        br_tb   <= "100";
        sign_tb <= '1';
        wait for 10 ns;
        sign_tb <= '0';
        wait for 10 ns;

        br_tb   <= "101";
        wait for 10 ns;

        br_tb   <= "110";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
