----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 14:02:59
-- Design Name: 
-- Module Name: Data_memory - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Data_memory is
    Port ( clk : in STD_LOGIC;
           wr_en : in STD_LOGIC;
           adr : in STD_LOGIC_VECTOR (3 downto 0);
           data_in : in STD_LOGIC_VECTOR (31 downto 0);
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
end Data_memory;

architecture Behavioral of Data_memory is
type RAM is array (15 downto 0) of std_logic_vector(7 downto 0);
    signal MEM : RAM := (others => (others => '0'));
begin
    process(clk)
    begin
    if rising_edge(clk) then
        if (wr_en = '1') then
            MEM(conv_integer(adr))<= data_in(7 downto 0);
            MEM(conv_integer(adr+1))<= data_in(15 downto 8);
            MEM(conv_integer(adr+2))<= data_in(23 downto 16);
            MEM(conv_integer(adr+3))<= data_in(31 downto 24);
        end if;
    end if;
    end process;
    
    data_out <= MEM(conv_integer(adr+3)) & MEM(conv_integer(adr+2)) &
               MEM(conv_integer(adr+1)) & MEM(conv_integer(adr)); 


end Behavioral;
