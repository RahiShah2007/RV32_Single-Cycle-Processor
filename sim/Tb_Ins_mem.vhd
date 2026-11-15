----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2026 18:40:14
-- Design Name: 
-- Module Name: Tb_Ins_mem - Behavioral
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

entity Tb_Ins_mem is

end Tb_Ins_mem;

architecture Behavioral of Tb_Ins_mem is

    component Ins_mem
        port (
            Address     : in  std_logic_vector(15 downto 0);
            inst : out std_logic_vector(31 downto 0)
        );
    end component;

   
    signal Address_tb     : std_logic_vector(15 downto 0) := (others => '0');
    signal instruction_tb : std_logic_vector(31 downto 0);

begin

    
    uut: Ins_mem
        port map (
            Address     => Address_tb,
            inst => instruction_tb
        );

    
    stim_proc: process
    begin
        
        Address_tb <= x"0000";
        wait for 10 ns;

      
        Address_tb <= x"0004";
        wait for 10 ns;

       
        Address_tb <= x"0008";
        wait for 10 ns;

        
        Address_tb <= x"000C";
        wait for 10 ns;

        
        Address_tb <= x"0010";
        wait for 10 ns;

        -- Jump directly to the start of the Fibonacci routine at Address 0x0050
        Address_tb <= x"0050";
        wait for 10 ns;

       
        Address_tb <= x"0054";
        wait for 10 ns;


        wait;
    end process;

end Behavioral;
