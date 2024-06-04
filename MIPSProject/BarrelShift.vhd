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