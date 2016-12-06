LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;


ENTITY IM IS
   PORT(
      ReadAddress : IN     std_logic_vector (31 DOWNTO 0);
      rst         : IN     std_logic;
      Instruction : OUT    std_logic_vector (31 DOWNTO 0)
   );
END IM ;


ARCHITECTURE struct_4byte_wide OF IM IS

   -- Architecture declarations
   constant program_size : natural := 4; -- Number of instructions

   constant text_segment_start : std_logic_vector(31 downto 0) := x"00400000";

   type im_mem_type is array(0 to program_size-1) of std_logic_vector(31 downto 0);
   constant nop : std_logic_vector(31 downto 0) := (others => '0');
   -- Internal signal declarations
   SIGNAL im_mem : im_mem_type;

   constant program : im_mem_type :=
      -- Insert your program binaries (machine code) here -----------
      (
      "00100000000001000000000000101010",
      "10101111101001000000000000000100",
      "10001111101000100000000000000100",
      "00001000000100000000000000000011"
      );
      ---------------------------------------------------------------

BEGIN

-- Insert your code here --
process1 : PROCESS (ReadAddress, rst)
---------------------------------------------------------------------------
BEGIN
   IF (rst /= '0') THEN
      im_mem <= program;
      Instruction <= nop;
   ELSE
      Instruction <= im_mem( CONV_INTEGER(ReadAddress - text_segment_start)/4 );
   END IF;
END PROCESS process1;
---------------------------

END struct_4byte_wide;
