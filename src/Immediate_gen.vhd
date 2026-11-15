----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2026 18:17:38
-- Design Name: 
-- Module Name: Immediate_gen - Behavioral
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
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Immediate_gen is
    Port ( inst : in STD_LOGIC_VECTOR (31 downto 0);
           imm : out STD_LOGIC_VECTOR (31 downto 0));
end Immediate_gen;

architecture Behavioral of Immediate_gen is
signal opcode: STD_LOGIC_VECTOR(6 downto 0);
signal temp: STD_LOGIC_VECTOR(31 downto 0);
signal I_type,S_type,SB_type,UJ_type: STD_LOGIC_VECTOR(31 downto 0);
begin
process(inst,opcode,I_type,S_type,SB_type,UJ_type)
begin
    case opcode is
        when "0010011"=>temp<=I_type;
        when "0000011"=>temp<=I_type;
        when "0100011"=>temp<=S_type;
        when "1100011"=>temp<=SB_type;
        when "1100111"=>temp<=I_type;
        when "1101111"=>temp<=UJ_type;
        when others=>temp<=(others=>'0');
    end case;
end process;


 I_type <= X"00000" & inst(31 downto 20) when inst(31) = '0' else (X"FFFFF" & inst(31 downto 20));
 
 
 S_type <= X"00000" & ( inst(31 downto 25) & inst(11 downto 7) ) when inst(31) = '0' else
                  (X"FFFFF" & ( inst(31 downto 25) & inst(11 downto 7) ));


 SB_type <= X"00000" & ( inst(31) & inst(7) & inst(30 downto 25) & inst(11 downto 8) )
        when inst(31) = '0' else
        (X"FFFFF" & (inst(31) & inst(7) & inst(30 downto 25) & inst(11 downto 8)));
        
 UJ_type <= X"000" & ( inst(31) & inst(19 downto 12) & inst(20) & inst(30 downto 21) ) when 
 inst(31) = '0' else (X"FFF" & ( inst(31) & inst(19 downto 12) & inst(20) & inst(30 downto 21)) );


 opcode <= inst(6 downto 0);
 imm <= temp;
end Behavioral;
