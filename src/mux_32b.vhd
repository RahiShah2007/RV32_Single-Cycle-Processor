----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 11:23:51
-- Design Name: 
-- Module Name: mux_32b - Behavioral
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

entity mux_32b is
    Port ( I0 : in STD_LOGIC_VECTOR(31 downto 0);
           I1 : in STD_LOGIC_VECTOR (31 downto 0);
           S : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (31 downto 0));
end mux_32b;

architecture Behavioral of mux_32b is
signal X: STD_LOGIC_VECTOR(31 downto 0);
begin
process(I0,I1,S)
begin
    case S is
        when '0'=> X <= I0;
        when '1'=> X <= I1;
        when others => X <= I0;
    end case;
end process;
Y <= X;

end Behavioral;
