library IEEE;
use IEEE.std_logic_1164.all;

entity reg_file is
port(i_CLK	: std_logic;
     i_WrD	: in std_logic_vector(31 downto 0);
     i_WrS, i_RdS1, i_RdS2	: in std_logic_vector(4 downto 0);
     i_WrE	: in std_logic;
     i_RST	: in std_logic;
     o_RdD1, o_RdD2	: out std_logic_vector(31 downto 0));
end reg_file;

architecture structure of reg_file is

component mux32
port(i_1	: in std_logic_vector(31 downto 0);
     i_2	: in std_logic_vector(31 downto 0);
     i_3	: in std_logic_vector(31 downto 0);
     i_4	: in std_logic_vector(31 downto 0);
     i_5	: in std_logic_vector(31 downto 0);
     i_6	: in std_logic_vector(31 downto 0);
     i_7	: in std_logic_vector(31 downto 0);
     i_8	: in std_logic_vector(31 downto 0);
     i_9	: in std_logic_vector(31 downto 0);
     i_10	: in std_logic_vector(31 downto 0);
     i_11	: in std_logic_vector(31 downto 0);
     i_12	: in std_logic_vector(31 downto 0);
     i_13	: in std_logic_vector(31 downto 0);
     i_14	: in std_logic_vector(31 downto 0);
     i_15	: in std_logic_vector(31 downto 0);
     i_16	: in std_logic_vector(31 downto 0);
     i_17	: in std_logic_vector(31 downto 0);
     i_18	: in std_logic_vector(31 downto 0);
     i_19	: in std_logic_vector(31 downto 0);
     i_20	: in std_logic_vector(31 downto 0);
     i_21	: in std_logic_vector(31 downto 0);
     i_22	: in std_logic_vector(31 downto 0);
     i_23	: in std_logic_vector(31 downto 0);
     i_24	: in std_logic_vector(31 downto 0);
     i_25	: in std_logic_vector(31 downto 0);
     i_26	: in std_logic_vector(31 downto 0);
     i_27	: in std_logic_vector(31 downto 0);
     i_28	: in std_logic_vector(31 downto 0);
     i_29	: in std_logic_vector(31 downto 0);
     i_30	: in std_logic_vector(31 downto 0);
     i_31	: in std_logic_vector(31 downto 0);
     i_32	: in std_logic_vector(31 downto 0);
     i_S	: in std_logic_vector(4 downto 0);
     o_F	: out std_logic_vector(31 downto 0));
end component;

component five_32_decode
port(i_A	: in std_logic_vector(4 downto 0);
     i_EN	: in std_logic;
     o_F	: out std_logic_vector(31 downto 0));
end component;

component n_bit_dff
   generic(N : integer := 32);
   port(i_CLK        : in std_logic;
       i_RST        : in std_logic;
       i_WrE         : in std_logic;
       i_D          : in std_logic_vector(N-1 downto 0);
       o_Q          : out std_logic_vector(N-1 downto 0));
end component;

type REG is array (31 downto 0) of std_logic_vector(31 downto 0);
signal s_Q_reg	: REG;
signal s_F_decode	: std_logic_vector(31 downto 0);

begin

decode : five_32_decode
port map(i_WrS,
	 i_WrE,
	 s_F_decode);

reg_0 : n_bit_dff
port map(i_CLK => i_CLK,
	 i_RST => i_RST,
	 i_WrE => '0',
	 i_D => (others => '0'),
	 o_Q => s_Q_reg(0));

G1: for i in 1 to 31 generate
   n_bit_dff_i : n_bit_dff
      port map(i_CLK => i_CLK,
	       i_RST => i_RST,
	       i_WrE => s_F_decode(i),
	       i_D => i_WrD,
	       o_Q => s_Q_reg(i));
end generate;

mux_1 : mux32
port map(s_Q_reg(0),s_Q_reg(1),s_Q_reg(2),s_Q_reg(3),s_Q_reg(4),s_Q_reg(5),s_Q_reg(6),s_Q_reg(7),s_Q_reg(8),s_Q_reg(9),s_Q_reg(10),s_Q_reg(11),s_Q_reg(12),s_Q_reg(13),s_Q_reg(14),s_Q_reg(15),s_Q_reg(16),s_Q_reg(17),s_Q_reg(18),s_Q_reg(19),s_Q_reg(20),s_Q_reg(21),s_Q_reg(22),s_Q_reg(23),s_Q_reg(24),s_Q_reg(25),s_Q_reg(26),s_Q_reg(27),s_Q_reg(28),s_Q_reg(29),s_Q_reg(30),s_Q_reg(31), i_RdS1, o_RdD1);

mux_2 : mux32
port map(s_Q_reg(0),s_Q_reg(1),s_Q_reg(2),s_Q_reg(3),s_Q_reg(4),s_Q_reg(5),s_Q_reg(6),s_Q_reg(7),s_Q_reg(8),s_Q_reg(9),s_Q_reg(10),s_Q_reg(11),s_Q_reg(12),s_Q_reg(13),s_Q_reg(14),s_Q_reg(15),s_Q_reg(16),s_Q_reg(17),s_Q_reg(18),s_Q_reg(19),s_Q_reg(20),s_Q_reg(21),s_Q_reg(22),s_Q_reg(23),s_Q_reg(24),s_Q_reg(25),s_Q_reg(26),s_Q_reg(27),s_Q_reg(28),s_Q_reg(29),s_Q_reg(30),s_Q_reg(31), i_RdS2, o_RdD2);

end structure;