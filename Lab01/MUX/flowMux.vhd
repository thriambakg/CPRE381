library IEEE;
use IEEE.std_logic_1164.all;

entity flowMux is

  port(i1               : in std_logic;
       i2               : in std_logic;
	   s1				: in std_logic;
       o1               : out std_logic);

end flowMux;

architecture dataflow of flowMux is
begin

  with s1 select
  o1 <= i1 when '1',
		i2 when '0',
  unaffected when others;
  
end dataflow;