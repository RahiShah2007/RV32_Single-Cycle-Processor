----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 14:47:01
-- Design Name: 
-- Module Name: Mux2Reg - Behavioral
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

entity Mux2Reg is
 Port ( I0  : in  STD_LOGIC_VECTOR (31 downto 0);
       I1  : in  STD_LOGIC_VECTOR (31 downto 0);
       I2  : in  STD_LOGIC_VECTOR (31 downto 0);
       I3  : in  STD_LOGIC_VECTOR (31 downto 0);
       I4  : in  STD_LOGIC_VECTOR (31 downto 0);
       I5  : in  STD_LOGIC_VECTOR (31 downto 0);
       sel : in  STD_LOGIC_VECTOR (2 downto 0);
       Y   : out STD_LOGIC_VECTOR (31 downto 0) );
end Mux2Reg;

architecture Behavioral of Mux2Reg is
signal X   : STD_LOGIC_VECTOR(31 downto 0);
signal sign : STD_LOGIC;
begin
process(sel, I0, I1, I2, I3, I4, I5, X)
    begin
        case sel is
            when "000"  => Y <= I0;
            when "001"  => Y <= X;
            when "010"  => Y <= I2;
            when "011"  => Y <= I3;
            when "100"  => Y <= I4;
            when "101"  => Y <= I5;
            when others => Y <= I0;
        end case;
    end process;
    sign<=I1(7);
    X   <= (I1 or X"FFFFFF00") when sign = '1' else (I1 and X"000000FF");

end Behavioral;
