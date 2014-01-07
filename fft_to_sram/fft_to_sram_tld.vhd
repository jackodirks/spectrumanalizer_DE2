library ieee;
use ieee.std_logic_1164.all;

ENTITY fft_to_sram IS
PORT(
  rst, niosII_ctrl_in, fft_cntrl_in, clock, avalon_acknoledge : IN STD_LOGIC;
  avalon_write, fft_cntrl_out, niosII_ctrl_out : OUT STD_LOGIC;
  avalon_address : OUT STD_LOGIC_VECTOR(18 DOWNTO 0)
);
END fft_to_sram;
  
ARCHITECTURE fft_to_sram OF fft_to_sram IS
  COMPONENT fft_to_sram_fsm IS
  PORT(
    reset, clk, n2_in, fft_in, avalon_ack : IN STD_LOGIC;
    addr_offset : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    avalon_write, fft_out, n2_out, addr_reset, addr_enable : OUT STD_LOGIC;
    avalon_addr : OUT STD_LOGIC_VECTOR(18 DOWNTO 0)
  );
  END COMPONENT;
  
  COMPONENT fft_to_sram_addr_offset IS
  PORT (
    clk, reset, enable : IN STD_LOGIC;
    addr_offset : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- 7 bit, max 128 (127 needed)
  );
END COMPONENT;
  
--Internal comminucation
SIGNAL addr_reset, addr_enable : STD_LOGIC;
SIGNAL addr_offset : STD_LOGIC_VECTOR(6 DOWNTO 0);
  
BEGIN 
  
  --Finite State Machine
  fsm :  fft_to_sram_fsm PORT MAP (
    reset => rst,
    clk => clock,
    n2_in => niosII_ctrl_in,
    fft_in => fft_cntrl_in,
    avalon_ack => avalon_acknoledge,
    avalon_write => avalon_write,
    fft_out => fft_cntrl_out,
    n2_out => niosII_ctrl_out,
    addr_reset => addr_reset,
    addr_enable => addr_enable,
    addr_offset => addr_offset,
    avalon_addr => avalon_address
  ); 
  
  --Address Control
  ac : fft_to_sram_addr_offset PORT MAP (
    clk => clock,
    reset => addr_reset,
    enable => addr_enable,
    addr_offset => addr_offset
  );
END ARCHITECTURE;