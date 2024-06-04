library IEEE;
use IEEE.std_logic_1164.all;

entity extender_16_32 is
port(i_A	: in std_logic_vector(15 downto 0);
     i_signed	: in std_logic;
     o_F	: out std_logic_vector(31 downto 0));
end extender_16_32;

architecture dataflow of extender_16_32 is

signal ext_bit	: std_logic;

begin

with i_signed select
   ext_bit <= '0' when '0',
	      i_A(15) when others;

G1: for i in 0 to 15 generate
	o_F(i) <= i_A(i);
end generate;

G2: for i in 16 to 31 generate
	o_F(i) <= ext_bit;
end generate;

end dataflow;
