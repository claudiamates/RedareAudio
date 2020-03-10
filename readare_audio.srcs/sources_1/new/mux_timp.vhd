----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2019 08:34:35 AM
-- Design Name: 
-- Module Name: mux_timp - Behavioral
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

entity mux_timp is
    Port ( t0 : in time;
           t1 : in time;
           t2 : in time;
           t3 : in time;
           sw0 : in STD_LOGIC;
           sw1 : in STD_LOGIC;
           Durata_inregistrare : out time);
end mux_timp;

architecture Behavioral of mux_timp is

begin

process(sw0, sw1,t0,t1,t2,t3)
 begin
  if ((sw0 = '0') and (sw1 = '0')) then
       Durata_inregistrare <= t0;
      end if;
  if ((sw0 = '1') and (sw1 = '0')) then
             Durata_inregistrare <= t1;
            end if;
  if ((sw0 = '0') and (sw1 = '1')) then
                   Durata_inregistrare <= t2;
                  end if;
  if ((sw0 = '1') and (sw1 = '1')) then
                         Durata_inregistrare <= t3;
                        end if;
end process;                        

end Behavioral;
