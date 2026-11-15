----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 13:44:53
-- Design Name: 
-- Module Name: Branch_ctrl - Behavioral
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
entity Branch_ctrl is
    Port ( br : in STD_LOGIC_VECTOR (2 downto 0);
           zero : in STD_LOGIC;
           sign : in STD_LOGIC;
           PC_op : out STD_LOGIC);
end Branch_ctrl;

architecture Behavioral of Branch_ctrl is

begin
process(br,sign,zero)
begin
    case br is
        when "001"=> PC_op<= zero;
        when "010"=> PC_op<= NOT zero;
        when "011"=> PC_op<= sign;
        when "100"=> PC_op<= NOT sign;
        when "101"=> PC_op<= '1';
        when "110"=> PC_op<= '1';
        when others => PC_op<= '0';
    end case;
end process;
end Behavioral;
