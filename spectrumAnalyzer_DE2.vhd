library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY spectrumAnalyzer_DE2 IS
	PORT(
		--General Inputs
		CLOCK_50			: in std_logic; 
		KEY				  	: in std_logic_vector (3 downto 0);
		--  Memory (SRAM)
		SRAM_DQ				: inout std_logic_vector (15 downto 0);
		-- Outputs
		TD_RESET			: out std_logic;
		--  Simple
		LEDG				: out std_logic_vector (8 downto 0);
		LEDR				: out std_logic_vector (17 downto 0);
		--  Memory (SRAM)
		SRAM_ADDR			: out std_logic_vector (17 downto 0);
		SRAM_CE_N			: out std_logic;
		SRAM_WE_N			: out std_logic;
		SRAM_OE_N			: out std_logic;
		SRAM_UB_N			: out std_logic;
		SRAM_LB_N			: out std_logic;
		--  VGA
		VGA_CLK				: out std_logic;
		VGA_HS				: out std_logic;
		VGA_VS				: out std_logic;
		VGA_BLANK			: out std_logic;
		VGA_SYNC			: out std_logic;
		VGA_R				: out std_logic_vector (9 downto 0);
		VGA_G				: out std_logic_vector (9 downto 0);
		VGA_B				: out std_logic_vector (9 downto 0)
	);
END ENTITY spectrumAnalyzer_DE2;

ARCHITECTURE impl OF spectrumAnalyzer_DE2 IS
	component nios2VGA is
		port (
			clk_clk                                       : in    std_logic                      := 'X';             -- clk
			reset_reset_n                                 : in    std_logic                      := 'X';             -- reset_n
			red_led_pio_external_connection_export        : out   std_logic_vector(17 downto 0);                     -- export
			vga_controller_external_CLK                   : out   std_logic;                                         -- CLK
			vga_controller_external_HS                    : out   std_logic;                                         -- HS
			vga_controller_external_VS                    : out   std_logic;                                         -- VS
			vga_controller_external_BLANK                 : out   std_logic;                                         -- BLANK
			vga_controller_external_SYNC                  : out   std_logic;                                         -- SYNC
			vga_controller_external_R                     : out   std_logic_vector(9 downto 0);                      -- R
			vga_controller_external_G                     : out   std_logic_vector(9 downto 0);                      -- G
			vga_controller_external_B                     : out   std_logic_vector(9 downto 0);                      -- B
			sram_external_interface_DQ                    : inout std_logic_vector(15 downto 0)  := (others => 'X'); -- DQ
			sram_external_interface_ADDR                  : out   std_logic_vector(17 downto 0);                     -- ADDR
			sram_external_interface_LB_N                  : out   std_logic;                                         -- LB_N
			sram_external_interface_UB_N                  : out   std_logic;                                         -- UB_N
			sram_external_interface_CE_N                  : out   std_logic;                                         -- CE_N
			sram_external_interface_OE_N                  : out   std_logic;                                         -- OE_N
			sram_external_interface_WE_N                  : out   std_logic;                                         -- WE_N
			vga_clock_out_clk_clk                         : out   std_logic;                                         -- clk
			green_led_pio_external_connection_export      : out   std_logic_vector(8 downto 0);                      -- export
			sdram_clock_clk                               : out   std_logic;                                         -- clk
			vhdl_to_avalon_external_interface_address     : in    std_logic_vector(18 downto 0)  := (others => 'X'); -- address
			vhdl_to_avalon_external_interface_byte_enable : in    std_logic_vector(15 downto 0)  := (others => 'X'); -- byte_enable
			vhdl_to_avalon_external_interface_read        : in    std_logic                      := 'X';             -- read
			vhdl_to_avalon_external_interface_write       : in    std_logic                      := 'X';             -- write
			vhdl_to_avalon_external_interface_write_data  : in    std_logic_vector(127 downto 0) := (others => 'X'); -- write_data
			vhdl_to_avalon_external_interface_acknowledge : out   std_logic;                                         -- acknowledge
			vhdl_to_avalon_external_interface_read_data   : out   std_logic_vector(127 downto 0);                    -- read_data
			nios_cntrl_in_export                          : in    std_logic_vector(7 downto 0)   := (others => 'X'); -- export
			nios_cntrl_out_export                         : out   std_logic_vector(7 downto 0);								-- export
			address_pio_external_connection_export        : in    std_logic_vector(31 downto 0)  := (others => 'X')  -- export			
		);
	end component nios2VGA;
	
	COMPONENT fft_to_sram IS
	PORT(
	  rst, niosII_ctrl_in, fft_cntrl_in, clock, avalon_acknoledge : IN STD_LOGIC;
	  avalon_write, fft_cntrl_out, niosII_ctrl_out : OUT STD_LOGIC;
	  avalon_address : OUT STD_LOGIC_VECTOR(18 DOWNTO 0)
	);
	END COMPONENT fft_to_sram;
	
	SIGNAL nios_ctr_nios, nios_ctr_other, fft_ctr_fft, fft_ctr_other, rst_inv : STD_LOGIC := '0';
	SIGNAL avalon_address_ex : std_logic_vector(18 downto 0);
	SIGNAL avalon_byte_enable_ex : std_logic_vector(15 downto 0);
	SIGNAL avalon_read_ex, avalon_write_ex, avalon_acknowledge_ex : STD_LOGIC := '0';
	SIGNAL avalon_write_data_ex, avalon_read_data_ex : STD_LOGIC_vector(127 DOWNTO 0);
	BEGIN
	TD_RESET <= '1';
	rst_inv <= NOT KEY(0);
	avalon_read_ex <= '0';
	avalon_byte_enable_ex <= (others => '1');
	--TEMP ASSIGNMENTS UNTIL FFT
	avalon_write_data_ex <= (others => '1');
	fft_ctr_other <= '1';
	LEDR(0) <= avalon_write_ex;
	LEDR(1) <= '1';
	LEDR(2) <= nios_ctr_other;
	LEDR(3) <= nios_ctr_nios;
	LEDR(4) <= rst_inv;
	f2s : fft_to_sram 
		PORT MAP(
			rst => rst_inv,
			niosII_ctrl_in => nios_ctr_other,
			fft_cntrl_in => fft_ctr_other,
			clock => CLOCK_50,
			avalon_acknoledge => avalon_acknowledge_ex,
			avalon_write => avalon_write_ex,
			fft_cntrl_out => 	fft_ctr_fft,
			niosII_ctrl_out => nios_ctr_nios,
			avalon_address => avalon_address_ex
		);

	nios2 : nios2VGA
		port map (
			--General stuffs
			clk_clk => CLOCK_50,
			reset_reset_n => KEY(0),
			--red_led_pio_external_connection_export => LEDR,
			green_led_pio_external_connection_export => LEDG,
			nios_cntrl_in_export(0) => nios_ctr_nios, --Commincation to the Nios2
			nios_cntrl_out_export(1) => nios_ctr_other, --Comincation from the Nios2
			address_pio_external_connection_export(18 DOWNTO 0) => avalon_address_ex,
			
			--Configuration For Ex To Avalon
			vhdl_to_avalon_external_interface_address => avalon_address_ex,
			vhdl_to_avalon_external_interface_byte_enable => avalon_byte_enable_ex,
			vhdl_to_avalon_external_interface_read => avalon_read_ex,
			vhdl_to_avalon_external_interface_write => avalon_write_ex,
			vhdl_to_avalon_external_interface_write_data => avalon_write_data_ex,
			vhdl_to_avalon_external_interface_acknowledge => avalon_acknowledge_ex,
			vhdl_to_avalon_external_interface_read_data => avalon_read_data_ex,
			
			vga_controller_external_CLK => VGA_CLK,
			vga_controller_external_HS => VGA_HS,
			vga_controller_external_VS => VGA_VS,
			vga_controller_external_BLANK => VGA_BLANK,
			vga_controller_external_SYNC => VGA_SYNC,
			vga_controller_external_R => VGA_R,
			vga_controller_external_G => VGA_G,
			vga_controller_external_B => VGA_B,
			
			sram_external_interface_DQ =>SRAM_DQ,
			sram_external_interface_ADDR => SRAM_ADDR,
			sram_external_interface_LB_N => SRAM_LB_N,
			sram_external_interface_UB_N => SRAM_UB_N,
			sram_external_interface_CE_N => SRAM_CE_N,
			sram_external_interface_OE_N => SRAM_OE_N,
			sram_external_interface_WE_N => SRAM_WE_N
		);
	
END ARCHITECTURE;