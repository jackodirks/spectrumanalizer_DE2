library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY spectrumAnalyzer_DE2 IS
	PORT(
		--General Inputs
		CLOCK_50			: in std_logic; 
		KEY				  	: in std_logic_vector (3 downto 0);
		SW					: in std_logic_vector (17 DOWNTO 0);
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
			clk_clk                                  : in    std_logic                     := 'X';             -- clk
			reset_reset_n                            : in    std_logic                     := 'X';             -- reset_n
			red_led_pio_external_connection_export   : out   std_logic_vector(17 downto 0);                    -- export
			vga_controller_external_CLK              : out   std_logic;                                        -- CLK
			vga_controller_external_HS               : out   std_logic;                                        -- HS
			vga_controller_external_VS               : out   std_logic;                                        -- VS
			vga_controller_external_BLANK            : out   std_logic;                                        -- BLANK
			vga_controller_external_SYNC             : out   std_logic;                                        -- SYNC
			vga_controller_external_R                : out   std_logic_vector(9 downto 0);                     -- R
			vga_controller_external_G                : out   std_logic_vector(9 downto 0);                     -- G
			vga_controller_external_B                : out   std_logic_vector(9 downto 0);                     -- B
			sram_external_interface_DQ               : inout std_logic_vector(15 downto 0) := (others => 'X'); -- DQ
			sram_external_interface_ADDR             : out   std_logic_vector(17 downto 0);                    -- ADDR
			sram_external_interface_LB_N             : out   std_logic;                                        -- LB_N
			sram_external_interface_UB_N             : out   std_logic;                                        -- UB_N
			sram_external_interface_CE_N             : out   std_logic;                                        -- CE_N
			sram_external_interface_OE_N             : out   std_logic;                                        -- OE_N
			sram_external_interface_WE_N             : out   std_logic;                                        -- WE_N
			vga_clock_out_clk_clk                    : out   std_logic;                                        -- clk
			green_led_pio_external_connection_export : out   std_logic_vector(8 downto 0);                     -- export
			sdram_clock_clk                          : out   std_logic;                                        -- clk
			nios_cntrl_in_export                     : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			nios_cntrl_out_export                    : out   std_logic_vector(7 downto 0);                     -- export
			fft_in_0_export                          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			fft_in_1_export                          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			fft_in_2_export                          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			fft_in_3_export                          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			fft_in_4_export                          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			fft_in_5_export                          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			fft_in_6_export                          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			fft_in_7_export                          : in    std_logic_vector(31 downto 0) := (others => 'X')  -- export
		);
	end component nios2VGA;

	SIGNAL n2_cntrl, fft_cntrl : STD_LOGIC;
	SIGNAL fft_data : STD_logic_vector(255 DOWNTO 0);
	BEGIN
	TD_RESET <= '1';
	
	--Temp, until FFT
	fft_data <= (OTHERS => '0');
	fft_cntrl <= '1';

	nios2 : nios2VGA
		port map (
			--General stuffs
			clk_clk => CLOCK_50,
			reset_reset_n => KEY(0),
			--red_led_pio_external_connection_export => LEDR,
			green_led_pio_external_connection_export => LEDG,
			nios_cntrl_in_export(7) => fft_cntrl, --Commincation to the Nios2
			nios_cntrl_out_export(7) => n2_cntrl, --Comincation from the Nios2
			
			--VGA stuffs
			vga_controller_external_CLK => VGA_CLK,
			vga_controller_external_HS => VGA_HS,
			vga_controller_external_VS => VGA_VS,
			vga_controller_external_BLANK => VGA_BLANK,
			vga_controller_external_SYNC => VGA_SYNC,
			vga_controller_external_R => VGA_R,
			vga_controller_external_G => VGA_G,
			vga_controller_external_B => VGA_B,
			
			--SRAM stuffs			
			sram_external_interface_DQ =>SRAM_DQ,
			sram_external_interface_ADDR => SRAM_ADDR,
			sram_external_interface_LB_N => SRAM_LB_N,
			sram_external_interface_UB_N => SRAM_UB_N,
			sram_external_interface_CE_N => SRAM_CE_N,
			sram_external_interface_OE_N => SRAM_OE_N,
			sram_external_interface_WE_N => SRAM_WE_N,
			
			--FFT data stuffs
			fft_in_7_export => fft_data (255 DOWNTO 224),
			fft_in_6_export => fft_data (223 DOWNTO 192),
			fft_in_5_export => fft_data (191 DOWNTO 160),
			fft_in_4_export => fft_data (159 DOWNTO 128),
			fft_in_3_export => fft_data (127 DOWNTO 96),
			fft_in_2_export => fft_data (95 DOWNTO 64),
			fft_in_1_export => fft_data (63 DOWNTO 32),
			fft_in_0_export => fft_data (31 DOWNTO 0)
		);
	
END ARCHITECTURE;