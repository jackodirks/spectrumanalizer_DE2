--|---------------------------------------------------------------------|--
--| Name : 				state_machine.vhd												|--
--| Description :		This entity sets the signals according to the		|--
--|						state the system is in										|--
--| Version :			0.2																|--
--| Author :			Wernher Korff							|--
--|---------------------------------------------------------------------|--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY fft_periphal IS
	PORT
	(
	samples_ready : IN STD_LOGIC := '0';	-- sampler has 1024 samples ready
	fft_ready : OUT STD_LOGIC := '0';	-- the system is idle / can receive data

	processor_ready : IN STD_LOGIC := '0';	-- receiving side status
	spectrum_ready : OUT STD_LOGIC := '0'; -- the FFT has data ready for output / cycle data

	X : IN STD_LOGIC_VECTOR(10239 DOWNTO 0) := (OTHERS => '0');
	clk : IN STD_LOGIC := '0';
	
	-- data ouput for interfacing device 64 sets of 16 
	V : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) := (OTHERS => '0')
	);
END fft_periphal;


ARCHITECTURE runsys OF fft_periphal IS
--SIGNAL X : STD_LOGIC_VECTOR(10239 DOWNTO 0) := (OTHERS => '0');
SIGNAL SIG_spectrum_ready :STD_LOGIC := '0';
SIGNAL SIG_fft_ready : STD_LOGIC := '0';
SIGNAL SIG_state : STD_LOGIC_VECTOR(3 dOWNTO 0) := (OTHERS => '0');
SIGNAL SIG_last_state : STD_LOGIC_VECTOR(3 dOWNTO 0) := (OTHERS => '0');

BEGIN
	PROCESS(X,processor_ready,samples_ready,clk)
	BEGIN
		IF RISING_EDGE(clk) THEN
			SIG_state(0) <= samples_ready;
			SIG_state(1) <= processor_ready;
			SIG_state(2) <= SIG_fft_ready;
			SIG_state(3) <= SIG_spectrum_ready;
			
			CASE SIG_state is
			--STATE 0
			WHEN "0000" =>
				IF (SIG_last_state = "0000") THEN
					SIG_state <= "0010";
				ELSE
					--something went wrong
				END IF;
				--init
			--STATE1
			WHEN ("0010" OR "0110") =>	-- 2 or 6
				-- request new samples
			--STATE2
			WHEN ("1010" OR "1110") =>	-- 10 or 14
				-- receiving new sampl edata
			--STATE3
			WHEN ("0000" OR "0100" OR "1000" OR "1100") =>	-- 0, 4, 8, 12
				-- processing
			--STATE4
			WHEN OTHERS => --3,7,11,15
				-- undefined
			--variable ;
			END CASE;
		END IF;
	END PROCESS;
END ARCHITECTURE;
