----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2019 03:28:39 PM
-- Design Name: 
-- Module Name: masurare_timp_scurs - Behavioral
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
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity masurare_timp_scurs is
    Port ( Clk : in STD_LOGIC;
           starea_curenta : in INTEGER;
           BTN2 : in STD_LOGIC;
           BTN3 : in STD_LOGIC;
           BTN4 : in STD_LOGIC;
           timp_scurs : out time);
end masurare_timp_scurs;

architecture Behavioral of masurare_timp_scurs is
signal cnt : std_logic_vector(26 downto 0) := (others => '0');
signal en : std_logic :='0';
signal t : time := 0 sec;
begin

process(Clk)
 begin
 if(BTN3 = '1' or BTN4 = '1' or BTN2 = '1') then
 t <= 0 sec;
 elsif(rising_edge(Clk)) then
   if(en = '1') then 
    cnt <= cnt+1;
    if(cnt = 99999999) then 
      cnt <= (others => '0');
      t <= t + 1 sec;
     end if;
  end if;
  end if;
 end process;
 
 en <= '1' when (starea_curenta = 1) or 
       (starea_curenta = 4)
        else '0';
  
timp_scurs <= t;
end Behavioral;

  