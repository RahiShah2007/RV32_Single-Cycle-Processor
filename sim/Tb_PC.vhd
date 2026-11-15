----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.11.2026 15:13:45
-- Design Name: 
-- Module Name: Tb_PC - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Tb_PC is
end Tb_PC;

architecture Behavioral of Tb_PC is
component PC
        Port (
            PC_in  : in  STD_LOGIC_VECTOR (31 downto 0); 
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            PC_out : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    signal clk_tb   : STD_LOGIC := '0';
    signal rst_tb   : STD_LOGIC := '0';
    signal PC_in_tb  : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal PC_out_tb : STD_LOGIC_VECTOR (31 downto 0);

    constant CLK_PERIOD : time := 10 ns;
begin
    uut: PC
        Port map (
            clk   => clk_tb,
            rst   => rst_tb,
            PC_in  => PC_in_tb,
            PC_out => PC_out_tb
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
            rst_tb  <= '0';
            PC_in_tb <= x"00000004";
                wait for 20 ns;
                
            rst_tb <= '1';
                 wait for CLK_PERIOD;
                 
             PC_in_tb <= x"00000008";
                 wait for CLK_PERIOD; -- PCOut should become 0x00000008
                 
             PC_in_tb <= x"0000000C";
                wait for CLK_PERIOD; -- PCOut should become 0x0000000C
                 
                     
             PC_in_tb <= x"00000040";
                wait for CLK_PERIOD; -- PCOut should jump to 0x00000040
                 
                
             rst_tb <= '0';
                wait for CLK_PERIOD; -- PCOut should reset back to 0x00000000  
               wait;
    end process;
end Behavioral;
