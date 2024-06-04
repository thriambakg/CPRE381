-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_dff.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- edge-triggered flip-flop with parallel access and reset.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_five_32_decode is
end tb_five_32_decode;

architecture behavior of tb_five_32_decode is

component five_32_decode is
port(i_A	: in std_logic_vector(4 downto 0);
     i_EN	: in std_logic;
     o_F	: out std_logic_vector(31 downto 0));
end component;

signal s_A	: std_logic_vector(4 downto 0);
signal s_EN	: std_logic;
signal s_F	: std_logic_vector(31 downto 0);

begin

dec : five_32_decode
port map(i_A => s_A,
	 i_EN => s_EN,
	 o_F => s_F);

process
begin

s_A <= "00000";
s_EN <= '1';
wait for 100 ns;

s_A <= "00001";
s_EN <= '0';
wait for 100 ns;

s_A <= "00010";
s_EN <= '1';
wait for 100 ns;

s_A <= "00011";
s_EN <= '1';
wait for 100 ns;

s_A <= "00100";
s_EN <= '1';
wait for 100 ns;

s_A <= "00101";
s_EN <= '1';
wait for 100 ns;

s_A <= "00110";	
s_EN <= '1';
wait for 100 ns;

s_A <= "00111";	
s_EN <= '1';
wait for 100 ns;

s_A <= "01000";
s_EN <= '1';
wait for 100 ns;

s_A <= "01001";
s_EN <= '1';
wait for 100 ns;

s_A <= "01010";
s_EN <= '1';
wait for 100 ns;

s_A <= "01011";
s_EN <= '1';
wait for 100 ns;

s_A <= "01100";
s_EN <= '1';
wait for 100 ns;

s_A <= "01101";
s_EN <= '1';
wait for 100 ns;

s_A <= "01110";	
s_EN <= '1';
wait for 100 ns;

s_A <= "01111";	
s_EN <= '1';
wait for 100 ns;

s_A <= "10000";
s_EN <= '1';
wait for 100 ns;

s_A <= "10001";
s_EN <= '1';
wait for 100 ns;

s_A <= "10010";
s_EN <= '1';
wait for 100 ns;

s_A <= "10011";
s_EN <= '1';
wait for 100 ns;

s_A <= "10100";
s_EN <= '1';
wait for 100 ns;

s_A <= "10101";
s_EN <= '1';
wait for 100 ns;

s_A <= "10110";	
s_EN <= '1';
wait for 100 ns;

s_A <= "10111";	
s_EN <= '1';
wait for 100 ns;

s_A <= "11000";
s_EN <= '1';
wait for 100 ns;

s_A <= "11001";
s_EN <= '1';
wait for 100 ns;

s_A <= "11010";
s_EN <= '1';
wait for 100 ns;

s_A <= "11011";
s_EN <= '1';
wait for 100 ns;

s_A <= "11100";
s_EN <= '1';
wait for 100 ns;

s_A <= "11101";
s_EN <= '1';
wait for 100 ns;

s_A <= "11110";	
s_EN <= '1';
wait for 100 ns;

s_A <= "11111";	
s_EN <= '1';
wait for 100 ns;

end process;

end behavior;

