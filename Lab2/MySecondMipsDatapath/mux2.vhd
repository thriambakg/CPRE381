library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
port(i_A	: in std_logic;
     i_B	: in std_logic;
     i_S	: in std_logic;
     o_F	: out std_logic);
end mux2;

architecture structure of mux2 is

component andg2 is
port(i_A	: in std_logic;
     i_B	: in std_logic;
     o_F	: out std_logic);
end component;

component org2 is
port(i_A	: in std_logic;
     i_B	: in std_logic;
     o_F	: out std_logic);
end component;

component invg is
port(i_A	: in std_logic;
     o_F	: out std_logic);
end component;

signal inv_1_out, and_1_out, and_2_out	: std_logic;

begin

inv_1 : invg
port map(i_A => i_S,
	 o_F => inv_1_out);

and_1 : andg2
port map(i_A => i_A,
	 i_B => inv_1_out,
	 o_F => and_1_out);

and_2 : andg2
port map(i_A => i_S,
	 i_B => i_B,
	 o_F => and_2_out);

or_1 : org2
port map(i_A => and_1_out,
	 i_B => and_2_out,
	 o_F => o_F);

end structure;
