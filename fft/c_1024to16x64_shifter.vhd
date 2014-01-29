-- *************************************************************************
-- Author : Wernher Korff																	*
-- Function : shift 1024 samples into fft												*
-- *************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY c_1024to16x64_shifter IS
	PORT
		(
			--X0 downto X1024 ports input from ADC	
		X : IN STD_LOGIC_VECTOR(10239 DOWNTO 0) := (OTHERS => '0');
		
		-- enable : IN STD_LOGIC := '0';
		samples_ready : IN STD_LOGIC := '0';
		clk_in : IN STD_LOGIC := '0';
		
		-- sig_next : OUT STD_LOGIC := '0';
		shift_out : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) := (OTHERS => '0')
		);
END c_1024to16x64_shifter;


--the 4 bit to 7 bit (hex representation) decoding
ARCHITECTURE shift OF c_1024to16x64_shifter IS
	SIGNAL i : INTEGER := 0;
	SIGNAL reading_input : INTEGER := 0;
	-- SIGNAL data_incoming : STD_LOGIC := '0';
		
	BEGIN

	PROCESS(clk_in,samples_ready,reading_input)
		variable shift_out_var: std_logic_vector(159 downto 0) := (OTHERS => '0');
		BEGIN
			
			IF rising_edge(clk_in) THEN
			IF (samples_ready = '1') THEN
				reading_input <= 1;
			END IF;
			
			CASE reading_input IS	-- shift the 1024 samples into the FFT
			WHEN 1 =>
			
			CASE i IS
			WHEN 0 => 
				shift_out_var := X(159 DOWNTO 0);
				i<= i+i;
			WHEN 1 => 
				shift_out_var := X(319 DOWNTO 160);
				i<= i+i;
			WHEN 2 => 
				shift_out_var := X(479 DOWNTO 320);
				i<= i+i;
			WHEN 3 => 
				shift_out_var := X(639 DOWNTO 480);
				i<= i+i;
			WHEN 4 => 
				shift_out_var := X(799 DOWNTO 640);
				i<= i+i;
			WHEN 5 => 
				shift_out_var := X(959 DOWNTO 800);
				i<= i+i;
			WHEN 6 => 
				shift_out_var := X(1119 DOWNTO 960);
				i<= i+i;
			WHEN 7 => 
				shift_out_var := X(1279 DOWNTO 1120);
				i<= i+i;
			WHEN 8 => 
				shift_out_var := X(1439 DOWNTO 1280);
				i<= i+i;
			WHEN 9 => 
				shift_out_var := X(1599 DOWNTO 1440);
				i<= i+i;
			WHEN 10 => 
				shift_out_var := X(1759 DOWNTO 1600);
				i<= i+i;
			WHEN 11 => 
				shift_out_var := X(1919 DOWNTO 1760);
				i<= i+i;
			WHEN 12 => 
				shift_out_var := X(2079 DOWNTO 1920);
				i<= i+i;
			WHEN 13 => 
				shift_out_var := X(2239 DOWNTO 2080);
				i<= i+i;
			WHEN 14 => 
				shift_out_var := X(2399 DOWNTO 2240);
				i<= i+i;
			WHEN 15 => 
				shift_out_var := X(2559 DOWNTO 2400);
				i<= i+i;
			WHEN 16 => 
				shift_out_var := X(2719 DOWNTO 2560);
				i<= i+i;
			WHEN 17 => 
				shift_out_var := X(2879 DOWNTO 2720);
				i<= i+i;
			WHEN 18 => 
				shift_out_var := X(3039 DOWNTO 2880);
				i<= i+i;
			WHEN 19 => 
				shift_out_var := X(3199 DOWNTO 3040);
				i<= i+i;
			WHEN 20 => 
				shift_out_var := X(3359 DOWNTO 3200);
				i<= i+i;
			WHEN 21 => 
				shift_out_var := X(3519 DOWNTO 3360);
				i<= i+i;
			WHEN 22 => 
				shift_out_var := X(3679 DOWNTO 3520);
				i<= i+i;
			WHEN 23 => 
				shift_out_var := X(3839 DOWNTO 3680);
				i<= i+i;
			WHEN 24 => 
				shift_out_var := X(3999 DOWNTO 3840);
				i<= i+i;
			WHEN 25 => 
				shift_out_var := X(4159 DOWNTO 4000);
				i<= i+i;
			WHEN 26 => 
				shift_out_var := X(4319 DOWNTO 4160);
				i<= i+i;
			WHEN 27 => 
				shift_out_var := X(4479 DOWNTO 4320);
				i<= i+i;
			WHEN 28 => 
				shift_out_var := X(4639 DOWNTO 4480);
				i<= i+i;
			WHEN 29 => 
				shift_out_var := X(4799 DOWNTO 4640);
				i<= i+i;
			WHEN 30 => 
				shift_out_var := X(4959 DOWNTO 4800);
				i<= i+i;
			WHEN 31 => 
				shift_out_var := X(5119 DOWNTO 4960);
				i<= i+i;
			WHEN 32 => 
				shift_out_var := X(5279 DOWNTO 5120);
				i<= i+i;
			WHEN 33 => 
				shift_out_var := X(5439 DOWNTO 5280);
				i<= i+i;
			WHEN 34 => 
				shift_out_var := X(5599 DOWNTO 5440);
				i<= i+i;
			WHEN 35 => 
				shift_out_var := X(5759 DOWNTO 5600);
				i<= i+i;
			WHEN 36 => 
				shift_out_var := X(5919 DOWNTO 5760);
				i<= i+i;
			WHEN 37 => 
				shift_out_var := X(6079 DOWNTO 5920);
				i<= i+i;
			WHEN 38 => 
				shift_out_var := X(6239 DOWNTO 6080);
				i<= i+i;
			WHEN 39 => 
				shift_out_var := X(6399 DOWNTO 6240);
				i<= i+i;
			WHEN 40 => 
				shift_out_var := X(6559 DOWNTO 6400);
				i<= i+i;
			WHEN 41 => 
				shift_out_var := X(6719 DOWNTO 6560);
				i<= i+i;
			WHEN 42 => 
				shift_out_var := X(6879 DOWNTO 6720);
				i<= i+i;
			WHEN 43 => 
				shift_out_var := X(7039 DOWNTO 6880);
				i<= i+i;
			WHEN 44 => 
				shift_out_var := X(7199 DOWNTO 7040);
				i<= i+i;
			WHEN 45 => 
				shift_out_var := X(7359 DOWNTO 7200);
				i<= i+i;
			WHEN 46 => 
				shift_out_var := X(7519 DOWNTO 7360);
				i<= i+i;
			WHEN 47 => 
				shift_out_var := X(7679 DOWNTO 7520);
				i<= i+i;
			WHEN 48 => 
				shift_out_var := X(7839 DOWNTO 7680);
				i<= i+i;
			WHEN 49 => 
				shift_out_var := X(7999 DOWNTO 7840);
				i<= i+i;
			WHEN 50 => 
				shift_out_var := X(8159 DOWNTO 8000);
				i<= i+i;
			WHEN 51 => 
				shift_out_var := X(8319 DOWNTO 8160);
				i<= i+i;
			WHEN 52 => 
				shift_out_var := X(8479 DOWNTO 8320);
				i<= i+i;
			WHEN 53 => 
				shift_out_var := X(8639 DOWNTO 8480);
				i<= i+i;
			WHEN 54 => 
				shift_out_var := X(8799 DOWNTO 8640);
				i<= i+i;
			WHEN 55 => 
				shift_out_var := X(8959 DOWNTO 8800);
				i<= i+i;
			WHEN 56 => 
				shift_out_var := X(9119 DOWNTO 8960);
				i<= i+i;
			WHEN 57 => 
				shift_out_var := X(9279 DOWNTO 9120);
				i<= i+i;
			WHEN 58 => 
				shift_out_var := X(9439 DOWNTO 9280);
				i<= i+i;
			WHEN 59 => 
				shift_out_var := X(9599 DOWNTO 9440);
				i<= i+i;
			WHEN 60 => 
				shift_out_var := X(9759 DOWNTO 9600);
				i<= i+i;
			WHEN 61 => 
				shift_out_var := X(9919 DOWNTO 9760);
				i<= i+i;
			WHEN 62 => 
				shift_out_var := X(10079 DOWNTO 9920);
				i<= i+i;
			WHEN 63 => 
				shift_out_var := X(10239 DOWNTO 10080);
				i<= i+i;
			WHEN OTHERS =>
				reading_input <= 0;
				i <= 0;					
				--do-nothing
			END CASE;
				
			WHEN OTHERS =>
			END CASE;
			END IF;
			shift_out <= shift_out_var;
	END PROCESS;

END shift;
