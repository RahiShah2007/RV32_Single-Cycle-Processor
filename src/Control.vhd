----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2026 15:09:34
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
    Port ( opcode : in STD_LOGIC_VECTOR (6 downto 0);
           function_3 : in STD_LOGIC_VECTOR (2 downto 0); -- 3bit function to execute arithmetic function such as add,xor,and
           function_7 : in STD_LOGIC_VECTOR (6 downto 0); -- 7 bit opcode differentiator if funct3 and opcode are same
           jump : out STD_LOGIC;
           to_reg : out STD_LOGIC_VECTOR (2 downto 0);
           mem_write : out STD_LOGIC;
           branch : out STD_LOGIC_VECTOR (2 downto 0);
           alu_op : out STD_LOGIC_VECTOR (2 downto 0);
           alu_src : out STD_LOGIC;
           store_sel : out STD_LOGIC;
           write_reg : out STD_LOGIC);
end Control;

architecture Behavioral of Control is

begin
process(opcode,function_3,function_7)
begin
    case opcode is
        when "0110011"=>  --R type instruction
            case function_3 is
                when "000"=>
                    case function_7 is
                        when "0000000"=>
                            jump<='0';
                            branch<="000";
                            to_reg<="000";
                            mem_write<='0';
                            store_sel<='0';
                            alu_src<='1';
                            alu_op<="100";
                            write_reg<='1';
                        when "0100000"=>
                            jump<='0';
                            branch<="000";
                            to_reg<="000";
                            mem_write<='0';
                            store_sel<='0';
                            alu_src<='1';
                            alu_op<="101";
                            write_reg<='1';
                        when others=>
                            jump<='0';
                            branch<="000";
                            to_reg<="000";
                            mem_write<='0';
                            store_sel<='0';
                            alu_src<='0';
                            alu_op<="000";
                            write_reg<='0';
                    end case;
                when "001"=>  -- Shift Left Logic
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="110";
                    write_reg<='1';        
                when "010"=> -- Set Less Than
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="011";
                    write_reg<='1';
                when "100"=>  --XOR
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="010";
                    write_reg<='1';
                when "101"=>      --Shift right logical
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="111";
                    write_reg<='1';
                when "110"=>              --OR
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="001";
                    write_reg<='1';
                when "111"=>
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="000";
                    write_reg<='1';
                when others=>
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="000";
                    write_reg<='0';
            end case;
        when "0010011"=> -- I type instructions
            case function_3 is
                when"000"=> --add immediate
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="100";
                    write_reg<='1';
                when"111"=>  -- and immediate
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="000";
                    write_reg<='1';
                when "100"=> --XOR immediate      
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="010";
                    write_reg<='1';
                when "110"=> -- OR immediate
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="001";
                    write_reg<='1';
                when others=>
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="000";
                    write_reg<='0';
            end case;
            when "0000011"=>   --I type loads
            case function_3 is
                when "000"=>  --LB
                    jump<='0';
                    branch<="000";
                    to_reg<="001";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="100";
                    write_reg<='1';
                when "010"=>  --LW
                    jump<='0';
                    branch<="000";
                    to_reg<="010";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="100";
                    write_reg<='1';
                when others=>
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="000";
                    write_reg<='0';
            end case;
            when "0100011"=>    --stores
            case function_3 is
                when "000"=>
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='1';
                    store_sel<='1';
                    alu_src<='0';
                    alu_op<="100";
                    write_reg<='0';
                when "010"=>
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='1';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="100";
                    write_reg<='0';
                when others=>
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="000";
                    write_reg<='0';
            end case;
            when "1100011"=>
            case function_3 is
                when "000"=> --BEQ
                    jump<='0';
                    branch<="001";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="101";
                    write_reg<='0';
                when "001"=> --BNQ
                    jump<='0';
                    branch<="010";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="101";
                    write_reg<='0';
                when "100"=> -- BLT
                    jump<='0';
                    branch<="011";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="101";
                    write_reg<='0';
                when "101"=>   -- BGT
                    jump<='0';
                    branch<="100";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='1';
                    alu_op<="101";
                    write_reg<='0';
                when others=>
                    jump<='0';
                    branch<="000";
                    to_reg<="000";
                    mem_write<='0';
                    store_sel<='0';
                    alu_src<='0';
                    alu_op<="000";
                    write_reg<='0';
            end case;
            when "1100111"=>
                jump<='1';
                branch<="101";
                to_reg<="011";
                mem_write<='0';
                store_sel<='0';
                alu_src<='1';
                alu_op<="101";
                write_reg<='1';
            when "1101111"=>
                jump<='0';
                branch<="110";
                to_reg<="101";
                mem_write<='0';
                store_sel<='0';
                alu_src<='1';
                alu_op<="101";
                write_reg<='0';
            when others=>
                jump<='0';
                branch<="000";
                to_reg<="000";
                mem_write<='0';
                store_sel<='0';
                alu_src<='0';
                alu_op<="000";
                write_reg<='0';
        end case;                                                                      
end process;
end Behavioral;