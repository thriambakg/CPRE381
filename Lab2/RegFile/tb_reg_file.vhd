
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

entity tb_reg_file is
  generic(gCLK_HPER   : time := 50 ns);
end tb_reg_file;

architecture behavior of tb_reg_file is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;

component reg_file
  port(i_CLK, i_RST, i_WrE : in std_logic;
       i_WrS, i_RdS1, i_RdS2 : in STD_LOGIC_VECTOR(4 downto 0);
       i_WrD : in STD_LOGIC_VECTOR(31 downto 0);
       o_RdD1, o_RdD2 : out STD_LOGIC_VECTOR(31 downto 0));
end component;

  -- Temporary signals to connect to the dff component.
  signal s_CLK, s_RST, s_WrE  : std_logic;
  signal s_RdS1, s_RdS2, s_WrS : std_logic_vector(4 downto 0);
  signal s_WrD, s_RdD1, s_RdD2 : std_logic_vector(31 downto 0);

begin

  DUT: reg_file
  port map(i_CLK => s_CLK, 
           i_RST => s_RST,
           i_WrE  => s_WrE,
           i_WrS   => s_WrS,
           i_RdS1   => s_RdS1,
           i_RdS2  =>  s_RdS2,
           i_WrD   => s_WrD,
           o_RdD1   => s_RdD1,
           o_RdD2  =>  s_RdD2);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
    -- Reset the FF
    s_RST <= '1';
    s_WrE  <= '0';
    s_WrS   <= "00010";
    s_RdS1   <= "00011";
    s_RdS2   <= "00010";
    s_WrD   <= x"FFFF0000";
    wait for cCLK_PER;

    s_RST <= '0';
    s_WrE  <= '1';
    s_WrS   <= "00010";
    s_RdS1   <= "00011";
    s_RdS2   <= "00010";
    s_WrD   <= x"01111111";
    wait for cCLK_PER;  

    s_RST <= '0';
    s_WrE  <= '1';
    s_WrS   <= "00010";
    s_RdS1   <= "00011";
    s_RdS2   <= "00101";
    s_WrD   <= x"0aaaaaaa";
    wait for cCLK_PER;  

    s_RST <= '0';
    s_WrE  <= '1';
    s_WrS   <= "00010";
    s_RdS1   <= "00101";
    s_RdS2   <= "00010";
    s_WrD   <= x"0bbbbbbb";
    wait for cCLK_PER;  

    s_RST <= '0';
    s_WrE  <= '1';
    s_WrS   <= "00010";
    s_RdS1   <= "00011";
    s_RdS2  <= "00010";
    s_WrD   <= x"FFFF0000";
    wait for cCLK_PER;  

    wait;
  end process;
  
end behavior;