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


entity fullAdder is

  port(i1 		            : in std_logic;
       i2 		            : in std_logic;
       c1 		            : in std_logic;
       s1 		            : out std_logic;
       cout 		        : out std_logic);

end fullAdder;

architecture structure of fullAdder is
  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).
  component andg2 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;



  component org2
		  port(i_A          : in std_logic;
			   i_B          : in std_logic;
			   o_F          : out std_logic);
  end component;

component xorg2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

  -- connects first xor to the second with teh carry
  signal conn1         : std_logic;
  -- connects first and to last or
  signal conn2   : std_logic;
  -- connects last and to or with carry out
  signal conn3        : std_logic;
  

begin

  ---------------------------------------------------------------------------
  -- Level 0
  ---------------------------------------------------------------------------
 
  add_xor1: xorg2
    port MAP(i_A              => i1,
             i_B              => i2,
             o_F              => conn1);

  add_and1: andg2
    port MAP(i_A              => i1,
             i_B              => i2,
             o_F               => conn2);
   ---------------------------------------------------------------------------
  -- Level 1
  ---------------------------------------------------------------------------
  add_xor2: xorg2
    port MAP(i_A              => conn1,
             i_B              => c1,
             o_F               => s1);

  add_and2: andg2
    port MAP(i_A              => conn1,
             i_B              => c1,
             o_F               => conn3);

    
  ---------------------------------------------------------------------------
  -- Level 2
  ---------------------------------------------------------------------------
  g_or1: org2
    port MAP(i_A               => conn2,
             i_B               => conn3,
             o_F               => cout);

 
    

  end structure;
