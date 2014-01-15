LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.all;

ENTITY rotary_decoder IS
  PORT(
    button, clk, rst : IN STD_LOGIC;
    grayCode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    counter : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); ----(2^16 - 1) 65535 <= maxval
    pressed : OUT STD_LOGIC --Indicates if the button was pressed or not
  );
END rotary_decoder;

ARCHITECTURE FSM OF rotary_decoder IS
   
  COMPONENT rotary_encoder_debouncer IS --Just a timer
  PORT(
    clk, rst : IN STD_LOGIC;
    count_done : OUT STD_LOGIC
  );
  END COMPONENT;
  
  COMPONENT rotary_encoder_counter IS --The counter for the current value
  PORT(
    clk, rst, increment, decrement : IN STD_LOGIC;
    count_value : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) --(2^ 17 - 1) 131071 <= maxval 
  );
END COMPONENT;

COMPONENT rotary_decoder_button_state IS
  PORT (
    invert_output, clk : IN STD_LOGIC;
    button_state : OUT STD_LOGIC
  );
END COMPONENT;
  
  SIGNAL debounce_reset, button_debounce_reset, count_reset : STD_LOGIC := '1';
  SIGNAL debounce_done, button_debounce_done : STD_LOGIC;
  SIGNAL cnt_increment, cnt_decrement, button_invert : STD_LOGIC := '0';
  TYPE rotary_state IS (reset, start, start_wait, evaluate_start, select_p, wait_i, wait_d, evaluate_i, evaluate_d, increment, decrement);
  TYPE button_state IS (start_button, start_wait_button, start_evaluate_button, pressed_wait, pressed_evaluate, invert);
   
	--Set the type to gray encoding
	attribute enum_encoding : string;
	attribute enum_encoding of rotary_state : type is "gray";
	attribute enum_encoding of button_state : type is "gray";
	
  SIGNAL present_state_rotary, next_state_rotary : rotary_state := reset;
  SIGNAL present_state_button, next_state_button : button_state := start_button;
  
  BEGIN

    
    --Implement debouncer for the rotary enocder
    rotaryDeb : rotary_encoder_debouncer PORT MAP (
      clk => clk,
      rst => debounce_reset,
      count_done => debounce_done
    );
    
    --Implement debouncer for the pushButton
    buttonDeb : rotary_encoder_debouncer PORT MAP (
      clk => clk,
      rst => button_debounce_reset,
      count_done => button_debounce_done
    );
    
    --Implement the counter
    REC : rotary_encoder_counter PORT MAP (
      clk => clk, 
      rst => count_reset,
      increment => cnt_increment, 
      decrement => cnt_decrement,
      count_value => counter
    );
    
    --Implement the controller for the pushbutton
    button_proc: rotary_decoder_button_state PORT MAP (
      clk => clk,
      invert_output => button_invert,
      button_state => pressed
    );
        
    --seqencial part: reset and next state (for both state machines)
    PROCESS(rst, clk)
    BEGIN
        IF rst = '1' THEN
          present_state_rotary <= reset;
          present_state_button <= start_button;
        ELSIF rising_edge(clk) THEN
          present_state_rotary <= next_state_rotary;
          present_state_button <= next_state_button;
        END IF;
      END PROCESS;
      
    --Process the rotary input
    PROCESS(grayCode, present_state_rotary, next_state_rotary, debounce_done)
    BEGIN
      CASE present_state_rotary IS
      WHEN  reset =>
        next_state_rotary <= start;
        debounce_reset <= '1';
        count_reset <= '1';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN start =>
        IF grayCode = "00" THEN
          next_state_rotary <= start_wait;
        ELSE
          next_state_rotary <= start;
        END IF; -- GRAYCODE
        debounce_reset <= '1';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN start_wait => --Debounce state
        IF debounce_done = '1' THEN
          next_state_rotary <= evaluate_start;
        ELSE 
          next_state_rotary <= start_wait;
        END IF; --Debounce done
        debounce_reset <= '0';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN  evaluate_start => --second debounce state
        IF grayCode = "00" THEN
          next_state_rotary <= select_p;
        ELSE
          next_state_rotary <= start;
        END IF;
        debounce_reset <= '1';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN select_p =>
        IF grayCode = "01" THEN --Decrement
          next_state_rotary <= wait_d;
        ELSIF grayCode = "10" THEN --Increment
          next_state_rotary <= wait_i;
        ELSE
          next_state_rotary <= select_p;
        END IF; --graycode check
        debounce_reset <= '1';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN wait_d => --If decrement, debounce
        IF debounce_done = '1' THEN
          next_state_rotary <= evaluate_d;
        ELSE
          next_state_rotary <= wait_d;
        END IF; --graycode check
        debounce_reset <= '0';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN evaluate_d =>
        IF grayCode = "01" THEN
          next_state_rotary <= decrement;
        ELSE
          next_state_rotary <= start;
        END IF; --graycode check
        debounce_reset <= '1';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN decrement =>
        next_state_rotary <= start;
        debounce_reset <= '1';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '1';
        
      WHEN wait_i => --If decrement, debounce
        IF debounce_done = '1' THEN
          next_state_rotary <= evaluate_i;
        ELSE
          next_state_rotary <= wait_i;
        END IF; --graycode check
        debounce_reset <= '0';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN evaluate_i =>
        IF grayCode = "10" THEN
          next_state_rotary <= increment;
        ELSE
          next_state_rotary <= start;
        END IF; --graycode check
        debounce_reset <= '1';
        count_reset <= '0';
        cnt_increment <= '0';
        cnt_decrement <= '0';
        
      WHEN increment =>
        next_state_rotary <= start;
        debounce_reset <= '1';
        count_reset <= '0';
        cnt_increment <= '1';
        cnt_decrement <= '0';	  
        
		WHEN OTHERS => --Should be impossible, but oh well
			next_state_rotary <= start;
			debounce_reset <= '1';
			count_reset <= '0';
			cnt_increment <= '0';
			cnt_decrement <= '0';
		  
      END CASE;                
    END PROCESS;
    
    --Process the button input
    PROCESS(button, present_state_button, next_state_button, button_debounce_done)
    BEGIN
      
      CASE present_state_button IS
        
      WHEN start_button =>
        IF button = '0' THEN
          next_state_button <= start_wait_button;
        ELSE
          next_state_button <= start_button;
        END IF;
        button_debounce_reset <= '1';
        button_invert <= '0';
        
      WHEN start_wait_button =>
        IF button_debounce_done = '1' THEN
          next_state_button <= start_evaluate_button;
        ELSE
          next_state_button <= start_wait_button;
        END IF;
        button_debounce_reset <= '0';
        button_invert <= '0';
        
      WHEN start_evaluate_button =>
        IF button = '0' THEN
          next_state_button <= pressed_wait;
        ELSE
          next_state_button <= start_button;
        END IF;
        button_debounce_reset <= '1';
        button_invert <= '0';
        
        
      WHEN pressed_wait =>
        IF button = '1' THEN
          next_state_button <= pressed_evaluate;
        ELSE
          next_state_button <= pressed_wait;
        END IF;
        button_debounce_reset <= '1';
        button_invert <= '0';
        
      WHEN pressed_evaluate =>
        IF button_debounce_done = '1' THEN
          next_state_button <= invert;
        ELSE
          next_state_button <= pressed_evaluate;
        END IF;
        button_debounce_reset <= '0';
        button_invert <= '0';
        
      WHEN invert =>
        IF button = '1' THEN
          button_debounce_reset <= '1';
          button_invert <= '1';
          next_state_button <= start_button;
        ELSE
          button_debounce_reset <= '1';
          button_invert <= '0';
          next_state_button <= start_button;
        END IF;
                
      END CASE;
    END PROCESS;
    
END ARCHITECTURE;