-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- TPU_MV_Element.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a processing
-- element for the systolic matrix-vector multiplication array inspired 
-- by Google's TPU.
--
--
-- NOTES:
-- 1/14/19 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity rippleAdder is
generic(N : integer := 16);
  port(i1 		            : in std_logic_vector(N-1 downto 0);
       i2 		            : in std_logic_vector(N-1 downto 0);
       cin 		            : in std_logic;
       s1 		            : out std_logic_vector(N-1 downto 0);
       cout_n 		        : out std_logic);

end rippleAdder;

architecture structure of rippleAdder is
  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).
component fullAdder 

  port(i1 		            : in std_logic;
       i2 		            : in std_logic;
       c1 		            : in std_logic;
       s1 		            : out std_logic;
       cout 		        : out std_logic);

end component;
 
   -- connects adders
  signal conn1         : std_logic_vector(N downto 0);

begin
conn1(0) <= cin;
cout_n <= conn1(N);
  G_NBit_ADD: for i in 0 to N-1 generate
    MUXI: fullAdder port map(
              i1     => i1(i),  -- ith instance's data 0 input hooked up to ith data 0 inp
              i2     => i2(i),  -- ith instance's data 1 input hooked up to ith data 1 input.
			  c1     => conn1(i),
              s1      => s1(i),  -- ith instance's data output hooked up to ith data output.
			  cout 	 => conn1(i+1));
  end generate G_NBit_ADD;

 
    

  end structure;
