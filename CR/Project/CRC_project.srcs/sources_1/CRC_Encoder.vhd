------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 16.06.2021 11:45:31
---- Design Name: 
---- Module Name: CRC_Encoder - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CRC_Encoder is 
port( Clk: in std_logic; 
        reset : in std_logic; --active high reset
        size_data : in unsigned(31 downto 0);  --the size of input stream in bits.
        Data_in : in std_logic; --serial input
        crc_out : out unsigned(15 downto 0); --16 bit crc checksum
        crc_ready : out std_logic --high when the calculation is done.
        ); 
end CRC_Encoder; 

architecture Behavioral of CRC_Encoder is 

signal count : unsigned(31 downto 0) := (others => '0');
signal crc_temp : unsigned(15 downto 0) := (others => '0');

begin

process(Clk,reset)
begin
    if(reset = '1') then
        crc_temp <= (others => '0');
        count <= (others => '0');
        crc_ready <= '0';
    elsif(rising_edge(Clk)) then
    --crc calculation
        crc_temp(0) <= Data_in xor crc_temp(15);
        crc_temp(1) <= crc_temp(0);
        crc_temp(2) <= crc_temp(1) xor crc_temp(15);
        crc_temp(14 downto 3) <= crc_temp(13 downto 2);
        crc_temp(15) <= crc_temp(14) xor crc_temp(15);
        
        count <= count + 1; --keeps track of the number of cycles
        if(count = size_data + 15) then --check when to finish the calculations
            count <= (others => '0');
            crc_ready <= '1';
        end if; 
    end if; 
end process;    

crc_out <= not crc_temp;

end Behavioral;
