library IEEE;
use IEEE.std_logic_1164.all;

entity simple_mips is
port(i_CLK			: in std_logic;
     i_WrS, i_RdS1, i_RdS2	: in std_logic_vector(4 downto 0);
     nAdd_Sub, ALUSrc, i_WrE	: in std_logic;
     imm			: in std_logic_vector(31 downto 0);
     o_Cout			: out std_logic);
end simple_mips;

architecture structure of simple_mips is

component add_sub
port(i_A, i_reg, imm	: in  std_logic_vector(31 downto 0);
     ALUSrc, nAdd_Sub	: in std_logic;
     o_Sum		: out std_logic_vector(31 downto 0);
     o_Cout		: out std_logic);
end component;

component reg_file
port(i_CLK			: in std_logic;
     i_WrS, i_RdS1, i_RdS2	: in std_logic_vector(4 downto 0);
     i_WrE			: in std_logic;
     i_WrD, i_RST		: in std_logic_vector(31 downto 0);
     o_RdD1, o_RdD2		: out  std_logic_vector(31 downto 0));
end component;

signal s_RdD1, s_RdD2, s_F, s_RST		:  std_logic_vector(31 downto 0);

begin

ALU : add_sub
port map(i_A => s_RdD1,
	 i_reg => s_RdD2,
	 imm => imm,
	 ALUSrc => ALUSrc,
	 nAdd_Sub => nAdd_Sub,
	 o_Sum => s_F,
	 o_Cout => o_Cout);


REG : reg_file
port map(i_CLK => i_CLK,
	 i_RST => s_RST,
	 i_WrS => i_WrS,
	 i_RdS1 => i_RdS1,
	 i_RdS2 => i_RdS2,
	 i_WrE => i_WrE,
	 i_WrD => s_F,
	 o_RdD1 => s_RdD1,
	 o_RdD2 => s_RdD2);

end structure;
