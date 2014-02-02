--This file makes sure the correct data is presented to the Nios

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

ENTITY selector_outputter IS
	PORT (
		--N2_ready, ADC_ready : IN STD_LOGIC; --The inputs. First one staes that the N2 wants new samples, second one that the ADC is ready
		--N2_control, ADC_contrl: OUT STD_LOGIC; --The output controls. The first states that the N2 can begin processing, the second one that the ADC can generate new samples
		
		rst, clk : IN STD_LOGIC; 
		
		next_set : IN STD_LOGIC; --Indicates that the next 16 * 10 bit can be placed on the output
		sets_done : OUT STD_LOGIC; --Indicates that the next 2048 samples must be generated
		
		ADC_samples : IN Std_logic_vector(20479 DOWNTO 0); --The samples
		N2_selection : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) --Current sample selection
	);
END selector_outputter;

ARCHITECTURE SO OF selector_outputter IS 
SIGNAL counter : integer range 0 to 63 := 0;
BEGIN
--The sequencial part
	PROCESS(rst, clk, counter, next_set)
	BEGIN
		IF rst = '1' THEN
			counter <= 0;
		ELSIF RISING_EDGE(clk) AND next_set = '1' AND counter /= 63 THEN
			counter <= counter + 1;
		ELSIF RISING_EDGE(clk) AND next_set = '1' AND counter = 63 THEN
			counter <= 0;
		END IF;
		
		IF counter = 0 THEN
			sets_done <= '1';
		ELSE
			sets_done <= '0';
		END IF;
	END PROCESS;
	
--The concurrent part
	PROCESS(counter, ADC_samples)
		VARIABLE N2_output : STD_LOGIC_VECTOR(159 DOWNTO 0);
	BEGIN
	CASE counter IS 
						WHEN 0 => 
				n2_output := ADC_samples(159 DOWNTO 0);
			WHEN 1 => 
				n2_output := ADC_samples(319 DOWNTO 160);
			WHEN 2 => 
				n2_output := ADC_samples(479 DOWNTO 320);
			WHEN 3 => 
				n2_output := ADC_samples(639 DOWNTO 480);
			WHEN 4 => 
				n2_output := ADC_samples(799 DOWNTO 640);
			WHEN 5 => 
				n2_output := ADC_samples(959 DOWNTO 800);
			WHEN 6 => 
				n2_output := ADC_samples(1119 DOWNTO 960);
			WHEN 7 => 
				n2_output := ADC_samples(1279 DOWNTO 1120);
			WHEN 8 => 
				n2_output := ADC_samples(1439 DOWNTO 1280);
			WHEN 9 => 
				n2_output := ADC_samples(1599 DOWNTO 1440);
			WHEN 10 => 
				n2_output := ADC_samples(1759 DOWNTO 1600);
			WHEN 11 => 
				n2_output := ADC_samples(1919 DOWNTO 1760);
			WHEN 12 => 
				n2_output := ADC_samples(2079 DOWNTO 1920);
			WHEN 13 => 
				n2_output := ADC_samples(2239 DOWNTO 2080);
			WHEN 14 => 
				n2_output := ADC_samples(2399 DOWNTO 2240);
			WHEN 15 => 
				n2_output := ADC_samples(2559 DOWNTO 2400);
			WHEN 16 => 
				n2_output := ADC_samples(2719 DOWNTO 2560);
			WHEN 17 => 
				n2_output := ADC_samples(2879 DOWNTO 2720);
			WHEN 18 => 
				n2_output := ADC_samples(3039 DOWNTO 2880);
			WHEN 19 => 
				n2_output := ADC_samples(3199 DOWNTO 3040);
			WHEN 20 => 
				n2_output := ADC_samples(3359 DOWNTO 3200);
			WHEN 21 => 
				n2_output := ADC_samples(3519 DOWNTO 3360);
			WHEN 22 => 
				n2_output := ADC_samples(3679 DOWNTO 3520);
			WHEN 23 => 
				n2_output := ADC_samples(3839 DOWNTO 3680);
			WHEN 24 => 
				n2_output := ADC_samples(3999 DOWNTO 3840);
			WHEN 25 => 
				n2_output := ADC_samples(4159 DOWNTO 4000);
			WHEN 26 => 
				n2_output := ADC_samples(4319 DOWNTO 4160);
			WHEN 27 => 
				n2_output := ADC_samples(4479 DOWNTO 4320);
			WHEN 28 => 
				n2_output := ADC_samples(4639 DOWNTO 4480);
			WHEN 29 => 
				n2_output := ADC_samples(4799 DOWNTO 4640);
			WHEN 30 => 
				n2_output := ADC_samples(4959 DOWNTO 4800);
			WHEN 31 => 
				n2_output := ADC_samples(5119 DOWNTO 4960);
			WHEN 32 => 
				n2_output := ADC_samples(5279 DOWNTO 5120);
			WHEN 33 => 
				n2_output := ADC_samples(5439 DOWNTO 5280);
			WHEN 34 => 
				n2_output := ADC_samples(5599 DOWNTO 5440);
			WHEN 35 => 
				n2_output := ADC_samples(5759 DOWNTO 5600);
			WHEN 36 => 
				n2_output := ADC_samples(5919 DOWNTO 5760);
			WHEN 37 => 
				n2_output := ADC_samples(6079 DOWNTO 5920);
			WHEN 38 => 
				n2_output := ADC_samples(6239 DOWNTO 6080);
			WHEN 39 => 
				n2_output := ADC_samples(6399 DOWNTO 6240);
			WHEN 40 => 
				n2_output := ADC_samples(6559 DOWNTO 6400);
			WHEN 41 => 
				n2_output := ADC_samples(6719 DOWNTO 6560);
			WHEN 42 => 
				n2_output := ADC_samples(6879 DOWNTO 6720);
			WHEN 43 => 
				n2_output := ADC_samples(7039 DOWNTO 6880);
			WHEN 44 => 
				n2_output := ADC_samples(7199 DOWNTO 7040);
			WHEN 45 => 
				n2_output := ADC_samples(7359 DOWNTO 7200);
			WHEN 46 => 
				n2_output := ADC_samples(7519 DOWNTO 7360);
			WHEN 47 => 
				n2_output := ADC_samples(7679 DOWNTO 7520);
			WHEN 48 => 
				n2_output := ADC_samples(7839 DOWNTO 7680);
			WHEN 49 => 
				n2_output := ADC_samples(7999 DOWNTO 7840);
			WHEN 50 => 
				n2_output := ADC_samples(8159 DOWNTO 8000);
			WHEN 51 => 
				n2_output := ADC_samples(8319 DOWNTO 8160);
			WHEN 52 => 
				n2_output := ADC_samples(8479 DOWNTO 8320);
			WHEN 53 => 
				n2_output := ADC_samples(8639 DOWNTO 8480);
			WHEN 54 => 
				n2_output := ADC_samples(8799 DOWNTO 8640);
			WHEN 55 => 
				n2_output := ADC_samples(8959 DOWNTO 8800);
			WHEN 56 => 
				n2_output := ADC_samples(9119 DOWNTO 8960);
			WHEN 57 => 
				n2_output := ADC_samples(9279 DOWNTO 9120);
			WHEN 58 => 
				n2_output := ADC_samples(9439 DOWNTO 9280);
			WHEN 59 => 
				n2_output := ADC_samples(9599 DOWNTO 9440);
			WHEN 60 => 
				n2_output := ADC_samples(9759 DOWNTO 9600);
			WHEN 61 => 
				n2_output := ADC_samples(9919 DOWNTO 9760);
			WHEN 62 => 
				n2_output := ADC_samples(10079 DOWNTO 9920);
			WHEN 63 => 
				n2_output := ADC_samples(10239 DOWNTO 10080);
			WHEN OTHERS => NULL;
		END CASE;
		N2_selection <= n2_output;
	END PROCESS;
END;