library IEEE;
use IEEE.std_logic_1164.all;

entity andGate is

  port(i1               : in std_logic;
       i2               : in std_logic;
       o1               : out std_logic);

end andGate;

architecture behavior of andGate is
begin

  
 o1 <= i1 and i2;
  
end behavior;