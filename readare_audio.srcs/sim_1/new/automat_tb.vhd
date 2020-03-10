----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2019 03:13:02 AM
-- Design Name: 
-- Module Name: automat_tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity automat_tb is
--  Port ( );
end automat_tb;

architecture Behavioral of automat_tb is
signal Clk: std_logic;
signal BTN1,BTN2,BTN3,BTN4,complet: std_logic :='0';
signal ampSD, micLRSel: std_logic;
signal D_inreg : time := 5 sec;
signal D_init : time;
signal s_crt : integer;

begin
  DUT: entity WORK.automat_de_stare port map (
             Clk => Clk,
             BTN1 => BTN1,
             BTN2 => BTN2,
             BTN3 => BTN3,
             BTN4 => BTN4,
             complet => complet,
             Durata_inregistrare => D_inreg,
             starea_curenta => s_crt,
             ampSD => ampSD,
             micLRSel => micLRSel,
             D_inreg_init => D_init);
             
  gen_test: process
    variable VecTest : STD_LOGIC_VECTOR(4 downto 0); -- vector de test
    begin
       Clk <= not Clk after 5 ns; 
       VecTest := "00000";
       for i in 0 to 15 loop
          BTN1 <= VecTest(4);
          BTN2 <= VecTest(3);
          BTN3 <= VecTest(2);
          BTN4 <= VecTest(1);
          complet <= VecTest(0);
          VecTest := VecTest +1;  
        end loop;
        
        wait;
  end process gen_test;
    

end Behavioral;

