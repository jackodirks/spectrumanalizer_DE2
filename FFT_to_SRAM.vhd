			--vhdl_to_avalon_external_interface_address     : in    std_logic_vector(18 downto 0)  := (others => 'X'); -- address
			--vhdl_to_avalon_external_interface_byte_enable : in    std_logic_vector(15 downto 0)  := (others => 'X'); -- byte_enable
			--vhdl_to_avalon_external_interface_read        : in    std_logic                      := 'X';             -- read
			--vhdl_to_avalon_external_interface_write       : in    std_logic                      := 'X';             -- write
			--vhdl_to_avalon_external_interface_write_data  : in    std_logic_vector(127 downto 0) := (others => 'X'); -- write_data
			--vhdl_to_avalon_external_interface_acknowledge : out   std_logic;                                         -- acknowledge
			--vhdl_to_avalon_external_interface_read_data   : out   std_logic_vector(127 downto 0)  


ENTITY FFT_to_SRAM IS
	PORT(
		CLK, CRTL_RECV: IN STD_LOGIC;
		STRL_SND : OUT STD_LOGIC;
		DATA : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		
		avalon_address : OUT std_logic_vector(18 downto 0);
		avalon_byte_enable : OUT std_logic_vector(15 downto 0);
		avalon_read : OUT STD_LOGIC;
		avalon_write : OUT STD_LOGIC;
		avalon_write_data : OUT std_logic_vector(127 DOWNTO 0);
		avalon_acknowledge : IN STD_LOGIC;
		avalon_read_data : OUT STD_LOGIC_vector(127 DOWNTO 0);
	);
END FFT_to_SRAM;
	
ARCHITECTURE FFT_to_SRAM OF FFT_to_SRAM IS
BEGIN
	PROCESS(CLK,CRTL_RECV,DATA,avalon_acknowledge) 
	VARIABLE CTRTL_RECV_OLD : STD_LOGIC;
	BEGIN
		
	END PROCESS;
END ARCHITECTURE;