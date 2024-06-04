library IEEE;
use IEEE.std_logic_1164.all;

entity orGate is

  port(i1               : in std_logic;
       i2               : in std_logic;
       o1               : out std_logic);

end orGate;

architecture behavior of orGate is
begin

  
 o1 <= i1 or i2;
  
end behavior;