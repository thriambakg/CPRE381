library IEEE;
use IEEE.std_logic_1164.all;

entity mips_mem_proc is
port(i_RdS1, i_RdS2, i_WrS							: in std_logic_vector(4 downto 0);
     i_ALU_op, i_ALUSrc, i_Reg_WrE, i_Mem_WrE, i_Reg_In_Sel, i_CLK, i_Signed	: in std_logic;
     imm									: in std_logic_vector(15 downto 0);
     i_reg_RST									: in std_logic_vector(31 downto 0));
end mips_mem_proc;

architecture structure of mips_mem_proc is

component reg_file
port(i_CLK			: in std_logic;
     i_WrS, i_RdS1, i_RdS2	: in std_logic_vector(4 downto 0);
     i_WrE			: in std_logic;
     i_WrD, i_RST		: in std_logic_vector(31 downto 0);
     o_RdD1, o_RdD2		: out  std_logic_vector(31 downto 0));
end component;

component add_sub
port(i_A, i_reg, imm	: in  std_logic_vector(31 downto 0);
     ALUSrc, nAdd_Sub	: in std_logic;
     o_Sum		: out std_logic_vector(31 downto 0);
     o_Cout		: out std_logic);
end component;

component extender_16_32
port(i_A		: in std_logic_vector(15 downto 0);
     i_signed		: in std_logic;
     o_F		: out std_logic_vector(31 downto 0));
end component;

component n_bit_mux2
generic(N : integer := 32);
port(i_A, i_B		: in std_logic_vector(N-1 downto 0);
     i_S		: in std_logic;
     o_F		: out std_logic_vector(N-1 downto 0));
end component;

component mem
generic(DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);
port(clk		: in std_logic;
     addr	        : in std_logic_vector((ADDR_WIDTH-1) downto 0);
     data	        : in std_logic_vector((DATA_WIDTH-1) downto 0);
     we			: in std_logic := '1';
     q			: out std_logic_vector((DATA_WIDTH-1) downto 0));
end component;

signal s_RdD1, s_RdD2, s_ext_imm, s_ALU_out, s_Mem_out, s_WrD	: std_logic_vector(31 downto 0);
--signal s_Mem_Addr						: std_logic_vector(9 downto 0);
signal s_Cout_void						: std_logic;

begin

--G1: for i in 0 to 9 generate
--	s_Mem_Addr(i) <= s_ALU_out(i);
--end generate;

reg : reg_file
port map(i_CLK => i_CLK,
	 i_WrD => s_WrD,
	 i_WrS => i_WrS,
	 i_RdS1 => i_RdS1,
	 i_RdS2 => i_RdS2,
	 i_WrE => i_Reg_WrE,
	 i_RST => i_reg_RST,
	 o_RdD1 => s_RdD1,
	 o_RdD2 => s_RdD2);

ALU : add_sub
port map(i_A => s_RdD1,
	 i_reg => s_RdD2,
	 imm => s_ext_imm,
	 ALUSrc => i_ALUSrc,
	 nAdd_Sub => i_ALU_op,
	 o_Sum => s_ALU_out,
	 o_Cout => s_Cout_void);

ext : extender_16_32
port map(i_A => imm,
	 i_signed => i_Signed,
	 o_F => s_ext_imm);

mem_mux : n_bit_mux2
port map(i_A => s_ALU_out,
	 i_B => s_Mem_out,
	 i_S => i_Reg_In_Sel,
	 o_F => s_WrD);

dmem : mem
port map(clk => i_CLK,
	 addr => s_ALU_out(11 downto 2),
	 data => s_RdD2,
	 we => i_Mem_WrE,
	 q => s_Mem_out);

end structure;
