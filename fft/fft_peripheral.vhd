-- *************************************************************************
-- Author : Wernher Korff																	*
-- Function : connects the underlying architecture together and expose the *
--				FFT peripheral inputs and outputs										*
-- *************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

-- Top Block --
ENTITY fft_peripheral IS
	PORT
	(
	X : IN STD_LOGIC_VECTOR(10239 DOWNTO 0) := (OTHERS => '0');
	samples_ready : IN STD_LOGIC := '0';	-- sampler has 1024 samples ready
	clk : IN STD_LOGIC := '0';
	fft_finished : OUT STD_LOGIC := '0';	-- the system is idle / can receive data
	
	busy : IN STD_LOGIC := '0';	-- receiving side status
	data_ready : OUT STD_LOGIC := '0'; -- the FFT has data ready for output / cycle data
	
	-- data ouput for interfacing device 64 sets of 16 
	V : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) := (OTHERS => '0')
	);
END fft_peripheral;


-- mapping together of components --
ARCHITECTURE interconnect OF fft_peripheral IS
	
	-- the fft block --
	COMPONENT dft_top
	PORT (
		clk : IN STD_LOGIC := '0';
		reset : IN STD_LOGIC := '0';
		nexti : IN STD_LOGIC := '0';
		next_out : OUT STD_LOGIC := '0';
		X0 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X1 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X2 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X3 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X4 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X5 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X6 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X7 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X8 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X9 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X10 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X11 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X12 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X13 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X14 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X15 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X16 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X17 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X18 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X19 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X20 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X21 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X22 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X23 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X24 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X25 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X26 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X27 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X28 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X29 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X30 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		X31 : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		
		Y0 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y1 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y2 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y3 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y4 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y5 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y6 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y7 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y8 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y9 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y10 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y11 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y12 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y13 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y14 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y15 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y16 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y17 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y18 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y19 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y20 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y21 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y22 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y23 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y24 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y25 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y26 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y27 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y28 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y29 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y30 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
		Y31 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000");
	END COMPONENT; -- dft_top
	
	-- controls the clock to th efft and input shifter, when busy is '0' and converting '0' then clock is active,
	-- otherwise it is inactive
	COMPONENT clock_control
	PORT
	(
		clock : IN STD_LOGIC := '0';
		ready : IN STD_LOGIC := '0';
		converting : IN STD_LOGIC := '0';
		clk : OUT STD_LOGIC := '0'
	);
	END COMPONENT; -- clock_control
	
	
	-- divvides 1024 samples into 64 sets of 16 samples each --
	COMPONENT c_1024to16x64_shifter
		PORT 
		(
		X : IN STD_LOGIC_VECTOR(10239 DOWNTO 0) := (OTHERS => '0');
		samples_ready : IN STD_LOGIC := '0';	-- sampler has 1024 samples ready, connected to fft_peripheral pin
		
		clk_in : IN STD_LOGIC;
		
		-- sig_next : OUT STD_LOGIC := '0';
		shift_out : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) := (OTHERS => '0') 
		);
	END COMPONENT;	--c_1024to16x64_shifter
	
	COMPONENT convert2spectrum
	PORT
		(
		-- R is real and I is imaginary
		XR : IN STD_LOGIC_VECTOR(159 DOWNTO 0) := (others => '0');
		XI: IN STD_LOGIC_VECTOR(159 DOWNTO 0) := (others => '0');
		V : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) := (others => '0');
		
		next_bin_set : OUT STD_LOGIC := '0'; -- signal receiving end new bin set data available.
		incoming64sets : IN STD_LOGIC := '0'; -- 64 sets of 16 sample incoming (signaled by next out from fft)
		fft_finished : OUT STD_LOGIC := '0'; -- The fft data has left the process
		clk_in : IN STD_LOGIC := '0';

		converting : OUT STD_LOGIC := '0'
		);	-- to stop the clock of fft and input shifter 
	END COMPONENT; -- c_10bit2char_vga_H256
	
	SIGNAL ready, fft_finished_sig, incoming64sets, clk_in, converting, clk_int,may_send : STD_LOGIC := '0';
	SIGNAL XDFT : STD_LOGIC_VECTOR(159 DOWNTO 0) := (others => '0');
	SIGNAL YDFT : STD_LOGIC_VECTOR(319 DOWNTO 0) := (others => '0');

	BEGIN
	
	output : convert2spectrum
	PORT MAP(
		-- R is real and I is imaginary
		XR(9 DOWNTO 0) => YDFT(9 DOWNTO 0),
		XI(9 DOWNTO 0)=> YDFT(19 DOWNTO 10),
		XR(19 DOWNTO 10) => YDFT(29 DOWNTO 20),
		XI(19 DOWNTO 10) => YDFT(39 DOWNTO 30),
		XR(29 DOWNTO 20) => YDFT(49 DOWNTO 40),
		XI(29 DOWNTO 20) => YDFT(59 DOWNTO 50),
		XR(39 DOWNTO 30) => YDFT(69 DOWNTO 60),
		XI(39 DOWNTO 30) => YDFT(79 DOWNTO 70),
		XR(49 DOWNTO 40) => YDFT(89 DOWNTO 80),
		XI(49 DOWNTO 40) => YDFT(99 DOWNTO 90),
		XR(59 DOWNTO 50) => YDFT(109 DOWNTO 100),
		XI(59 DOWNTO 50) => YDFT(119 DOWNTO 110),
		XR(69 DOWNTO 60) => YDFT(129 DOWNTO 120),
		XI(69 DOWNTO 60) => YDFT(139 DOWNTO 130),
		XR(79 DOWNTO 70) => YDFT(149 DOWNTO 140),
		XI(79 DOWNTO 70) => YDFT(159 DOWNTO 150),
		XR(89 DOWNTO 80) => YDFT(169 DOWNTO 160),
		XI(89 DOWNTO 80) => YDFT(179 DOWNTO 170),
		XR(99 DOWNTO 90) => YDFT(189 DOWNTO 180),
		XI(99 DOWNTO 90) => YDFT(199 DOWNTO 190),
		XR(109 DOWNTO 100) => YDFT(209 DOWNTO 200),
		XI(109 DOWNTO 100) => YDFT(219 DOWNTO 210),
		XR(119 DOWNTO 110) => YDFT(229 DOWNTO 220),
		XI(119 DOWNTO 110) => YDFT(239 DOWNTO 230),
		XR(129 DOWNTO 120) => YDFT(249 DOWNTO 240),
		XI(129 DOWNTO 120) => YDFT(259 DOWNTO 250),
		XR(139 DOWNTO 130) => YDFT(269 DOWNTO 260),
		XI(139 DOWNTO 130) => YDFT(279 DOWNTO 270),
		XR(149 DOWNTO 140) => YDFT(289 DOWNTO 280),
		XI(149 DOWNTO 140) => YDFT(299 DOWNTO 290),
		XR(159 DOWNTO 150) => YDFT(309 DOWNTO 300),
		XI(159 DOWNTO 150) => YDFT(319 DOWNTO 310),
	
		V => V,

		next_bin_set => data_ready, -- signal receiving end new bin set data available.
		incoming64sets => incoming64sets, -- 64 sets of 16 sample incoming (signaled by next out from fft)
		fft_finished => fft_finished_sig, -- The fft data has left the process
		clk_in => clk,
		
		converting => converting
	);	-- to stop the clock of fft and input shifter 
	
	dft_top0 : dft_top
	PORT MAP(
		next_out => incoming64sets,	
		clk => clk_int,
		reset => fft_finished_sig,
		nexti => samples_ready,
		X0 => XDFT(9 DOWNTO 0),
		X1 => (OTHERS => '0'),
		X2 => XDFT(19 DOWNTO 10),
		X3 => (OTHERS => '0'),
		X4 => XDFT(29 DOWNTO 20),
		X5 => (OTHERS => '0'),
		X6 => XDFT(39 DOWNTO 30),
		X7 => (OTHERS => '0'),
		X8 => XDFT(49 DOWNTO 40),
		X9 => (OTHERS => '0'),
		X10 => XDFT(59 DOWNTO 50),
		X11 => (OTHERS => '0'),
		X12 => XDFT(69 DOWNTO 60),
		X13 => (OTHERS => '0'),
		X14 => XDFT(79 DOWNTO 70),
		X15 => (OTHERS => '0'),
		X16 => XDFT(89 DOWNTO 80),
		X17 => (OTHERS => '0'),
		X18 => XDFT(99 DOWNTO 90),
		X19 => (OTHERS => '0'),
		X20 => XDFT(109 DOWNTO 100),
		X21 => (OTHERS => '0'),
		X22 => XDFT(119 DOWNTO 110),
		X23 => (OTHERS => '0'),
		X24 => XDFT(129 DOWNTO 120),
		X25 => (OTHERS => '0'),
		X26 => XDFT(139 DOWNTO 130),
		X27 => (OTHERS => '0'),
		X28 => XDFT(149 DOWNTO 140),
		X29 => (OTHERS => '0'),
		X30 => XDFT(159 DOWNTO 150),
		X31 => (OTHERS => '0'),
		
		Y0 => YDFT(9 DOWNTO 0),
		Y1 => YDFT(19 DOWNTO 10),
		Y2 => YDFT(29 DOWNTO 20),
		Y3 => YDFT(39 DOWNTO 30),
		Y4 => YDFT(49 DOWNTO 40),
		Y5 => YDFT(59 DOWNTO 50),
		Y6 => YDFT(69 DOWNTO 60),
		Y7 => YDFT(79 DOWNTO 70),
		Y8 => YDFT(89 DOWNTO 80),
		Y9 => YDFT(99 DOWNTO 90),
		Y10 => YDFT(109 DOWNTO 100),
		Y11 => YDFT(119 DOWNTO 110),
		Y12 => YDFT(129 DOWNTO 120),
		Y13 => YDFT(139 DOWNTO 130),
		Y14 => YDFT(149 DOWNTO 140),
		Y15 => YDFT(159 DOWNTO 150),
		Y16 => YDFT(169 DOWNTO 160),
		Y17 => YDFT(179 DOWNTO 170),
		Y18 => YDFT(189 DOWNTO 180),
		Y19 => YDFT(199 DOWNTO 190),
		Y20 => YDFT(209 DOWNTO 200),
		Y21 => YDFT(219 DOWNTO 210),
		Y22 => YDFT(229 DOWNTO 220),
		Y23 => YDFT(239 DOWNTO 230),
		Y24 => YDFT(249 DOWNTO 240),
		Y25 => YDFT(259 DOWNTO 250),
		Y26 => YDFT(269 DOWNTO 260),
		Y27 => YDFT(279 DOWNTO 270),
		Y28 => YDFT(289 DOWNTO 280),
		Y29 => YDFT(299 DOWNTO 290),
		Y30 => YDFT(309 DOWNTO 300),
		Y31 => YDFT(319 DOWNTO 310)		
	);
		
		clock_control0 : clock_control
		PORT MAP
		(
			clock => clk,
			ready => busy, --May send van C/VGA code, toekomstige werner, die zich dit afvraagd.
			converting => converting,
			clk => clk_int
		);
		
		c_1024to16x64_shifter0: c_1024to16x64_shifter
		PORT MAP
		(
		X => X,
		samples_ready => samples_ready,
		clk_in => clk_int,
		
		shift_out => XDFT
		);

		fft_finished <= fft_finished_sig;

-- start_shiftin <= 
END interconnect;
