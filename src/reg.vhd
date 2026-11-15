----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 10:53:30
-- Design Name: 
-- Module Name: reg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg is
    Port ( clk : in STD_LOGIC;
           WR : in STD_LOGIC;                     -- write register
           SR1 : in STD_LOGIC_VECTOR (4 downto 0);        -- source register(address)
           SR2 : in STD_LOGIC_VECTOR (4 downto 0);         -- source register(address)
           DR : in STD_LOGIC_VECTOR (4 downto 0);      -- address of register destination
           data : in STD_LOGIC_VECTOR (31 downto 0);
           read1 : out STD_LOGIC_VECTOR (31 downto 0);
           read2 : out STD_LOGIC_VECTOR (31 downto 0));
end reg;

architecture Behavioral of reg is
type regi is array(0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
signal X: regi:=(others=>(others=>'0'));
begin
process(clk)
begin
    if rising_edge(clk) then
        if WR='1' and DR/="00000" then
            X(conv_integer(DR))<=data;
        end if;
    end if;
end process;
read1<= x(conv_integer(SR1)) when SR1/="00000" else (others=>'0');
read2<= x(conv_integer(SR2)) when SR2/="00000" else (others=>'0');
end Behavioral;
