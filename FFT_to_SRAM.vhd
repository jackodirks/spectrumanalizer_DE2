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
USE ieee.std_logic_unsigned.ALL;


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
	PROCESS(clk,ctrl_rcv,nios_ctr_rcv,data,avalon_acknowledge) 
	VARIABLE writing_data  : STD_LOGIC := '0'; --indicates if we are currently writing to the SRAM
	CONSTANT buffer_a : STD_LOGIC_VECTOR(18 DOWNTO 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(309248,18)); --Buffer A 0x4B800
	CONSTANT buffer_b : STD_LOGIC_VECTOR(18 DOWNTO 0) := STD_LOGIC_VECTOR(TO_UNSIGNED(310272,18)); --Buffer B 0x4BC00
	VARIABLE buffer_is_a : BOOLEAN := TRUE; --Indicates if the current buffer is buffer a
	VARIABLE buffer_ready, send_started, preparation_finished, send_done, backup_buffer_ready : BOOLEAN := FALSE; --Indicates if the NIOS 2 is done with its buffer
	VARIABLE data_ready : BOOLEAN := FALSE;
	VARIABLE amount_send : UNSIGNED(6 DOWNTO 0) := TO_UNSIGNED(0,7);
	VARIABLE ctrl_snd_buf : STD_LOGIC := '0';
	BEGIN
		IF RISING_EDGE(ctrl_rcv) OR FALLING_EDGE(ctrl_rcv) THEN --A new sample is ready
			--First, set the address
			IF preparation_finished = FALSE THEN --Send has not yet started, prepare basic shit for starting
				IF buffer_is_a = TRUE THEN
					avalon_address <= buffer_a;
					buffer_is_a := FALSE;
				ELSE
					avalon_address <= buffer_b;
					buffer_is_a := TRUE;
				END IF;
				preparation_finished := TRUE;
			END IF;
			data_ready := TRUE;
			--Preparation done, wait for buffer being ready and start sending
		END IF;
		
		IF preparation_finished = TRUE AND  buffer_ready = TRUE AND data_ready = TRUE THEN --Everything is ready: start sending
			send_started := TRUE;
			avalon_write_data <= data;
			avalon_write <= '1';
			avalon_read <= '0';
			data_ready := FALSE;
		END IF;
		
		IF RISING_EDGE(avalon_acknowledge) THEN
			amount_send := amount_send + 1;
			IF amount_send = TO_UNSIGNED(128,7) THEN --All data has been send, reset everything
				preparation_finished := FALSE;
				buffer_ready := FALSE;
				send_started := FALSE;
			END IF;
			avalon_write <= '0';
			ctrl_snd_buf := NOT ctrl_snd_buf;
			ctrl_snd <= ctrl_snd_buf;
		END IF;
		
		IF RISING_EDGE(nios_ctr_rcv) OR FALLING_EDGE(nios_ctr_rcv) THEN
			IF send_started = TRUE THEN
				backup_buffer_ready := TRUE;
			ELSE
				buffer_ready := TRUE; --IF the vhdl is still sending, write to a temporary backup
			END IF;
		END IF;
		
		IF backup_buffer_ready = TRUE AND send_started = FALSE THEN --After the write is done, immedeatly notify the system that another buffer can be written
			buffer_ready := TRUE;
			backup_buffer_ready := FALSE;
		END IF;
	END PROCESS;
END ARCHITECTURE;