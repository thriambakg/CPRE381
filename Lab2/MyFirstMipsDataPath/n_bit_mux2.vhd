library IEEE;
use IEEE.std_logic_1164.all;

entity n_bit_mux2 is
generic(N : integer := 32);
port(i_A	: in std_logic_vector(N-1 downto 0);
     i_B	: in std_logic_vector(N-1 downto 0);
     i_S	: in std_logic;
     o_F	: out std_logic_vector(N-1 downto 0));
end n_bit_mux2;

architecture structure of n_bit_mux2 is

component mux2
port(i_A, i_B, i_S	: in std_logic;
     o_F		: out std_logic);
end component;

begin

G1: for i in 0 to N-1 generate
   mux2_i : mux2
      port map(i_A => i_A(i),
	       i_B => i_B(i),
	       i_S => i_S,
	       o_F => o_F(i));
end generate;

end structure;
