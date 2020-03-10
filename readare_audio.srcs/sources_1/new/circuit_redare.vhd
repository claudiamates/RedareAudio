----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2019 09:07:56 AM
-- Design Name: 
-- Module Name: circuit_redare - Behavioral
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
--------------------------------------------------------------------------------------
 --Pentru realizarea acestui circuit se preia semnalul info care este informa?ia audio din memorie, stocat?, deja în format PWM. 
 --În aceast? faz? el va fi redat direct f?r? modific?ri suplimentare ale semnalului. Redarea se va întâm?la doar dac? utilizatorul nu 
 --dore?te s? treac? în alt? stare solicitând acest lucru prin ap?sarea unuia din cele dou? butoane men?ionate anterior. Vom folosi un  
 --semnal intern play,activ pe 1, pentru a ?tii dac? informa?ia este redat? sau nu. Redarea este oprit? automat, indiferent de ap?sarea 
 --butoanelor, dup? scurgerea timpului de redare prin setarea semnalului play pe 0.
 -------------------------------------------------------------------------------------

entity circuit_redare is
    Port ( Clk : in STD_LOGIC;
           D_inreg_init : in time;
           BTN3 : in STD_LOGIC;
           BTN4 : in STD_LOGIC;
           mod_func : in std_logic;
           starea_curenta : in integer;
           timp_scurs : in time;
           info : in STD_LOGIC;
           info_out : out STD_LOGIC;
           led_out : out STD_LOGIC_VECTOR (15 downto 0));
end circuit_redare;

architecture Behavioral of circuit_redare is
signal regDeplasare : std_logic_vector(15 downto 0);
signal play : std_logic := '1';
signal cnt : std_logic_vector(4 downto 0) := "00000";
begin

led_out <= regDeplasare;
process(Clk, BTN3, BTN4)
  begin
   if(starea_curenta = 4 and BTN4 = '1') then
       play <='0';
     regDeplasare <= "0000000000000000";
   elsif((starea_curenta = 3 and BTN3 = '1') or (starea_curenta =4 and BTN3 = '1')) then play <= '1';
   elsif(rising_edge(Clk)) then
   if(cnt = "01111") then
     if(play ='1'or mod_func = '1') then --dintr-un oarecare motiv se reda doar daca asta nu e aici
        info_out <= info;
        regDeplasare <= info & regDeplasare(15 downto 1);
        if(timp_scurs = D_inreg_init) then play <= '0';
        end if;
       end if;
    end if;
    end if;
   -- end if;
    
end process;

process(Clk)
 begin
  if(rising_edge(Clk)) then
    cnt <= cnt+1;
  end if;
end process;

end Behavioral;
