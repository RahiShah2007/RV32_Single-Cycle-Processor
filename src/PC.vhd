----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2026 15:06:15
-- Design Name: 
-- Module Name: PC - Behavioral
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

-- Program Counter module that acts like input to the RISCV
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity PC is
    Port(PC_in: in STD_LOGIC_VECTOR(31 downto 0);
         clk: in STD_LOGIC;
         rst: in STD_LOGIC;
         PC_out: out STD_LOGIC_VECTOR(31 downto 0));
end PC;

architecture Behavioral of PC is

begin
process(clk,rst)
begin
    if rst='0' then
        --PC_out<=(others=>'0');
        PC_out<= X"00000000";    --hexadecimal 8x4bits=32bits
    else
        if rising_edge(clk) then
            PC_out<=PC_in;    --D flilflop register
        end if;
    end if;
end process;


end Behavioral;
