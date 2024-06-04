library IEEE;
use IEEE.std_logic_1164.all;

entity Mux is

  port(i1               : in std_logic;
       i2               : in std_logic;
	   s1				: in std_logic;
       o1               : out std_logic);

end Mux;

architecture behavior of Mux is
begin

  
 o1 <= (i1 and s1) or (i2 and not s1);
  
end behavior;