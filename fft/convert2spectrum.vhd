-- *************************************************************************
-- Author : Wernher Korff																	*
-- Function : convert fft data into spectrum magnitude bins						*
-- *************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY convert2spectrum IS
	PORT(
		-- R is real and I is imaginary
		XR : IN STD_LOGIC_VECTOR(159 DOWNTO 0) := (OTHERS => '0');
		XI : IN STD_LOGIC_VECTOR(159 DOWNTO 0) := (OTHERS => '0');
		V : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) := (OTHERS => '0');	
		
		next_bin_set : OUT STD_LOGIC := '0'; -- signal receiving end new bin set data available.
		incoming64sets : IN STD_LOGIC := '0'; -- 128 sets of 16 sample incoming (signaled by next out from fft)
		fft_finished : OUT STD_LOGIC := '0'; -- The fft data has left the process
		clk_in : IN STD_LOGIC := '0';
		
		converting : OUT STD_LOGIC := '0');	-- to stop the clock of fft and input shifter
END convert2spectrum;


ARCHITECTURE convert of convert2spectrum IS

	
	SIGNAL sub_wire_0 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_1 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_2 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_3 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_4 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_5 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_6 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_7 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_8 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_9 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_10 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_11 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_12 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_13 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_14 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_15 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_16 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_17 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_18 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_19 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_20 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_21 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_22 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_23 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_24 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_25 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_26 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_27 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_28 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_29 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_30 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_31 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_32 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_33 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_34 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_35 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_36 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_37 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_38 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_39 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_40 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_41 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_42 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_43 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_44 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_45 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_46 : STD_LOGIC_VECTOR(20 DOWNTO 0) := (others => '0');
	SIGNAL sub_wire_47 : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
	
	COMPONENT multiply
		PORT
		(
			clock0: IN STD_LOGIC  := '1';
			dataa_0: IN STD_LOGIC_VECTOR (9 DOWNTO 0) :=  (OTHERS => '0');
			dataa_1: IN STD_LOGIC_VECTOR (9 DOWNTO 0) :=  (OTHERS => '0');
			datab_0: IN STD_LOGIC_VECTOR (9 DOWNTO 0) :=  (OTHERS => '0');
			datab_1: IN STD_LOGIC_VECTOR (9 DOWNTO 0) :=  (OTHERS => '0');
			result: OUT STD_LOGIC_VECTOR (20 DOWNTO 0) :=  (OTHERS => '0')
		);
	END COMPONENT; --multadd
	
	COMPONENT sqrt
		PORT
		(
			clk: IN STD_LOGIC ;
			radical: IN STD_LOGIC_VECTOR (20 DOWNTO 0);
			q: OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
			remainder: OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
		);
	END COMPONENT; --sqrt
	
	BEGIN	
	multadd0 : multiply
		PORT MAP(clk_in, XR(9 DOWNTO 0),  XR(9 DOWNTO 0), XI(9 DOWNTO 0), XI(9 DOWNTO 0), sub_wire_0);
	sqrt0 : sqrt
		PORT MAP(clk_in, sub_wire_0, sub_wire_1);
	multadd1 : multiply
		PORT MAP(clk_in, XR(19 DOWNTO 10),  XR(19 DOWNTO 10), XI(19 DOWNTO 10), XI(19 DOWNTO 10), sub_wire_2);
	sqrt1 : sqrt
		PORT MAP(clk_in, sub_wire_2, sub_wire_3);
	multadd2 : multiply
		PORT MAP(clk_in, XR(29 DOWNTO 20),  XR(29 DOWNTO 20), XI(29 DOWNTO 20), XI(29 DOWNTO 20), sub_wire_4);
	sqrt2 : sqrt
		PORT MAP(clk_in, sub_wire_4, sub_wire_5);
	multadd3 : multiply
		PORT MAP(clk_in, XR(39 DOWNTO 30),  XR(39 DOWNTO 30), XI(39 DOWNTO 30), XI(39 DOWNTO 30), sub_wire_6);
	sqrt3 : sqrt
		PORT MAP(clk_in, sub_wire_6, sub_wire_7);
	multadd4 : multiply
		PORT MAP(clk_in, XR(49 DOWNTO 40),  XR(49 DOWNTO 40), XI(49 DOWNTO 40), XI(49 DOWNTO 40), sub_wire_8);
	sqrt4 : sqrt
		PORT MAP(clk_in, sub_wire_8, sub_wire_9);
	multadd5 : multiply
		PORT MAP(clk_in, XR(59 DOWNTO 50),  XR(59 DOWNTO 50), XI(59 DOWNTO 50), XI(59 DOWNTO 50), sub_wire_10);
	sqrt5 : sqrt
		PORT MAP(clk_in, sub_wire_10, sub_wire_11);
	multadd6 : multiply
		PORT MAP(clk_in, XR(69 DOWNTO 60),  XR(69 DOWNTO 60), XI(69 DOWNTO 60), XI(69 DOWNTO 60), sub_wire_12);
	sqrt6 : sqrt
		PORT MAP(clk_in, sub_wire_12, sub_wire_13);
	multadd7 : multiply
		PORT MAP(clk_in, XR(79 DOWNTO 70),  XR(79 DOWNTO 70), XI(79 DOWNTO 70), XI(79 DOWNTO 70), sub_wire_14);
	sqrt7 : sqrt
		PORT MAP(clk_in, sub_wire_14, sub_wire_15);
	multadd8 : multiply
		PORT MAP(clk_in, XR(89 DOWNTO 80),  XR(89 DOWNTO 80), XI(89 DOWNTO 80), XI(89 DOWNTO 80), sub_wire_16);
	sqrt8 : sqrt
		PORT MAP(clk_in, sub_wire_16, sub_wire_17);
	multadd9 : multiply
		PORT MAP(clk_in, XR(99 DOWNTO 90),  XR(99 DOWNTO 90), XI(99 DOWNTO 90), XI(99 DOWNTO 90), sub_wire_18);
	sqrt9 : sqrt
		PORT MAP(clk_in, sub_wire_18, sub_wire_19);
	multadd10 : multiply
		PORT MAP(clk_in, XR(109 DOWNTO 100),  XR(109 DOWNTO 100), XI(109 DOWNTO 100), XI(109 DOWNTO 100), sub_wire_20);
	sqrt10 : sqrt
		PORT MAP(clk_in, sub_wire_20, sub_wire_21);
	multadd11 : multiply
		PORT MAP(clk_in, XR(119 DOWNTO 110),  XR(119 DOWNTO 110), XI(119 DOWNTO 110), XI(119 DOWNTO 110), sub_wire_22);
	sqrt11 : sqrt
		PORT MAP(clk_in, sub_wire_22, sub_wire_23);
	multadd12 : multiply
		PORT MAP(clk_in, XR(129 DOWNTO 120),  XR(129 DOWNTO 120), XI(129 DOWNTO 120), XI(129 DOWNTO 120), sub_wire_24);
	sqrt12 : sqrt
		PORT MAP(clk_in, sub_wire_24, sub_wire_25);
	multadd13 : multiply
		PORT MAP(clk_in, XR(139 DOWNTO 130),  XR(139 DOWNTO 130), XI(139 DOWNTO 130), XI(139 DOWNTO 130), sub_wire_26);
	sqrt13 : sqrt
		PORT MAP(clk_in, sub_wire_26, sub_wire_27);
	multadd14 : multiply
		PORT MAP(clk_in, XR(149 DOWNTO 140),  XR(149 DOWNTO 140), XI(149 DOWNTO 140), XI(149 DOWNTO 140), sub_wire_28);
	sqrt14 : sqrt
		PORT MAP(clk_in, sub_wire_28, sub_wire_29);
	multadd15 : multiply
		PORT MAP(clk_in, XR(159 DOWNTO 150),  XR(159 DOWNTO 150), XI(159 DOWNTO 150), XI(159 DOWNTO 150), sub_wire_30);
	sqrt15 : sqrt
		PORT MAP(clk_in, sub_wire_30, sub_wire_31);
		
	PROCESS(clk_in, incoming64sets)
	VARIABLE convert : STD_LOGIC := '0';
	VARIABLE step : INTEGER := 0;
	VARIABLE count_fft : INTEGER := 0;
	VARIABLE next_bin_set_var : STD_LOGIC := '0';
	VARIABLE varV : STD_LOGIC_VECTOR (159 DOWNTO 0) := (OTHERS => '0');
	BEGIN
	IF rising_edge(clk_in) THEN
		IF (incoming64sets = '1') THEN
			convert := '1';
			converting <= '1';
			next_bin_set_var := '0';
		END IF;
			IF (convert = '1') THEN
				CASE step IS
					WHEN 7 =>
						varV(9 DOWNTO 0) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_1(10 DOWNTO 1))) - 1024),10));
						varV(19 DOWNTO 10) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_3(10 DOWNTO 1))) - 1024),10));
						varV(29 DOWNTO 20) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_5(10 DOWNTO 1))) - 1024),10));
						varV(39 DOWNTO 30) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_7(10 DOWNTO 1))) - 1024),10));
						varV(49 DOWNTO 40) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_9(10 DOWNTO 1))) - 1024),10));
						varV(59 DOWNTO 50) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_11(10 DOWNTO 1))) - 1024),10));
						varV(69 DOWNTO 60) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_13(10 DOWNTO 1))) - 1024),10));
						varV(79 DOWNTO 70) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_15(10 DOWNTO 1))) - 1024),10));
						varV(89 DOWNTO 80) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_17(10 DOWNTO 1))) - 1024),10));
						varV(99 DOWNTO 90) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_19(10 DOWNTO 1))) - 1024),10));
						varV(109 DOWNTO 100) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_21(10 DOWNTO 1))) - 1024),10));
						varV(119 DOWNTO 110) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_23(10 DOWNTO 1))) - 1024),10));
						varV(129 DOWNTO 120) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_25(10 DOWNTO 1))) - 1024),10));
						varV(139 DOWNTO 130) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_27(10 DOWNTO 1))) - 1024),10));
						varV(149 DOWNTO 140) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_29(10 DOWNTO 1))) - 1024),10));
						varV(159 DOWNTO 150) := std_logic_vector(to_unsigned((to_integer(unsigned(sub_wire_31(10 DOWNTO 1))) - 1024),10));

						--convert := '1';
						step := 0;
						next_bin_set_var := '1';
						--converting <= '1';
						count_fft := count_fft + 1; -- count to 128 then ssert fft_finished high
						
						IF (count_fft = 64) THEN
							fft_finished <= '1';
							count_fft := 0;
						END IF;
					WHEN OTHERS =>
						step := step + 1;
				END CASE;
				next_bin_set <= next_bin_set_var;
			END IF;
		END IF;
		V <= varV;
	END PROCESS;
END convert;
