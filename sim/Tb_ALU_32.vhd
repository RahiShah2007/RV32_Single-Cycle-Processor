----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 13:37:08
-- Design Name: 
-- Module Name: Tb_ALU_32 - Behavioral
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

entity Tb_ALU_32 is
end Tb_ALU_32;

architecture Behavioral of Tb_ALU_32 is

    component ALU_32
        Port ( 
            op1        : in  STD_LOGIC_VECTOR (31 downto 0);
            op2        : in  STD_LOGIC_VECTOR (31 downto 0);
            ALU_opcode : in  STD_LOGIC_VECTOR (2 downto 0);
            res        : out STD_LOGIC_VECTOR (31 downto 0);
            zero       : out STD_LOGIC;
            Cout       : out STD_LOGIC;
            sign       : out STD_LOGIC
        );
    end component;

    signal op1_tb        : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal op2_tb        : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal ALU_opcode_tb : STD_LOGIC_VECTOR (2 downto 0)  := (others => '0');
    signal res_tb        : STD_LOGIC_VECTOR (31 downto 0);
    signal zero_tb       : STD_LOGIC;
    signal Cout_tb       : STD_LOGIC;
    signal sign_tb       : STD_LOGIC;

begin

    uut: ALU_32
        Port map (
            op1        => op1_tb,
            op2        => op2_tb,
            ALU_opcode => ALU_opcode_tb,
            res        => res_tb,
            zero       => zero_tb,
            Cout       => Cout_tb,
            sign       => sign_tb
        );

    stim_proc: process
    begin
        op1_tb <= x"0000000A";
        op2_tb <= x"00000003";

        ALU_opcode_tb <= "000";
        wait for 10 ns;

        ALU_opcode_tb <= "001";
        wait for 10 ns;

        ALU_opcode_tb <= "010";
        wait for 10 ns;

        ALU_opcode_tb <= "011";
        wait for 10 ns;

        ALU_opcode_tb <= "100";
        wait for 10 ns;

        ALU_opcode_tb <= "101";
        wait for 10 ns;

        ALU_opcode_tb <= "110";
        wait for 10 ns;

        op1_tb <= x"00000050";
        ALU_opcode_tb <= "111";
        wait for 10 ns;

        op1_tb <= x"00000007";
        op2_tb <= x"00000007";
        ALU_opcode_tb <= "101";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
