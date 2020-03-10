----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2019 03:16:19 AM
-- Design Name: 
-- Module Name: masurare_timp_tb - Behavioral
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

entity masurare_timp_tb is
--  Port ( );
end masurare_timp_tb;

architecture Behavioral of masurare_timp_tb is
signal Clk: std_logic;
signal s_crt: integer := 0;
signal BTN2,BTN3,BTN4: std_logic := '0';
signal t_scurs : time;

begin
  DUT: entity WORK.masurare_timp_scurs port map(
             Clk => Clk,
             starea_curenta => s_crt,
             BTN2 => BTN2,
             BTN3 => BTN3,
             BTN4 => BTN4,
             timp_scurs => t_scurs);
             
 process
   variable tVect : std_logic_vector(2 downto 0);
   variable s_c : integer;
   
   begin
     Clk <= not Clk after 5 ns;
     tVect := "000";
     s_c := 0;
     
     for i in 0 to 7 loop
       BTN2 <= tVect(2);
       BTN3 <= tVect(1);
       BTN4 <= tVect(0);
       
       s_crt <= s_c;
       
       wait for 10 ns;
       
       tVect := tVect +1;
       s_c := s_c +1;
     end loop;
     wait;
   end process;
       

end Behavioral;
