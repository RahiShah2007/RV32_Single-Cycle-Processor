----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2026 14:58:15
-- Design Name: 
-- Module Name: Datapath_Top - Behavioral
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

entity DataPath is
    port (
        clk : in std_logic;
        rst : in std_logic;
        led: out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity DataPath;

architecture Structural of DataPath is

    component PC
        Port (
            PC_in  : in  STD_LOGIC_VECTOR(31 downto 0);
            clk    : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            PC_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Ins_mem
        port (
            address     : in  std_logic_vector(15 downto 0);
            inst : out std_logic_vector(31 downto 0)
        );
    end component;

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

    component Immediate_gen
        Port ( 
            inst : in  STD_LOGIC_VECTOR (31 downto 0);
            imm  : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    component reg
        Port ( 
            clk   : in  STD_LOGIC;
            WR    : in  STD_LOGIC;
            SR1   : in  STD_LOGIC_VECTOR (4 downto 0);
            SR2   : in  STD_LOGIC_VECTOR (4 downto 0);
            DR    : in  STD_LOGIC_VECTOR (4 downto 0);
            data  : in  STD_LOGIC_VECTOR (31 downto 0);
            read1 : out STD_LOGIC_VECTOR (31 downto 0);
            read2 : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    component mux_32b
        Port ( 
            I0 : in  STD_LOGIC_VECTOR (31 downto 0);
            I1 : in  STD_LOGIC_VECTOR (31 downto 0);
            S  : in  STD_LOGIC;
            Y  : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

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

    component Branch_ctrl
        Port ( 
            br    : in  STD_LOGIC_VECTOR (2 downto 0);
            zero  : in  STD_LOGIC;
            sign  : in  STD_LOGIC;
            PC_op : out STD_LOGIC
        );
    end component;

    component Data_memory
        Port ( 
            clk      : in  STD_LOGIC;
            wr_en    : in  STD_LOGIC;
            adr      : in  STD_LOGIC_VECTOR (3 downto 0);
            data_in  : in  STD_LOGIC_VECTOR (31 downto 0);
            data_out : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    component Mux2Reg
        Port ( 
            I0  : in  STD_LOGIC_VECTOR (31 downto 0);
            I1  : in  STD_LOGIC_VECTOR (31 downto 0);
            I2  : in  STD_LOGIC_VECTOR (31 downto 0);
            I3  : in  STD_LOGIC_VECTOR (31 downto 0);
            I4  : in  STD_LOGIC_VECTOR (31 downto 0);
            I5  : in  STD_LOGIC_VECTOR (31 downto 0);
            sel : in  STD_LOGIC_VECTOR (2 downto 0);
            Y   : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    signal PCOut, PCOutPlus          : std_logic_vector(31 downto 0);
    signal instruction               : std_logic_vector(31 downto 0);
    signal PCIn                      : std_logic_vector(31 downto 0);
    signal regData1, regData2        : std_logic_vector(31 downto 0);
    signal signo, zero, carry        : std_logic;
    signal result, dataIn            : std_logic_vector(31 downto 0);
    signal immediate                 : std_logic_vector(31 downto 0);
    signal dataOut                   : std_logic_vector(31 downto 0);
    signal jump, memWrite            : std_logic;
    signal StoreSel, ALUSrc          : std_logic;
    signal writeReg, PCSrc           : std_logic;
    signal toRegister, Branch, ALUOp : std_logic_vector(2 downto 0);
    signal dataForReg                : std_logic_vector(31 downto 0);
    signal op2                       : std_logic_vector(31 downto 0);
    signal offset                    : std_logic_vector(31 downto 0);
    signal regData2Anded             : std_logic_vector(31 downto 0);
    signal newAddress                : std_logic_vector(31 downto 0);
    signal shifted                   : std_logic_vector(31 downto 0);

begin

    PCount: PC 
        port map (PC_in => PCIn, clk => clk, rst => rst, PC_out => PCOut);

    ROM: Ins_mem
        port map (address => PCOut(15 downto 0), inst => instruction);

    Ctrl: Control 
        port map (
            opcode     => instruction(6 downto 0),
            function_3 => instruction(14 downto 12),
            function_7 => instruction(31 downto 25),
            jump       => jump,
            to_reg     => toRegister,
            mem_write  => memWrite,
            branch     => Branch,
            alu_op     => ALUOp,
            alu_src    => ALUSrc,
            store_sel  => StoreSel,
            write_reg  => writeReg
        );

    Imm: Immediate_gen 
        port map (inst => instruction, imm => immediate);

    RFILE: reg 
        port map (
            clk   => clk,
            WR    => writeReg,
            SR1   => instruction(19 downto 15),
            SR2   => instruction(24 downto 20),
            DR    => instruction(11 downto 7),
            data  => dataForReg,
            read1 => regData1,
            read2 => regData2
        );

    Mux0: mux_32b 
        port map (I0 => immediate, I1 => regData2, S => ALUSrc, Y => op2);

    ALU: ALU_32 
        port map (
            op1        => regData1,
            op2        => op2,
            ALU_opcode => ALUOp,
            res        => result,
            zero       => zero,
            Cout       => carry,
            sign       => signo
        );

    Mux1: mux_32b 
        port map (I0 => regData2, I1 => regData2Anded, S => StoreSel, Y => dataIn);

    RAM: Data_memory 
        port map (
            clk      => clk,
            wr_en    => memWrite,
            adr      => result(3 downto 0),
            data_in  => dataIn,
            data_out => dataOut
        );

    BRControl: Branch_ctrl 
        port map (br => Branch, sign => signo, zero => zero, PC_op => PCSrc);

    MuxReg: Mux2Reg 
        port map (
            I0  => result,
            I1  => dataOut,
            I2  => dataOut,
            I3  => PCOut,
            I4  => (others => '0'),
            I5  => PCOutPlus,
            sel => toRegister,
            Y   => dataForReg
        );

    Mux2: mux_32b 
        port map (I0 => immediate, I1 => result, S => jump, Y => offset);

    Mux3: mux_32b 
        port map (I0 => PCOutPlus, I1 => newAddress, S => PCSrc, Y => PCIn);

    regData2Anded <= regData2 and X"000000FF";
    PCOutPlus     <= PCOut + 4;
    shifted       <= offset(30 downto 0) & '0';
    newAddress    <= PCOut + shifted;


led<= result(7 downto 0);
end architecture Structural;


