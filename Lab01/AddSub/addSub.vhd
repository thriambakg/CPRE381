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


entity addSub is
generic(N : integer := 16);
  port(i1 		            : in std_logic_vector(N-1 downto 0);
       i2 		            : in std_logic_vector(N-1 downto 0);
	   nAdd_Sub				: in std_logic;
       s1 		            : out std_logic_vector(N-1 downto 0);
       cout_n 		        : out std_logic);

end addSub;

architecture structure of addSub is
  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).
component rippleAdder is

  port(i1 		            : in std_logic_vector(N-1 downto 0);
       i2 		            : in std_logic_vector(N-1 downto 0);
       cin 		            : in std_logic;
       s1 		            : out std_logic_vector(N-1 downto 0);
       cout_n 		        : out std_logic);

 end component;
 
 component mux2t1_N 
 
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component onesComp_N 
  -- Generic of type integer for input/output data width. Default value is 32.
  port(
       i_D0         : in std_logic_vector(N-1 downto 0);
      
       o_O          : out std_logic_vector(N-1 downto 0));

end component;
 
   -- connects  mux to adder
  signal B_W         : std_logic_vector(N-1 downto 0);
   --connects n_bit inverter to n_bit mux
  signal INV_W		 : std_logic_vector(N-1 downto 0);
begin
  ---------------------------------------------------------------------------
  -- Level 0
  ---------------------------------------------------------------------------
 
  Invert: onesComp_N
    port MAP(i_D0             => i2,
             o_O             => INV_W);

  MUX: mux2t1_N
    port MAP(i_S			=> nAdd_Sub,
			 i_D0              => INV_W,
             i_D1              => i2,
             o_O               => B_W);
   ---------------------------------------------------------------------------
  -- Level 1
  ---------------------------------------------------------------------------
  Adder: rippleAdder
    port MAP(i1              => i1,
             i2              => B_W,
             cin               => nAdd_Sub,
			 s1 			 => s1,
			 cout_n 		 => cout_n);
			 

 
    

  end structure;
