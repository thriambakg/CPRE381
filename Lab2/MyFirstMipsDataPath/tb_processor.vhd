library IEEE;
use IEEE.std_logic_1164.all;

entity tb_reg_file is
  generic(gCLK_HPER   : time := 50 ns);
end tb_reg_file;

architecture behavior of tb_reg_file is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

entity simple_mips is
port(i_CLK			: in std_logic;
     i_WrS, i_RdS1, i_RdS2	: in std_logic_vector(4 downto 0);
     nAdd_Sub, ALUSrc, i_WrE	: in std_logic;
     imm			: in std_logic_vector(31 downto 0);
     o_Cout			: out std_logic);
end simple_mips;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, sAdd_Sub, s_ALUsrc, so_Cout, s_regWrite  : std_logic;
  signal s_I2, s_I1, s_regDst : std_logic_vector(4 downto 0);
  signal s_imm : std_logic_vector(31 downto 0);

begin

  DUT: reg_file
  port map(i_CLK => s_CLK, 
           i_WrS   => s_regDst,
		   i_WrE  => s_regWrite,
           i_RdS1   => s_I1,
           i_RdS2  =>  s_I2,
           nAdd_Sub   => sAdd_Sub,
           ALUSrc   => s_ALUsrc,
           o_Cout  =>  so_Cout,
		   imm => s_imm);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
    -- addi $1,0,1
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= '1';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;

    -- addi $2,0,2
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '2';
	s_regDst <= '2';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;

    -- addi $3,0,3
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= '3';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;

  -- addi $4,0,4
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= '4';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;

-- addi $5,0,5
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= '5';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;
	
	-- addi $6,0,6
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= '6';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;
	
	-- addi $7,0,7
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= '7';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;
	
	-- addi $8,0,8
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= '8';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;
	
	-- addi $9,0,9
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= '9';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;
	
	-- addi $10,0,10
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '1';
	s_regDst <= 'A';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;
	
	-- add $11,$1,$2
    s_I1 <= '1';
	s_I2 <= '2';
	s_imm <= 'x';
	s_regDst <= 'B';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- sub $12,$11,$3
    s_I1 <= '3';
	s_I2 <= '3';
	s_imm <= 'x';
	s_regDst <= 'C';
	s_regWrite <= '1';
	sAdd_Sub <= '1';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- add 13,12,4
    s_I1 <= '0';
	s_I2 <= '4';
	s_imm <= '1';
	s_regDst <= 'D';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- sub 14,13,5
    s_I1 <= '4';
	s_I2 <= '5';
	s_imm <= '1';
	s_regDst <= 'E';
	s_regWrite <= '1';
	sAdd_Sub <= '1';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- add 15,14,6
    s_I1 <= 'D';
	s_I2 <= '6';
	s_imm <= '1';
	s_regDst <= 'F';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- sub 16,15,7
    s_I1 <= '5';
	s_I2 <= '7';
	s_imm <= '1';
	s_regDst <= '16';
	s_regWrite <= '1';
	sAdd_Sub <= '1';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- add 17,16,8
    s_I1 <= '1101';
	s_I2 <= '8';
	s_imm <= '1';
	s_regDst <= '17';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- sub 18,17,9
    s_I1 <= '6';
	s_I2 <= '9';
	s_imm <= '1';
	s_regDst <= '18';
	s_regWrite <= '1';
	sAdd_Sub <= '1';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- add 19,18,10
    s_I1 <= '1100';
	s_I2 <= 'A';
	s_imm <= '1';
	s_regDst <= '19';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	
	-- addi 20,0,-35
    s_I1 <= '0';
	s_I2 <= 'x';
	s_imm <= '-35';
	s_regDst <= '20';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '1';
    wait for cCLK_PER;
	
	-- add 21,19,20
    s_I1 <= '7';
	s_I2 <= '-35';
	s_imm <= '1';
	s_regDst <= '21';
	s_regWrite <= '1';
	sAdd_Sub <= '0';
	s_ALUsrc <= '0';
    wait for cCLK_PER;
	

    wait;
  end process;
  
end behavior;