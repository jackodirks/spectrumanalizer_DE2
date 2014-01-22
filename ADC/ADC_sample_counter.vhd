library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

ENTITY ADC_sample_counter IS
	PORT
	(
		clock_50m	: IN STD_LOGIC;
		increment	: IN STD_LOGIC;
		reset		: IN STD_LOGIC;
		done		: OUT STD_LOGIC;
		count		: OUT STD_LOGIC_VECTOR(11 downto 0)
	);
END ADC_sample_counter;


ARCHITECTURE ADC_sample_counter OF ADC_sample_counter IS
	
BEGIN
process (clock_50m)
	 variable   cnt    : integer range 0 to 2048 := 0;
    begin
        if (rising_edge(clock_50m)) then
            if reset = '1' then
                -- Reset the counter to 0
                cnt := 0;
					 done <= '0';
				else 
					if increment = '1' and cnt < 2048 then
						cnt := cnt + 1;
					end if;
					
					if cnt = 2048 then
						done <= '1';
					else
						done <= '0';
					end if;
				end if;
        end if;
		  count <= STD_LOGIC_VECTOR(to_unsigned(cnt, 12));
    end process;

END ADC_sample_counter;
