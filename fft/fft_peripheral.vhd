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


ENTITY fft_peripheral IS
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
END fft_peripheral;


ARCHITECTURE runsys OF fft_peripheral IS

COMPONENT spiraldft is
PORT(
	clk : IN STD_LOGIC := '0';
	reset : IN STD_LOGIC := '0';
	nexti : IN STD_LOGIC := '0';
	next_out : OUT STD_LOGIC := '0';
	X0 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X2 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X4 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X6 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X8 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X10 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X12 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X14 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X16 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X18 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X20 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X22 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X24 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X26 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X28 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X30 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	X32 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	
	Y0 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y1 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y2 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y3 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y4 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y5 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y6 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y7 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y8 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y9 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y10 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y11 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y12 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y13 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y14 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y15 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y16 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y17 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y18 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y19 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y20 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y21 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y22 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y23 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y24 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y25 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y26 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y27 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y28 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y29 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y30 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
	Y31 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000"
);
END COMPONENT; --spiral-dft1390990531
--SIGNAL X : STD_LOGIC_VECTOR(10239 DOWNTO 0) := (OTHERS => '0');
SIGNAL SIG_spectrum_ready :STD_LOGIC := '0';
SIGNAL SIG_fft_ready : STD_LOGIC := '0';
SIGNAL SIG_state : STD_LOGIC_VECTOR(3 dOWNTO 0) := "1111";
SIGNAL SIG_last_state : STD_LOGIC_VECTOR(3 dOWNTO 0) := "1111";

SIGNAL fft_clk : STD_LOGIC := clk;
SIGNAL SIG_next_out : STD_LOGIC := '0';
SIGNAL SIG_next_in : STD_LOGIC := '0';

SIGNAL SIG_XFFT0 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT1 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT2 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT3 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT4 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT5 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT6 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT7 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT8 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT9 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT10 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT11 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT12 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT13 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT14 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
SIGNAL SIG_XFFT15 : STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');

BEGIN
	
	dft : spiraldft PORT MAP(
		X0 => SIG_XFFT0,
		SIG_XFFT1 => X2,
		SIG_XFFT2 => X4,
		SIG_XFFT3 => X6,
		SIG_XFFT4 => X8,
		SIG_XFFT5 => X10,
		SIG_XFFT6 => X12,
		SIG_XFFT7 => X14,
		SIG_XFFT8 => X16,
		SIG_XFFT9 => X18,
		SIG_XFFT10 => X20,
		SIG_XFFT11 => X22,
		SIG_XFFT12 => X24,
		SIG_XFFT13 => X26,
		SIG_XFFT14 => X28,
		SIG_XFFT15 => X30,

		
		Y0 => POLARX0,
		Y1 => POLARY0,
		Y2 => POLARX1,
		Y3 => POLARY1,
		Y4 => POLARX2,
		Y5 => POLARY2,
		Y6 => POLARX3,
		Y7 => POLARY3,
		Y8 => POLARX4,
		Y9 => POLARY4,
		Y10 => POLARX5,
		Y11 => POLARY5,
		Y12 => POLARX6,
		Y13 => POLARY6,
		Y14 => POLARX7,
		Y15 => POLARY7,
		Y16 => POLARX8,
		Y17 => POLARY8,
		Y18 => POLARX9,
		Y19 => POLARY9,
		Y20 => POLARX10,
		Y21 => POLARY10,
		Y22 => POLARX11,
		Y23 => POLARY11,
		Y24 => POLARX12,
		Y25 => POLARY12,
		Y26 => POLARX13,
		Y27 => POLARY13,
		Y28 => POLARX14,
		Y29 => POLARY14,
		Y30 => POLARX15,
		Y31 => POLARY15,

		
		clk <= fft_clk,
		nexti <= SIG_next_in,
		next_out <= SIG_next_out
	);
	
	PROCESS(X,processor_ready,samples_ready,clk)

	VARIABLE NUMADCBITS: INTEGER := 10239;	-- Total number of bits in one total fft data set
	VARIABLE FFTSETSIZE: INTEGER := 16;	-- Number of sample sin one set
	VARIABLE FFTBITSIZE : INTEGER := 10;	-- Number of bits in a sample
	VARIABLE OFFSET: INTEGER := 0;	-- The counting offset
	VARIABLE NUMSETS : INTEGER := 64;	-- Number of sets
	VARIABLE i : INTEGER := NUMSETS-1;	--  General couter
	
	BEGIN
		IF RISING_EDGE(clk) THEN
			SIG_state(0) <= samples_ready;
			SIG_state(1) <= processor_ready;
			SIG_state(2) <= SIG_fft_ready;
			SIG_state(3) <= SIG_spectrum_ready;
			
			IF (SIG_last_state = "1111") THEN	--unbdefined default
				SIG_state <= "0010";
			END IF;
			
			-----------------------
			-- 	STATE MACHINE	--
			-----------------------
			CASE SIG_state is
			
			--STATE 0
			--WHEN "0000" =>
			--	IF (SIG_last_state = "0000") THEN
			--	ELSE
			--		SIG_last_state <= SIG_state;
			--	END IF;
				--init
			
			--STATE1
			-- request new samples
			WHEN ("0010" OR "0110") =>	-- 2 or 6
				--IF (SIG_last_state = "
				SIG_fft_ready <= '1';
				SIG_last_state <= SIG_state;
			
			-- receiving new sample data
			--STATE2
			WHEN ("1010" OR "1110") =>	-- 10 or 14
				IF (i = 0) THEN
					SIG_fft_ready <= '0';	-- last set sent
				ELSIF (i = (NUMSETS - 1)) THEN
					SIG_next_in <= '1';	-- first set sent to FFT module, sinal FFt module
				ELSE
					SIG_next_in <= '0';	-- lower signal on following cycle
				END IF;
				
				SIG_XFFT0 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*15) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*15) - 9));
				SIG_XFFT1 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*14) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*14) - 9));
				SIG_XFFT2 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*13) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*13) - 9));
				SIG_XFFT3 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*12) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*12) - 9));
				SIG_XFFT4 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*11) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*11) - 9));
				SIG_XFFT5 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*10) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*10) - 9));
				SIG_XFFT6 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*9) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*9) - 9));
				SIG_XFFT7 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*8) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*8) - 9));
				SIG_XFFT8 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*7) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*7) - 9));
				SIG_XFFT9 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*6) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*6) - 9));
				SIG_XFFT10 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*5) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*5) - 9));
				SIG_XFFT11 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*4) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*4) - 9));
				SIG_XFFT12 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*3) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*3) - 9));
				SIG_XFFT13 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*2) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*2) - 9));
				SIG_XFFT14 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*1) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*1) - 9));
				SIG_XFFT15 <= X(((NUMADCBITS - FFTSETSIZE*i) - 9*0) DOWNTO (((NUMADCBITS - FFTSETSIZE*i) - 9*0) - 9));
				i := i - 1;
				
				fft_clk <= clk;	-- strobe the fft module
			
			
			-----------------------------------
			-- sending fft data to vga module--
			------------------------------------
			WHEN ("0101" OR "1011") =>	-- 5 or 13
				fft_clk <= clk;	-- strobe the fft module
				
			
			-----------------
			-- processing
			--STATE3
			-----------------
			WHEN ("0000" OR "0100" OR "1000" OR "1100") =>	-- 0, 4, 8, 12
				fft_clk <= clk;	-- strobe the fft module
			
			
			-----------------
			-- reality seized
			-- STATE4
			-----------------
			WHEN OTHERS => --3,7,11,15
				-- these cannot happen
				-- undefined
				-- something went horribly wrong
			--variable ;
			END CASE;
			
			-----------------------------------------------
			-- check fft module for new fft data set (64)--
			-----------------------------------------------
			IF (SIG_next_out = '1') THEN
				SIG_fft_ready <= SIG_next_out;
				SIG_next_out <= '0';
			END IF;
			
			--clkfft_clk
		ELSE
			fft_clk <= clk;
		END IF;
	END PROCESS;
END ARCHITECTURE;
