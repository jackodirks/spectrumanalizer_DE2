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


ENTITY fft_state_machine IS
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
END fft_state_machine;


ARCHITECTURE runsys OF fft_state_machine IS
--SIGNAL X : STD_LOGIC_VECTOR(10239 DOWNTO 0) := (OTHERS => '0');
SIGNAL spectrum_ready :STD_LOGIC := '0';
SIGNAL fft_ready : STD_LOGIC := '0';
SIGNAL state : STD_LOGIC_VECTOR(3 dOWNTO 0) := (OTHERS => '0')

BEGIN
	PROCESS(X,processor_ready,samples_ready,clk)
	IF RISING_EDGE(clk) THEN
		state(0) := samples_ready;
		state(1) := processor_ready;
		state(2) := fft_ready;
		state(3) := spectrum_ready;
		
		CASE state is
		--STATE 0
		WHEN 0 =>
			state := 2
			--init
		--STATE1
		WHEN 2 OR 6 is =>
			-- request new samples
		--STATE2
		WHEN 10 OR 14 =>
			-- receiving new sampl edata
		--STATE3
		WHEN 0 OR 4 OR 8 OR 12 =>
			-- processing
		--STATE4
		WHEN OTHERS => --3,7,11,15
			-- undefined
		--variable ;
	END IF;
	BEGIN
END ARCHITECTURE;
