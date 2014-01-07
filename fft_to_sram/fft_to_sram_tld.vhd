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
    reset, clk, nios2_ctrl_has_flipped, fft_ctrl_in, buffer_done, avalon_ack : IN STD_LOGIC;
    avalon_write, fft_ctrl_out, nios_flip_reset, incr_addr, nios2_contrl_out : OUT STD_LOGIC
  );
  END COMPONENT;
  
  COMPONENT fft_to_sram_n2_flip_ctrl IS
  PORT(
    n2_flip_reset, clk, nios_ctrl_in, rst : IN STD_LOGIC;
    nios2_ctrl_has_flipped : OUT STD_LOGIC
  );
  END COMPONENT;
  
  COMPONENT fft_to_sram_address_cntrl IS
  PORT(
    clk, incr_addr, rst : IN STD_LOGIC;
    buffer_done, nios2_cntrl_out : OUT STD_LOGIC;
    avalon_write_address :  OUT std_logic_vector(18 downto 0)
  );
END COMPONENT;

--Internal comminucation
SIGNAL nios_flip_control, buffer_done_control, nios_flip_reset, incr_addr : STD_LOGIC;
  
BEGIN 
  
  --Finite State Machine
  fsm :  fft_to_sram_fsm PORT MAP (
    reset => rst,
    clk => clock,
    nios2_ctrl_has_flipped => niosII_ctrl_in,
    fft_ctrl_in => fft_cntrl_in,
    buffer_done => buffer_done_control,
    avalon_ack => avalon_acknoledge,
    avalon_write => avalon_write,
    fft_ctrl_out => fft_cntrl_out,
    nios_flip_reset => nios_flip_reset,
    incr_addr => incr_addr,
	 nios2_contrl_out => niosII_ctrl_out
  ); 
  
  --Nios2 control signal flip Control
  n2fc : fft_to_sram_n2_flip_ctrl PORT MAP (
    n2_flip_reset => nios_flip_reset,
    clk => clock,
    nios_ctrl_in => niosII_ctrl_in,
    rst => rst,
    nios2_ctrl_has_flipped => nios_flip_control
  );
  
  --Address Control
  ac : fft_to_sram_address_cntrl PORT MAP (
    clk => clock,
    rst => rst,
    incr_addr => incr_addr,
    buffer_done => buffer_done_control,
    --nios2_cntrl_out => niosII_ctrl_out,
    avalon_write_address => avalon_address
  );
END ARCHITECTURE;