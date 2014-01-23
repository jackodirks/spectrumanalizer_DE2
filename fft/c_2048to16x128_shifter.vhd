-- *************************************************************************
-- Author : Wernher Korff																	*
-- Function : shift 2048 samples into fft												*
-- *************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;


--Shifts in 8 samples for parallel data ouput N=8 big
ENTITY c_2048to16x128_shifter IS
	PORT
		(
			--X0 downto X2048 ports input from ADC	
		X : IN STD_LOGIC_VECTOR(20479 DOWNTO 0) := (OTHERS => '0');
		
		-- enable : IN STD_LOGIC := '0';
		samples_ready : IN STD_LOGIC := '0';
		clk_in : IN STD_LOGIC := '0';
		
		-- sig_next : OUT STD_LOGIC := '0';
		shift_out : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) := (OTHERS => '0')
		);
END c_2048to16x128_shifter;


--the 4 bit to 7 bit (hex representation) decoding
ARCHITECTURE shift OF c_2048to16x128_shifter IS
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
			
			CASE reading_input IS	-- shift the 2048 samples into the FFT
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
			WHEN 64 => 
				shift_out_var := X(10399 DOWNTO 10240);
				i<= i+i;
			WHEN 65 => 
				shift_out_var := X(10559 DOWNTO 10400);
				i<= i+i;
			WHEN 66 => 
				shift_out_var := X(10719 DOWNTO 10560);
				i<= i+i;
			WHEN 67 => 
				shift_out_var := X(10879 DOWNTO 10720);
				i<= i+i;
			WHEN 68 => 
				shift_out_var := X(11039 DOWNTO 10880);
				i<= i+i;
			WHEN 69 => 
				shift_out_var := X(11199 DOWNTO 11040);
				i<= i+i;
			WHEN 70 => 
				shift_out_var := X(11359 DOWNTO 11200);
				i<= i+i;
			WHEN 71 => 
				shift_out_var := X(11519 DOWNTO 11360);
				i<= i+i;
			WHEN 72 => 
				shift_out_var := X(11679 DOWNTO 11520);
				i<= i+i;
			WHEN 73 => 
				shift_out_var := X(11839 DOWNTO 11680);
				i<= i+i;
			WHEN 74 => 
				shift_out_var := X(11999 DOWNTO 11840);
				i<= i+i;
			WHEN 75 => 
				shift_out_var := X(12159 DOWNTO 12000);
				i<= i+i;
			WHEN 76 => 
				shift_out_var := X(12319 DOWNTO 12160);
				i<= i+i;
			WHEN 77 => 
				shift_out_var := X(12479 DOWNTO 12320);
				i<= i+i;
			WHEN 78 => 
				shift_out_var := X(12639 DOWNTO 12480);
				i<= i+i;
			WHEN 79 => 
				shift_out_var := X(12799 DOWNTO 12640);
				i<= i+i;
			WHEN 80 => 
				shift_out_var := X(12959 DOWNTO 12800);
				i<= i+i;
			WHEN 81 => 
				shift_out_var := X(13119 DOWNTO 12960);
				i<= i+i;
			WHEN 82 => 
				shift_out_var := X(13279 DOWNTO 13120);
				i<= i+i;
			WHEN 83 => 
				shift_out_var := X(13439 DOWNTO 13280);
				i<= i+i;
			WHEN 84 => 
				shift_out_var := X(13599 DOWNTO 13440);
				i<= i+i;
			WHEN 85 => 
				shift_out_var := X(13759 DOWNTO 13600);
				i<= i+i;
			WHEN 86 => 
				shift_out_var := X(13919 DOWNTO 13760);
				i<= i+i;
			WHEN 87 => 
				shift_out_var := X(14079 DOWNTO 13920);
				i<= i+i;
			WHEN 88 => 
				shift_out_var := X(14239 DOWNTO 14080);
				i<= i+i;
			WHEN 89 => 
				shift_out_var := X(14399 DOWNTO 14240);
				i<= i+i;
			WHEN 90 => 
				shift_out_var := X(14559 DOWNTO 14400);
				i<= i+i;
			WHEN 91 => 
				shift_out_var := X(14719 DOWNTO 14560);
				i<= i+i;
			WHEN 92 => 
				shift_out_var := X(14879 DOWNTO 14720);
				i<= i+i;
			WHEN 93 => 
				shift_out_var := X(15039 DOWNTO 14880);
				i<= i+i;
			WHEN 94 => 
				shift_out_var := X(15199 DOWNTO 15040);
				i<= i+i;
			WHEN 95 => 
				shift_out_var := X(15359 DOWNTO 15200);
				i<= i+i;
			WHEN 96 => 
				shift_out_var := X(15519 DOWNTO 15360);
				i<= i+i;
			WHEN 97 => 
				shift_out_var := X(15679 DOWNTO 15520);
				i<= i+i;
			WHEN 98 => 
				shift_out_var := X(15839 DOWNTO 15680);
				i<= i+i;
			WHEN 99 => 
				shift_out_var := X(15999 DOWNTO 15840);
				i<= i+i;
			WHEN 100 => 
				shift_out_var := X(16159 DOWNTO 16000);
				i<= i+i;
			WHEN 101 => 
				shift_out_var := X(16319 DOWNTO 16160);
				i<= i+i;
			WHEN 102 => 
				shift_out_var := X(16479 DOWNTO 16320);
				i<= i+i;
			WHEN 103 => 
				shift_out_var := X(16639 DOWNTO 16480);
				i<= i+i;
			WHEN 104 => 
				shift_out_var := X(16799 DOWNTO 16640);
				i<= i+i;
			WHEN 105 => 
				shift_out_var := X(16959 DOWNTO 16800);
				i<= i+i;
			WHEN 106 => 
				shift_out_var := X(17119 DOWNTO 16960);
				i<= i+i;
			WHEN 107 => 
				shift_out_var := X(17279 DOWNTO 17120);
				i<= i+i;
			WHEN 108 => 
				shift_out_var := X(17439 DOWNTO 17280);
				i<= i+i;
			WHEN 109 => 
				shift_out_var := X(17599 DOWNTO 17440);
				i<= i+i;
			WHEN 110 => 
				shift_out_var := X(17759 DOWNTO 17600);
				i<= i+i;
			WHEN 111 => 
				shift_out_var := X(17919 DOWNTO 17760);
				i<= i+i;
			WHEN 112 => 
				shift_out_var := X(18079 DOWNTO 17920);
				i<= i+i;
			WHEN 113 => 
				shift_out_var := X(18239 DOWNTO 18080);
				i<= i+i;
			WHEN 114 => 
				shift_out_var := X(18399 DOWNTO 18240);
				i<= i+i;
			WHEN 115 => 
				shift_out_var := X(18559 DOWNTO 18400);
				i<= i+i;
			WHEN 116 => 
				shift_out_var := X(18719 DOWNTO 18560);
				i<= i+i;
			WHEN 117 => 
				shift_out_var := X(18879 DOWNTO 18720);
				i<= i+i;
			WHEN 118 => 
				shift_out_var := X(19039 DOWNTO 18880);
				i<= i+i;
			WHEN 119 => 
				shift_out_var := X(19199 DOWNTO 19040);
				i<= i+i;
			WHEN 120 => 
				shift_out_var := X(19359 DOWNTO 19200);
				i<= i+i;
			WHEN 121 => 
				shift_out_var := X(19519 DOWNTO 19360);
				i<= i+i;
			WHEN 122 => 
				shift_out_var := X(19679 DOWNTO 19520);
				i<= i+i;
			WHEN 123 => 
				shift_out_var := X(19839 DOWNTO 19680);
				i<= i+i;
			WHEN 124 => 
				shift_out_var := X(19999 DOWNTO 19840);
				i<= i+i;
			WHEN 125 => 
				shift_out_var := X(20159 DOWNTO 20000);
				i<= i+i;
			WHEN 126 => 
				shift_out_var := X(20319 DOWNTO 20160);
				i<= i+i;
			WHEN 127 => 
				shift_out_var := X(20479 DOWNTO 20320);
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
