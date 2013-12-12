			--vhdl_to_avalon_external_interface_address     : in    std_logic_vector(18 downto 0)  := (others => 'X'); -- address
			--vhdl_to_avalon_external_interface_byte_enable : in    std_logic_vector(15 downto 0)  := (others => 'X'); -- byte_enable
			--vhdl_to_avalon_external_interface_read        : in    std_logic                      := 'X';             -- read
			--vhdl_to_avalon_external_interface_write       : in    std_logic                      := 'X';             -- write
			--vhdl_to_avalon_external_interface_write_data  : in    std_logic_vector(127 downto 0) := (others => 'X'); -- write_data
			--vhdl_to_avalon_external_interface_acknowledge : out   std_logic;                                         -- acknowledge
			--vhdl_to_avalon_external_interface_read_data   : out   std_logic_vector(127 downto 0)  

			--Buffers:
			--Buffer a: 0x4B800
			--Buffer B: 0x4BC00
			--128 steps, then buffer switch
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY FFT_to_SRAM IS
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
END FFT_to_SRAM;
	
ARCHITECTURE FFT_to_SRAM OF FFT_to_SRAM IS
BEGIN
	PROCESS(clk,ctrl_rcv,data,avalon_acknowledge) 
	VARIABLE ctrl_rcv_old  : STD_LOGIC := '0'; --Indicate if the signal has been flipped
	VARIABLE writing_data  : STD_LOGIC := '0'; --indicates if we are currently writing to the SRAM
	VARIABLE nios_ctr_rcv_old : STD_LOGIC := '0'; --Indicates the previous NIOS2 signal
	CONSTANT buffer_a : STD_LOGIC_VECTOR(18 DOWNTO 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(0x4B800,18)); --Buffer A
	CONSTANT buffer_b : STD_LOGIC_VECTOR(18 DOWNTO 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(0x4BC00,18)); --Buffer B
	BEGIN
		IF FALLING_EDGE(clk) THEN
			IF NOT ctrl_rcv_old = ctrl_rcv THEN --We can start sending the data
			
				
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;