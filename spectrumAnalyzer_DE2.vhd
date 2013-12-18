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
			control_signals_io_external_connection_export : inout std_logic_vector(3 downto 0)   := (others => 'X')  -- export
		);
	end component nios2VGA;
	
	COMPONENT FFT_to_SRAM IS
	PORT(
		clk, ctrl_rcv, nios_ctr_rcv: IN STD_LOGIC;
		ctrl_snd, nios_ctr_snd : OUT STD_LOGIC := '0' ;
		data : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		
		avalon_address : OUT std_logic_vector(18 downto 0);
		avalon_byte_enable : OUT std_logic_vector(15 downto 0);
		avalon_read : OUT STD_LOGIC;
		avalon_write : OUT STD_LOGIC;
		avalon_write_data : OUT std_logic_vector(127 DOWNTO 0);
		avalon_acknowledge : IN STD_LOGIC;
		avalon_read_data : OUT STD_LOGIC_vector(127 DOWNTO 0)
	);
	END COMPONENT FFT_to_SRAM;
	
	SIGNAL nios_ctr_nios, nios_ctr_other, fft_ctr_fft, fft_ctr_other : STD_LOGIC := '0';
	SIGNAL avalon_address_ex : std_logic_vector(18 downto 0);
	SIGNAL avalon_byte_enable_ex : std_logic_vector(15 downto 0);
	SIGNAL avalon_read_ex, avalon_write_ex, avalon_acknowledge_ex : STD_LOGIC := '0';
	SIGNAL avalon_write_data_ex, avalon_read_data_ex, fft_data_bus : STD_LOGIC_vector(127 DOWNTO 0);
	BEGIN
	TD_RESET <= '1';
--	fft_to_sram_comp	: FFT_to_SRAM
--	port map(
--		--Stuffis Generalis
--		clk => CLOCK_50,
--	
--		--NIOS 2 signals
--		nios_ctr_snd => nios_ctr_nios,
--		nios_ctr_rcv => nios_ctr_other,
--		
--		--FFT Signals
--		ctrl_rcv => fft_ctr_other,
--		ctrl_snd => fft_ctr_fft,
--		
--		--To Avalon signals
--		avalon_address => avalon_address_ex,
--		avalon_byte_enable => avalon_byte_enable_ex,
--		avalon_read => avalon_read_ex,
--		avalon_write => avalon_write_ex,
--		avalon_write_data => avalon_write_data_ex,
--		avalon_acknowledge => avalon_acknowledge_ex,
--		avalon_read_data => avalon_read_data_ex,
--		
--		--Data Bus
--		data => fft_data_bus
--	);
	nios2 : nios2VGA
		port map (
			--General stuffs
			clk_clk => CLOCK_50,
			reset_reset_n => KEY(0),
			red_led_pio_external_connection_export => LEDR,
			green_led_pio_external_connection_export => LEDG,
			control_signals_io_external_connection_export(0) => nios_ctr_nios, --Commincation to the Nios2
			control_signals_io_external_connection_export(1) => nios_ctr_other, --Comincation from the Nios2
			
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