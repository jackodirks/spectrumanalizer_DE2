library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY fft_tld IS
PORT (
	adc_samples : IN STD_LOGIC_VECTOR(20479 DOWNTO 0);
	fft_samples : OUT STD_LOGIC_VECTOR(159 DOWNTO 0);
	samples_ready : IN STD_LOGIC := '0';	-- sampler has 2048 samples ready
	clk : IN STD_LOGIC := '0';
	fft_finished : OUT STD_LOGIC := '0';	-- the system is idle / can receive data
	busy : IN STD_LOGIC := '0';	-- receiving side status
	data_ready : OUT STD_LOGIC := '0' -- the FFT has data ready for output / cycle data
	);
END ENTITY;

ARCHITECTURE fft_tld OF fft_tld IS
	COMPONENT fft_peripheral IS
	PORT(
		X : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";	
		samples_ready : IN STD_LOGIC := '0';	-- sampler has 2048 samples ready
		clk : IN STD_LOGIC := '0';
		fft_finished : OUT STD_LOGIC := '0';	-- the system is idle / can receive data
	
		busy : IN STD_LOGIC := '0';	-- receiving side status
		data_ready : OUT STD_LOGIC := '0'; -- the FFT has data ready for output / cycle data
		
		-- data ouput for interfacing device 64 sets of 16 
		V0 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V1 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V2 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V3 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V4 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V5 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V6 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V7 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V8 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V9 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V10 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V11 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V12 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V13 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V14 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		V15 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000"
);
END COMPONENT;

BEGIN	

fft_peripheral_imp : fft_peripheral PORT MAP (
	X => adc_samples,
	samples_ready => samples_ready,	-- sampler has 2048 samples ready
	clk => clk,
	fft_finished => fft_finished,	-- the system is idle / can receive data
	busy => busy,	-- receiving side status
	data_ready => data_ready, -- the FFT has data ready for output / cycle data
		V0 => fft_samples(9 DOWNTO 0),
	V1 => fft_samples(19 DOWNTO 10),
	V2 => fft_samples(29 DOWNTO 20),
	V3 => fft_samples(39 DOWNTO 30),
	V4 => fft_samples(49 DOWNTO 40),
	V5 => fft_samples(59 DOWNTO 50),
	V6 => fft_samples(69 DOWNTO 60),
	V7 => fft_samples(79 DOWNTO 70),
	V8 => fft_samples(89 DOWNTO 80),
	V9 => fft_samples(99 DOWNTO 90),
	V10 => fft_samples(109 DOWNTO 100),
	V11 => fft_samples(119 DOWNTO 110),
	V12 => fft_samples(129 DOWNTO 120),
	V13 => fft_samples(139 DOWNTO 130),
	V14 => fft_samples(149 DOWNTO 140),
	V15 => fft_samples(159 DOWNTO 150)	
);

END ARCHITECTURE;