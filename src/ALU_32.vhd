----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 11:39:49
-- Design Name: 
-- Module Name: ALU_32 - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_32 is
    Port ( op1 : in STD_LOGIC_VECTOR (31 downto 0);
           op2 : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_opcode : in STD_LOGIC_VECTOR (2 downto 0);
           res : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC;
           Cout : out STD_LOGIC;
           sign : out STD_LOGIC);
end ALU_32;

architecture Behavioral of ALU_32 is
   signal alu_res : STD_LOGIC_VECTOR(31 downto 0);
   signal temp_sign : STD_LOGIC_VECTOR(31 downto 0); 
   signal sub : STD_LOGIC_VECTOR(32 downto 0);
   signal add : STD_LOGIC_VECTOR(32 downto 0);
   signal sft_nb: STD_LOGIC_VECTOR(4 downto 0);
   signal shift1_l, shift2_l, shift4_l, shift8_l, shift16_l : STD_LOGIC_VECTOR(31 downto 0);
   signal shift1_r, shift2_r, shift4_r, shift8_r, shift16_r : STD_LOGIC_VECTOR(31 downto 0);
begin
process(op1,op2,ALU_opcode,add,sub,shift16_l,shift16_r,temp_sign)
begin
    case ALU_opcode is
        when "000" => alu_res<=op1 AND op2;
        when "001" => alu_res<= op1 OR op2;
        when "010"=> alu_res<= op1 XOR op2;
        when "011"=> alu_res<= temp_sign;
        when "100" => alu_res <= add(31 downto 0);
        when "101" => alu_res <= sub(31 downto 0);
        when "110"=> alu_res<= shift16_l;
        when "111"=> alu_res<= shift16_r;
        when others=> alu_res<= op1;
    end case; 
end process;

zero<='1' when alu_res = X"00000000" else '0';
sign<= alu_res(31);
temp_sign<=X"00000001" when sub(31)='1' else X"00000000";
add<=('0'& op1)+('0'& op2); 
sub<=('0' & op1) - ('0' & op2);
Cout<= add(32) when ALU_opcode="100" else sub(32);
res<= alu_res; 


shift1_r  <= '0' & op1(31 downto 1) when sft_nb(0) = '1' else op1;
shift2_r  <= "00" & shift1_r(31 downto 2) when sft_nb(1) = '1' else shift1_r;
shift4_r  <= x"0" & shift2_r(31 downto 4) when sft_nb(2) = '1' else shift2_r;
shift8_r  <= x"00" & shift4_r(31 downto 8)  when sft_nb(3) = '1' else shift4_r;
shift16_r <= x"0000" & shift8_r(31 downto 16) when sft_nb(4) = '1' else shift8_r;


 sft_nb <= op2(4 downto 0);                                                                                                          --vector to put zeros in right
shift1_l  <= op1(30 downto 0) & '0' when sft_nb(0) = '1' else op1;    
shift2_l  <= shift1_l(29 downto 0) & "00" when sft_nb(1) = '1' else shift1_l;       
shift4_l  <= shift2_l(27 downto 0) & x"0" when sft_nb(2) = '1' else shift2_l;       
shift8_l  <= shift4_l(23 downto 0) & x"00" when sft_nb(3) = '1' else shift4_l;      
shift16_l <= shift8_l(15 downto 0) & x"0000" when sft_nb(4) = '1' else shift8_l;    
end Behavioral;
