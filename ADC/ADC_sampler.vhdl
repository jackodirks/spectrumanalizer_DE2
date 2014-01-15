---------------------------------------------------------------------------------------------------
--- State Machine Template ------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- Author  : PelJH          
-- Date    : 15-09-2010     
-- Version : V1.0
-- Name    : statemachine.vhd
---------------------------------------------------------------------------------------------------
-- Description:             
-- This template is meant to be used by students of the HWP01 course at the Hogeschool Rotterdam
-- It implements a basic FSM in VHDL. Please note that there are many other ways to do this.
-- Students may also use the FSM templates by Altera that can be found in the template library of
-- Quartus. Also other templates are allowed that can be found in books and online. It is mandatory,
-- however, that the FSM templates used give a good vice-versa overview in relation to the FSM 
-- diagram that must be drawn for the assignments.
---------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ADC_sampler is 
	port	( 	
				-- clock and reset
				CLOCK_50:  	in std_logic;
				CLOCK_27:	IN STD_LOGIC;
				reset: 		in std_logic;
				
				-- list of inputs
				CONTROL:   	in std_logic;								--start/stop input
				--KEY:   		in std_logic_vector(0 downto 0);
				ADC_BUSY:	in std_logic;
				ADC:    		inout std_logic_vector(11 downto 0);
				
				-- list of outputs
				DONE:    	out std_logic;								--samples are ready
				--LEDR:   		out std_logic_vector(7 downto 0);
				LEDG:   		out std_logic_vector(7 downto 0);
				ADC_CLKIN:  out std_logic;	
				ADC_CONVST: out std_logic;
				ADC_WB: 		out std_logic;
				ADC_WR:		out std_logic;
				ADC_RD: 		out std_logic;
				ADC_CS: 		out std_logic;	
				
				
				samp0:   out std_logic_vector(7 downto 0);
				samp1:   out std_logic_vector(7 downto 0);
				samp2:   out std_logic_vector(7 downto 0);
				samp3:   out std_logic_vector(7 downto 0);
				samp4:   out std_logic_vector(7 downto 0);
				samp5:   out std_logic_vector(7 downto 0);
				samp6:   out std_logic_vector(7 downto 0);
				samp7:   out std_logic_vector(7 downto 0);
				samp8:   out std_logic_vector(7 downto 0);
				samp9:   out std_logic_vector(7 downto 0);
				samp10:   out std_logic_vector(7 downto 0);
				samp11:   out std_logic_vector(7 downto 0);
				samp12:   out std_logic_vector(7 downto 0);
				samp13:   out std_logic_vector(7 downto 0);
				samp14:   out std_logic_vector(7 downto 0);
				samp15:   out std_logic_vector(7 downto 0)
				
			);
end ADC_sampler;

architecture ADC_sampler of ADC_sampler is

component ADC_CLK_prescaler IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0			: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
END component;

component ADC_setup_timer IS
	PORT
	(
		clock_50m	: IN STD_LOGIC;
		reset		: IN STD_LOGIC;
		done		: OUT STD_LOGIC
	);
END component;

component ADC_sample_timer IS
	PORT
	(
		clock_50m: IN STD_LOGIC;
		reset		: IN STD_LOGIC;
		done		: OUT STD_LOGIC
	);
END component;

component ADC_sample_counter IS
	PORT
	(
		clock_50m	: IN STD_LOGIC;
		increment	: IN STD_LOGIC;
		reset		: IN STD_LOGIC;
		done		: OUT STD_LOGIC;
		count		: OUT STD_LOGIC_VECTOR(11 downto 0)
	);
END component;

signal CLOCK_10	: STD_LOGIC;
SIGNAL timer_reset: STD_LOGIC ;
SIGNAL timer_done	: STD_LOGIC ;

SIGNAL setup_timer_reset: STD_LOGIC ;
SIGNAL setup_timer_done	: STD_LOGIC ;

SIGNAL sample_counter_increment : STD_LOGIC ;
SIGNAL sample_counter_reset: STD_LOGIC ;
SIGNAL sample_counter_done	: STD_LOGIC ;
Signal sample_count : STD_LOGIC_VECTOR(11 downto 0);


-------------------------------------------------------------------
-- state definitions and signals ----------------------------------
-------------------------------------------------------------------
	type state is ( state_0,
					state_1,
					state_2,
					state_3,
					state_4);
						
	signal present_state, next_state: state;

begin

	ADC_CLKIN	<= CLOCK_10;

	prescaler : ADC_CLK_prescaler
	port map
	(
		inclk0 => CLOCK_27, 
		c0 => CLOCK_10
	);

	timer : ADC_sample_timer
	port map
	(
		clock_50m => CLOCK_50,
		reset	=> timer_reset,
		done => timer_done
	);
	
	setup_timer : ADC_setup_timer
	port map
	(
		clock_50m => CLOCK_50,
		reset	=> setup_timer_reset,
		done => setup_timer_done
	);
	
	sample_counter : ADC_sample_counter
	port map
	(
		clock_50m => CLOCK_50,
		increment => sample_counter_increment,
		reset	=> sample_counter_reset,
		done => sample_counter_done,
		count => sample_count
	);

-------------------------------------------------------------------
-- sequential part of the statemachine ----------------------------
-------------------------------------------------------------------
	process(reset, CLOCK_50)
	begin
		if (reset = '0') 
		then
			present_state <= state_0;
		elsif (rising_edge(CLOCK_50)) 
		then
			present_state <= next_state;
		end if;
	end process;
-------------------------------------------------------------------
	
-------------------------------------------------------------------
-- combinatorial part of the statemachine -------------------------
-------------------------------------------------------------------
	process (--KEY,
				ADC,
				-- add other inputs to use for next state testing 
				-- or to generate outputs with
				present_state,
				timer_done,
				setup_timer_done,
				sample_counter_done,
				sample_count,
				CONTROL
				)
				
	------------------------------- gen by c
	variable temp0: std_logic_vector(11 downto 0) := "000000000000";
	variable temp1: std_logic_vector(11 downto 0) := "000000000000";
	variable temp2: std_logic_vector(11 downto 0) := "000000000000";
	variable temp3: std_logic_vector(11 downto 0) := "000000000000";
	variable temp4: std_logic_vector(11 downto 0) := "000000000000";
	variable temp5: std_logic_vector(11 downto 0) := "000000000000";
	variable temp6: std_logic_vector(11 downto 0) := "000000000000";
	variable temp7: std_logic_vector(11 downto 0) := "000000000000";
	variable temp8: std_logic_vector(11 downto 0) := "000000000000";
	variable temp9: std_logic_vector(11 downto 0) := "000000000000";
	variable temp10: std_logic_vector(11 downto 0) := "000000000000";
	variable temp11: std_logic_vector(11 downto 0) := "000000000000";
	variable temp12: std_logic_vector(11 downto 0) := "000000000000";
	variable temp13: std_logic_vector(11 downto 0) := "000000000000";
	variable temp14: std_logic_vector(11 downto 0) := "000000000000";
	variable temp15: std_logic_vector(11 downto 0) := "000000000000";
	----------------------------------------
	begin
	
-- Default values of outputs
			DONE			<= '0';
			ADC_CONVST	<= '0';
			ADC_WB		<= '1';
			ADC_WR		<= '1';
			ADC_RD		<= '1';
			ADC_CS		<= '1';
			LEDG 			<= "00000000";
			ADC 			<= "ZZZZZZZZZZZZ";
			timer_reset <= '1';
			setup_timer_reset <= '1';
			
			sample_counter_increment <= '0';
			sample_counter_reset <= '1';
		
			--LEDR(7 downto 0) <= "00000000";
		
		case present_state is
--------------------------------------
-- state 0  INIT                    --
--------------------------------------
			when state_0 =>
				--------------------------
				-- determine next state --
				--------------------------
				if (setup_timer_done = '1')
				then
					next_state <= state_1;
				else
					next_state <= present_state;
				end if;
				--------------------------
				--  determine outputs   --
				--------------------------
				DONE			<= '0';
				ADC_CONVST	<= '1';
				ADC_WB		<= '1';
				ADC_WR		<= '0';
				ADC_RD		<= '1';
				ADC_CS		<= '0';
				LEDG 			<= "00000001";
				ADC 			<= "000000010110"; -- tows compliment <= "001000010110";
				timer_reset <= '1';
				setup_timer_reset <= '0';	
							
				sample_counter_increment <= '0';
				sample_counter_reset <= '1';
		
--------------------------------------
-- state 1  IDLE                    --
--------------------------------------
			when state_1 =>
				--------------------------
				-- determine next state --
				--------------------------
				if (CONTROL = '1') --START
				then
					next_state <= state_2;
				else
					next_state <= present_state;
				end if;
				--------------------------
				--  determine outputs   --
				--------------------------
				DONE			<= '0';
				ADC_CONVST	<= '1';
				ADC_WB		<= '1';
				ADC_WR		<= '1';
				ADC_RD		<= '1';
				ADC_CS		<= '0';
				ADC 			<= "ZZZZZZZZZZZZ";
				LEDG 			<= "00000010";
				timer_reset <= '1';
				setup_timer_reset <= '1';
							
				sample_counter_increment <= '0';
				sample_counter_reset <= '1';

--------------------------------------
-- state 2 sample wait              --
--------------------------------------
			when state_2 =>
				--------------------------
				-- determine next state --
				--------------------------
				if (timer_done = '1')
				then
					next_state <= state_3;
				else
					next_state <= present_state;
				end if;
				--------------------------
				--  determine outputs   --
				--------------------------
				DONE			<= '0';
				ADC_CONVST	<= '0';
				ADC_WB		<= '1';
				ADC_WR		<= '1';
				ADC_RD		<= '0';
				ADC_CS		<= '0';
				ADC 			<= "ZZZZZZZZZZZZ";
				LEDG 			<= "00000100";
				timer_reset <= '0';
				setup_timer_reset <= '1';
				
				sample_counter_increment <= '0';
				sample_counter_reset <= '0';
--------------------------------------
-- state 3 grab sample              --
--------------------------------------
			when state_3 =>
				--------------------------
				-- determine next state --
				--------------------------
				if (timer_done = '0') then
					if (sample_counter_done = '0') then
						next_state <= state_2;
					elsif(sample_counter_done = '1') then
						next_state <= state_4;
					end if;
				else
					next_state <= present_state;
				end if;
				--------------------------
				--  determine outputs   --
				--------------------------
				DONE			<= '0';
				ADC_CONVST	<= '1';
				ADC_WB		<= '1';
				ADC_WR		<= '1';
				ADC_RD		<= '0';
				ADC_CS		<= '0';
				ADC 			<= "ZZZZZZZZZZZZ";
				LEDG 			<= "00001000";
				timer_reset <= '1';
				setup_timer_reset <= '1';
				
				sample_counter_increment <= '1';
				sample_counter_reset <= '0';
				
				case to_integer(unsigned(sample_count)) is
					------------------------------- gen by c	
						when 0 => temp0 := ADC;
						when 1 => temp1 := ADC;
						when 2 => temp2 := ADC;
						when 3 => temp3 := ADC;
						when 4 => temp4 := ADC;
						when 5 => temp5 := ADC;
						when 6 => temp6 := ADC;
						when 7 => temp7 := ADC;
						when 8 => temp8 := ADC;
						when 9 => temp9 := ADC;
						when 10 => temp10 := ADC;
						when 11 => temp11 := ADC;
						when 12 => temp12 := ADC;
						when 13 => temp13 := ADC;
						when 14 => temp14 := ADC;
						when 15 => temp15 := ADC;
						when others => null;
					----------------------------------------
					end case;
--------------------------------------
-- state 4 done              		--
--------------------------------------
			when state_4 =>
				--------------------------
				-- determine next state --
				--------------------------
				if (CONTROL = '0')
				then
					next_state <= state_1;
				else
					next_state <= present_state;
				end if;
				--------------------------
				--  determine outputs   --
				--------------------------
				DONE			<= '1';
				ADC_CONVST	<= '1';
				ADC_WB		<= '1';
				ADC_WR		<= '1';
				ADC_RD		<= '1';
				ADC_CS		<= '0';
				ADC 			<= "ZZZZZZZZZZZZ";
				LEDG 			<= "00010000";
				timer_reset <= '1';
				setup_timer_reset <= '1';
				sample_counter_increment <= '0';
				sample_counter_reset <= '1';
--------------------------------------
--  unknown state returns to init   --
--------------------------------------
			when others =>
				next_state <= state_0;
		end case;
-------------------------------------------------------------------	

------------------------------- gen by c		
		--LEDR	<= temp0(11 downto 4);
		samp0	<= temp0(11 downto 4);
		samp1	<= temp1(11 downto 4);
		samp2	<= temp2(11 downto 4);
		samp3	<= temp3(11 downto 4);
		samp4	<= temp4(11 downto 4);
		samp5	<= temp5(11 downto 4);
		samp6	<= temp6(11 downto 4);
		samp7	<= temp7(11 downto 4);
		samp8	<= temp8(11 downto 4);
		samp9	<= temp9(11 downto 4);
		samp10	<= temp10(11 downto 4);
		samp11	<= temp11(11 downto 4);
		samp12	<= temp12(11 downto 4);
		samp13	<= temp13(11 downto 4);
		samp14	<= temp14(11 downto 4);
		samp15	<= temp15(11 downto 4);


----------------------------------------

	end process;
end ADC_sampler;