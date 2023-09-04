----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2017 13:55:58
-- Design Name: 
-- Module Name: Byte_Mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Byte_Mux is
    port ( Data : in STD_LOGIC_VECTOR (31 downto 0);
           Byte : out STD_LOGIC_VECTOR (7 downto 0);
           Sel : in STD_LOGIC_VECTOR (1 downto 0));
end Byte_Mux;

architecture Behavioral of Byte_Mux is

begin

    with Sel select
        Byte <=   Data(7 downto 0) when "11",
                  Data(15 downto 8) when "10",
                  Data(23 downto 16) when "01",
                  Data(31 downto 24) when "00",
                  "XXXXXXXX" when others;

end Behavioral;
