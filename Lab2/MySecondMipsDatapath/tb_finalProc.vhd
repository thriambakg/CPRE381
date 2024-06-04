library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mips_mem_proc is
   generic(gCLK_HPER	: time := 50 ns);
end tb_mips_mem_proc;

architecture behavior of tb_mips_mem_proc is

constant cCLK_PER	: time := gCLK_HPER * 2;

component mips_mem_proc
port(i_RdS1, i_RdS2, i_WrS							: in std_logic_vector(4 downto 0);
     i_ALU_op, i_ALUSrc, i_Reg_WrE, i_Mem_WrE, i_Reg_In_Sel, i_CLK, i_Signed	: in std_logic;
     imm									: in std_logic_vector(15 downto 0);
     i_reg_RST									: in std_logic_vector(31 downto 0));
end component;

signal s_RdS1, s_RdS2, s_WrS							: std_logic_vector(4 downto 0);
signal s_ALU_op, s_ALUSrc, s_Reg_WrE, s_Mem_WrE, s_Reg_In_Sel, s_CLK, s_Signed	: std_logic;
signal s_imm									: std_logic_vector(15 downto 0);
signal s_reg_RST								: std_logic_vector(31 downto 0);

begin

proc : mips_mem_proc
port map(i_RdS1 => s_RdS1,
	 i_RdS2 => s_RdS2,
	 i_WrS => s_WrS,
	 i_ALU_op => s_ALU_op,
	 i_ALUSrc => s_ALUSrc,
	 i_Reg_WrE => s_Reg_WrE,
	 i_Mem_WrE => s_Mem_WrE,
	 i_Reg_In_Sel => s_Reg_In_Sel,
	 i_CLK => s_CLK,
	 i_Signed => s_Signed,
	 i_reg_RST => s_reg_RST,
	 imm => s_imm);

  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;

  P_TB: process
  begin

    --reset
    s_RdS1 <= "00000";
    s_RdS2 <= "00000";
    s_WrS <= "00000";
    s_ALU_op <= '0';
    s_ALUSrc <= '0';
    s_Reg_WrE <= '0';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '0';
    s_imm <= X"0000";
    s_reg_RST <= X"11111111";
    wait for cCLK_PER;

    --addi $25, $0, 0
    s_RdS1 <= "00000";
    s_RdS2 <= "00000";
    s_WrS <= "11001";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0000";
    s_reg_RST <= X"00000000";
    wait for cCLK_PER;

    --addi $26, $0, 256
    s_RdS1 <= "00000";
    s_RdS2 <= "00000";
    s_WrS <= "11010";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0100";
    wait for cCLK_PER;

    --lw $1, 0($25)
    s_RdS1 <= "11001";
    s_RdS2 <= "00000";
    s_WrS <= "00001";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '1';
    s_Signed <= '1';
    s_imm <= X"0000";
    wait for cCLK_PER;

    --lw $2, 4($25)
    s_RdS1 <= "11001";
    s_RdS2 <= "00000";
    s_WrS <= "00010";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '1';
    s_Signed <= '1';
    s_imm <= X"0004";
    wait for cCLK_PER;

    --add $1, $1, $2
    s_RdS1 <= "00001";
    s_RdS2 <= "00010";
    s_WrS <= "00001";
    s_ALU_op <= '0';
    s_ALUSrc <= '0';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0100";
    wait for cCLK_PER;

    --sw $1, 0($26)
    s_RdS1 <= "11010"; --base mem address
    s_RdS2 <= "00001"; --data to store
    s_WrS <= "00010"; 
    s_ALU_op <= '0'; --add
    s_ALUSrc <= '1'; --add immediate
    s_Reg_WrE <= '0'; --don't write to reg
    s_Mem_WrE <= '1'; --write to mem
    s_Reg_In_Sel <= '1';
    s_Signed <= '1'; --immediate is signed value
    s_imm <= X"0000"; --offset
    wait for cCLK_PER;

    --lw $2, 8($25)
    s_RdS1 <= "11001";
    s_RdS2 <= "00000";
    s_WrS <= "00010";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '1';
    s_Signed <= '1';
    s_imm <= X"0008";
    wait for cCLK_PER;

    --add $1, $1, $2
    s_RdS1 <= "00001";
    s_RdS2 <= "00010";
    s_WrS <= "00001";
    s_ALU_op <= '0';
    s_ALUSrc <= '0';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0100";
    wait for cCLK_PER;

    --sw $1, 4($26)
    s_RdS1 <= "11010"; --base mem address
    s_RdS2 <= "00001"; --data to store
    s_WrS <= "00010"; 
    s_ALU_op <= '0'; --add
    s_ALUSrc <= '1'; --add immediate
    s_Reg_WrE <= '0'; --don't write to reg
    s_Mem_WrE <= '1'; --write to mem
    s_Reg_In_Sel <= '1';
    s_Signed <= '1'; --immediate is signed value
    s_imm <= X"0004"; --offset
    wait for cCLK_PER;

    --lw $2, 12($25)
    s_RdS1 <= "11001";
    s_RdS2 <= "00000";
    s_WrS <= "00010";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '1';
    s_Signed <= '1';
    s_imm <= X"000C";
    wait for cCLK_PER;

    --add $1, $1, $2
    s_RdS1 <= "00001";
    s_RdS2 <= "00010";
    s_WrS <= "00001";
    s_ALU_op <= '0';
    s_ALUSrc <= '0';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0100";
    wait for cCLK_PER;

    --sw $1, 8($26)
    s_RdS1 <= "11010"; --base mem address
    s_RdS2 <= "00001"; --data to store
    s_WrS <= "00010"; 
    s_ALU_op <= '0'; --add
    s_ALUSrc <= '1'; --add immediate
    s_Reg_WrE <= '0'; --don't write to reg
    s_Mem_WrE <= '1'; --write to mem
    s_Reg_In_Sel <= '1';
    s_Signed <= '1'; --immediate is signed value
    s_imm <= X"0008"; --offset
    wait for cCLK_PER;

    --lw $2, 16($25)
    s_RdS1 <= "11001";
    s_RdS2 <= "00000";
    s_WrS <= "00010";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '1';
    s_Signed <= '1';
    s_imm <= X"0010";
    wait for cCLK_PER;

    --add $1, $1, $2
    s_RdS1 <= "00001";
    s_RdS2 <= "00010";
    s_WrS <= "00001";
    s_ALU_op <= '0';
    s_ALUSrc <= '0';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0100";
    wait for cCLK_PER;

    --sw $1, 12($26)
    s_RdS1 <= "11010"; --base mem address
    s_RdS2 <= "00001"; --data to store
    s_WrS <= "00010"; 
    s_ALU_op <= '0'; --add
    s_ALUSrc <= '1'; --add immediate
    s_Reg_WrE <= '0'; --don't write to reg
    s_Mem_WrE <= '1'; --write to mem
    s_Reg_In_Sel <= '1';
    s_Signed <= '1'; --immediate is signed value
    s_imm <= X"000C"; --offset
    wait for cCLK_PER;

    --lw $2, 20($25)
    s_RdS1 <= "11001";
    s_RdS2 <= "00000";
    s_WrS <= "00010";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '1';
    s_Signed <= '1';
    s_imm <= X"0014";
    wait for cCLK_PER;

    --add $1, $1, $2
    s_RdS1 <= "00001";
    s_RdS2 <= "00010";
    s_WrS <= "00001";
    s_ALU_op <= '0';
    s_ALUSrc <= '0';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0100";
    wait for cCLK_PER;

    --sw $1, 16($26)
    s_RdS1 <= "11010"; --base mem address
    s_RdS2 <= "00001"; --data to store
    s_WrS <= "00010"; 
    s_ALU_op <= '0'; --add
    s_ALUSrc <= '1'; --add immediate
    s_Reg_WrE <= '0'; --don't write to reg
    s_Mem_WrE <= '1'; --write to mem
    s_Reg_In_Sel <= '1';
    s_Signed <= '1'; --immediate is signed value
    s_imm <= X"0010"; --offset
    wait for cCLK_PER;

    --lw $2, 24($25)
    s_RdS1 <= "11001";
    s_RdS2 <= "00000";
    s_WrS <= "00010";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '1';
    s_Signed <= '1';
    s_imm <= X"0018";
    wait for cCLK_PER;

    --add $1, $1, $2
    s_RdS1 <= "00001";
    s_RdS2 <= "00010";
    s_WrS <= "00001";
    s_ALU_op <= '0';
    s_ALUSrc <= '0';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0100";
    wait for cCLK_PER;

    --addi $27, $0, 512
    s_RdS1 <= "00000";
    s_RdS2 <= "00000";
    s_WrS <= "11011";
    s_ALU_op <= '0';
    s_ALUSrc <= '1';
    s_Reg_WrE <= '1';
    s_Mem_WrE <= '0';
    s_Reg_In_Sel <= '0';
    s_Signed <= '1';
    s_imm <= X"0200";
    wait for cCLK_PER;

    --sw $1, -4($27)
    s_RdS1 <= "11011"; --base mem address
    s_RdS2 <= "00001"; --data to store
    s_WrS <= "00010"; 
    s_ALU_op <= '1'; --subtract
    s_ALUSrc <= '1'; --subtract immediate
    s_Reg_WrE <= '0'; --don't write to reg
    s_Mem_WrE <= '1'; --write to mem
    s_Reg_In_Sel <= '1';
    s_Signed <= '1'; --immediate is signed value
    s_imm <= X"0004"; --offset
    wait for cCLK_PER;

-----------------------------------------------



    wait;
  end process;
  
end behavior;
