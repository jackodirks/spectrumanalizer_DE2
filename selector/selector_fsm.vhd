--The finite state machine for the selector
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

ENTITY selector_fsm IS 
	PORT (
		N2_ready, ADC_ready : IN STD_LOGIC; --The inputs. First one staes that the N2 wants new samples, second one that the ADC is ready
		N2_control, ADC_contrl: OUT STD_LOGIC; --The output controls. The first states that the N2 can begin processing, the second one that the ADC can generate new samples
		
		rst, clk : IN STD_LOGIC;
		
		ADC_samples : IN Std_logic_vector(20479 DOWNTO 0); --The samples
		N2_selection : OUT STD_LOGIC_VECTOR(159 DOWNTO 0); --Current sample selection
		
		LEDR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END selector_fsm;

ARCHITECTURE fsm OF selector_fsm IS

COMPONENT selector_outputter IS
	PORT (		
		rst, clk : IN STD_LOGIC; 
		
		next_set : IN STD_LOGIC; --Indicates that the next 16 * 10 bit can be placed on the output
		sets_done : OUT STD_LOGIC; --Indicates that the next 2048 samples must be generated
		
		ADC_samples : IN Std_logic_vector(20479 DOWNTO 0); --The samples
		N2_selection : OUT STD_LOGIC_VECTOR(159 DOWNTO 0) --Current sample selection
	);
END COMPONENT;

	SIGNAL next_set : STD_LOGIC; --Indicates that the next 16 * 10 bit can be placed on the output
	SIGNAL sets_done : STD_LOGIC; --Indicates that the next 2048 samples must be generated
		
	--FSM variable
	TYPE state IS (get_adc, data_ready, wait_nios, increment, evaluate);
   
	--Set the type to gray encoding
	--attribute enum_encoding : string;
	--attribute enum_encoding of state : type is "gray";
	
	SIGNAL next_state, present_state : state := get_adc;

BEGIN

	SO : selector_outputter PORT MAP(
		rst => rst,
		clk => clk,
		ADC_samples => ADC_samples,
		N2_selection => N2_selection,
		next_set => next_set,
		sets_done => sets_done
	);
	--Sequencial part of the state machine
	process(rst, clk)
	begin
		if (rst = '1') 
		then
			present_state <= get_adc;
		elsif (rising_edge(clk)) 
		then
			present_state <= next_state;
		end if;
	end process;
	
	--Concurrent part
	PROCESS(present_state,next_state,N2_ready, ADC_ready,sets_done)
	Variable LEDRED : STD_LOGIC_VECTOR (3 DOWNTO 0);
	BEGIN
		CASE present_state IS
		
			WHEN get_adc =>
				IF ADC_ready = '1' THEN
					next_state <= data_ready;
				ELSE 
					next_state <= get_adc;
				END IF;
				N2_control <= '0';
				ADC_contrl <= '1';
				next_set <= '0';
				LEDRED := "0001";
				
			WHEN data_ready =>
				IF N2_ready = '0' THEN
					next_state <= wait_nios;
				ELSE 
					next_state <= data_ready;
				END IF;
				N2_control <= '1';
				ADC_contrl <= '0';
				next_set <= '0';
				LEDRED := "0010";
				
			WHEN wait_nios =>
				IF N2_ready = '1' THEN
					next_state <= increment;
				ELSE 
					next_state <= wait_nios;
				END IF;
				N2_control <= '1';
				ADC_contrl <= '0';
				next_set <= '0';
				LEDRED := "0011";
				
			WHEN increment =>
				next_state <= evaluate;
				N2_control <= '0';
				ADC_contrl <= '0';
				next_set <= '1';
				LEDRED := "0100";
				
			WHEN evaluate =>
				IF sets_done = '1' THEN
					next_state <= get_adc;
				ELSE 
					next_state <= data_ready;
				END IF;
				N2_control <= '0';
				ADC_contrl <= '0';
				next_set <= '0';
				LEDRED := "0101";
				
		END CASE;
		LEDR <= LEDRED;
	END PROCESS;
	
END ARCHITECTURE;