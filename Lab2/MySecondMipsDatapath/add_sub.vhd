library IEEE;
use IEEE.std_logic_1164.all;
 
entity add_sub is
generic(N : integer := 32);
port(i_A	: in std_logic_vector(N-1 downto 0);
     imm, i_reg	: in std_logic_vector(N-1 downto 0);
     nAdd_Sub, ALUSrc	: in std_logic;
     o_Sum	: out std_logic_vector(N-1 downto 0);
     o_Cout	: out std_logic);
end add_sub;

architecture structure of add_sub is

component complementer is
port(i_A	: in std_logic_vector(N-1 downto 0);
     o_F	: out std_logic_vector(N-1 downto 0));
end component;

component n_bit_mux2 is
port(i_A, i_B	: in std_logic_vector(N-1 downto 0); 
     i_S	: in std_logic;
     o_F  	: out std_logic_vector(N-1 downto 0));
end component;

component n_bit_full_adder is
port(i_A 	: in std_logic_vector(N-1 downto 0); 
     i_B 	: in std_logic_vector(N-1 downto 0); 		 
     i_Cin 	: in std_logic; 
     o_Sum 	: out std_logic_vector(N-1 downto 0); 
     o_Cout 	: out std_logic);	
end component;

signal complement, sel_in, sel_value, post_op: std_logic_vector(N-1 downto 0);

begin

inv : complementer
port map(i_A => sel_value,
         o_F => complement); 

mux1 : n_bit_mux2
port map(i_A  => i_reg,
         i_B  => imm,
         i_S  => ALUSrc,
  	 o_F  => sel_value);

mux2 : n_bit_mux2
port map(i_A  => sel_value,
         i_B  => complement,
         i_S  => nAdd_Sub,
  	 o_F  => sel_in);

adder : n_bit_full_adder
port map(i_A => i_A,
         i_B => sel_in,
         i_Cin => nAdd_Sub,
         o_Sum => o_Sum,
         o_Cout => o_Cout);

end structure;
