----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2019 09:16:32 AM
-- Design Name: 
-- Module Name: automat_de_stare - Behavioral
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

--------------------------------------------------------------------------------------
-- Cu ajutorul unui process dependent de clock se face tranzi?ia dintr-o stare în alta be baza condi?iilor prezentate în 
--organigrama de mai sus, deasemenea se va face asignarea valorii semnalului D_inreg_init, care trebuie s? conserve valoarea 
--ini?ial?(dat? la începutul înregistr?rii/red?rii) a semnalului Durata_inregistrare, în cadrul st?rii START. În urma acestor tranzi?ii, 
--în cadrul altui process se va determina valoarea semnalului starea_curenta. Valoarea celorlalte semnale de ie?ire se determina în 
--mod asincron într-un proces separate de cele anterioare.
 -------------------------------------------------------------------------------------

entity automat_de_stare is
    Port ( Clk : in std_logic;
           BTN1 : in STD_LOGIC;
           BTN2 : in STD_LOGIC;
           BTN3 : in STD_LOGIC;
           BTN4 : in STD_LOGIC;
           complet: in std_logic;
           Durata_inregistrare : in time;
           starea_curenta : out integer;
           ampSD : out STD_LOGIC;
           micLRSel : out STD_LOGIC;
           D_inreg_init : out time);
end automat_de_stare;

architecture Behavioral of automat_de_stare is
type state_type is (start, inregistrare, intrerupere, inregistrare_completa, redare);
signal state: state_type:=start;

begin

process(CLk)
  begin
    if(rising_edge(Clk)) then
    case state is
       when start => if(BTN1 ='1') then 
                           state <= inregistrare;
                           D_inreg_init <= Durata_inregistrare;
                           end if;
       when inregistrare => if(BTN2 = '1') then
                                state <= start;
                            elsif (BTN1 = '1') then
                                 state <= intrerupere;
                            elsif(complet = '1') then
                                 state <= inregistrare_completa;
                                 end if;
       when intrerupere => state <= inregistrare_completa;
       when inregistrare_completa => if(BTN3 = '1') then
                                         state <= redare;
                                       end if;
       when redare => if(BTN4 = '1') then
                           state <= start;
                       elsif(BTN3 = '1') then
                           state <= redare;
                       end if;
       end case;
       end if;
 end process;
 
 process(state)
  begin
    case state is
       when start => starea_curenta <= 0;
       when inregistrare => starea_curenta <= 1;
       when intrerupere => starea_curenta <= 2;
       when inregistrare_completa => starea_curenta <= 3;
       when redare => starea_curenta <=  4;
     end case;
 end process;
       
-- process(state, Durata_inregistrare)
  --begin
   -- if(state = start) then
     --  ampSD <= '0';
       --micLRSel <= '1';
    --elsif(state = inregistrare) then
      -- micLRSel <= '0';
      -- ampSD <= '0';
    --elsif(state = redare) then
      -- micLRSel <= '1';
       --ampSD <= '1';
    --else
      --  micLRSel <= '1';
        --ampSD <= '0';
       --end if;
   --end process;
   micLRSel <= '0';
   ampSD <= '1';

end Behavioral;

