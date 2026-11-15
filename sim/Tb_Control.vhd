----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2026 17:38:44
-- Design Name: 
-- Module Name: Tb_Control - Behavioral
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

entity Tb_Control is
end Tb_Control;

architecture Behavioral of Tb_Control is

 
    component Control
        Port ( 
            opcode     : in  STD_LOGIC_VECTOR (6 downto 0);
            function_3 : in  STD_LOGIC_VECTOR (2 downto 0);
            function_7 : in  STD_LOGIC_VECTOR (6 downto 0);
            jump       : out STD_LOGIC;
            to_reg     : out STD_LOGIC_VECTOR (2 downto 0);
            mem_write  : out STD_LOGIC;
            branch     : out STD_LOGIC_VECTOR (2 downto 0);
            alu_op     : out STD_LOGIC_VECTOR (2 downto 0);
            alu_src    : out STD_LOGIC;
            store_sel  : out STD_LOGIC;
            write_reg  : out STD_LOGIC
        );
    end component;

    
    signal opcode_tb     : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal function_3_tb : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
    signal function_7_tb : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');

    signal jump_tb       : STD_LOGIC;
    signal to_reg_tb     : STD_LOGIC_VECTOR (2 downto 0);
    signal mem_write_tb  : STD_LOGIC;
    signal branch_tb     : STD_LOGIC_VECTOR (2 downto 0);
    signal alu_op_tb     : STD_LOGIC_VECTOR (2 downto 0);
    signal alu_src_tb    : STD_LOGIC;
    signal store_sel_tb  : STD_LOGIC;
    signal write_reg_tb  : STD_LOGIC;

begin

    
    uut: Control
        Port map (
            opcode     => opcode_tb,
            function_3 => function_3_tb,
            function_7 => function_7_tb,
            jump       => jump_tb,
            to_reg     => to_reg_tb,
            mem_write  => mem_write_tb,
            branch     => branch_tb,
            alu_op     => alu_op_tb,
            alu_src    => alu_src_tb,
            store_sel  => store_sel_tb,
            write_reg  => write_reg_tb
        );

   
    stim_proc: process
    begin
        -- Test 1: R-Type ADD (alu_op = "100", alu_src = '1', write_reg = '1')
        opcode_tb     <= "0110011";
        function_3_tb <= "000";
        function_7_tb <= "0000000";
        wait for 10 ns;

        -- Test 2: R-Type SUB (alu_op = "101", alu_src = '1', write_reg = '1')
        opcode_tb     <= "0110011";
        function_3_tb <= "000";
        function_7_tb <= "0100000";
        wait for 10 ns;

        -- Test 3: R-Type OR - Verifying your bug fix! (alu_op = "001")
        opcode_tb     <= "0110011";
        function_3_tb <= "110";
        function_7_tb <= "0000000";
        wait for 10 ns;

        -- Test 4: I-Type ADDI (alu_op = "100", alu_src = '0', write_reg = '1')
        opcode_tb     <= "0010011";
        function_3_tb <= "000";
        function_7_tb <= "0000000";
        wait for 10 ns;

        -- Test 5: I-Type ORI - Verifying your bug fix! (alu_op = "001")
        opcode_tb     <= "0010011";
        function_3_tb <= "110";
        function_7_tb <= "0000000";
        wait for 10 ns;

        -- Test 6: Load Word LW (to_reg = "010", alu_src = '0', write_reg = '1')
        opcode_tb     <= "0000011";
        function_3_tb <= "010";
        wait for 10 ns;

        -- Test 7: Store Byte SB (mem_write = '1', store_sel = '1', write_reg = '0')
        opcode_tb     <= "0100011";
        function_3_tb <= "000";
        wait for 10 ns;

        -- Test 8: Branch Equal BEQ (branch = "001", alu_op = "101", write_reg = '0')
        opcode_tb     <= "1100011";
        function_3_tb <= "000";
        wait for 10 ns;

        -- Test 9: JALR (jump = '1', branch = "101", to_reg = "011", write_reg = '1')
        opcode_tb     <= "1100111";
        function_3_tb <= "000";
        wait for 10 ns;

        -- Test 10: JAL (jump = '0', branch = "110", to_reg = "101", write_reg = '0')
        opcode_tb     <= "1101111";
        wait for 10 ns;

        
        wait;
    end process;

end Behavioral;

