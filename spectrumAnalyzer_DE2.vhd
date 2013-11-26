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
		-- Memory (SDRAM)
		DRAM_DQ				: inout std_logic_vector (15 downto 0);
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
		-- Memory (SDRAM)
		DRAM_ADDR			: out std_logic_vector (11 downto 0);
		DRAM_BA_1			: buffer std_logic;
		DRAM_BA_0			: buffer std_logic;
		DRAM_CAS_N			: out std_logic;
		DRAM_RAS_N			: out std_logic;
		DRAM_CLK			: out std_logic;
		DRAM_CKE			: out std_logic;
		DRAM_CS_N			: out std_logic;
		DRAM_WE_N			: out std_logic;
		DRAM_UDQM			: buffer std_logic;
		DRAM_LDQM			: buffer std_logic;
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
			sdram_wire_addr                          : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_wire_ba                            : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n                         : out   std_logic;                                        -- cas_n
			sdram_wire_cke                           : out   std_logic;                                        -- cke
			sdram_wire_cs_n                          : out   std_logic;                                        -- cs_n
			sdram_wire_dq                            : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                           : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n                         : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                          : out   std_logic                                         -- we_n
		);
	end component nios2VGA;
	signal			 BA : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal			 DQM : STD_LOGIC_VECTOR(1 DOWNTO 0);

	BEGIN
	TD_RESET <= '1';
	DRAM_BA_1  <= BA(1);
	DRAM_BA_0  <= BA(0);
	DRAM_UDQM  <= DQM(1);
	DRAM_LDQM  <= DQM(0);
	
	nios2 : nios2VGA
		port map (
			clk_clk => CLOCK_50,
			reset_reset_n => KEY(0),
			red_led_pio_external_connection_export => LEDR,
			green_led_pio_external_connection_export => LEDG,
			
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
			sram_external_interface_WE_N => SRAM_WE_N,
			
			sdram_clock_clk => DRAM_CLK,
			sdram_wire_addr => DRAM_ADDR,
			sdram_wire_ba => BA,
			sdram_wire_cas_n => DRAM_CAS_N,
			sdram_wire_cke => DRAM_CKE,
			sdram_wire_cs_n => DRAM_CS_N,
			sdram_wire_dq => DRAM_DQ,
			sdram_wire_dqm => DQM,
			sdram_wire_ras_n => DRAM_RAS_N,
			sdram_wire_we_n => DRAM_WE_N
		);
	
END ARCHITECTURE;