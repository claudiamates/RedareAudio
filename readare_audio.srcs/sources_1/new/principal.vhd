----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2019 04:19:21 PM
-- Design Name: 
-- Module Name: principal - Behavioral
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

entity principal is
--  Port ( );
   port(CLK : in std_logic;
        BTN1,BTN2,BTN3,BTN4 : in std_logic;
        SW : in std_logic_vector(2 downto 0);
        micData : in std_logic;
        CAT : out std_logic_vector(7 downto 0);
        AN : out std_logic_vector(7 downto 0);
        LED : out std_logic_vector(15 downto 0);
        micLRSel : out std_logic;
        micCLK : out std_logic;
        ampSD : out std_logic;
        info_out : out std_logic);
end principal;

architecture Behavioral of principal is

signal B1,B2,B3,B4 : std_logic;
signal durata : time;
signal complet : std_logic;
signal stare_curenta : integer;
signal d_inreg_init : time;
signal t_scurs : time;
signal info_inreg : std_logic;
signal st_crt_led : time;

begin

B1D: entity WORK.debouncer port map(
   input => BTN1,
   clk => CLK,
   en => B1);

B2D: entity WORK.debouncer port map(
   input => BTN2,
   clk => CLK,
   en => B2);
   
B3D: entity WORK.debouncer port map(
      input => BTN3,
      clk => CLK,
      en => B3);
      
B4D: entity WORK.debouncer port map(
         input => BTN4,
         clk => CLK,
         en => B4);
         
MTIMP: entity WORK.mux_timp port map(
     t0 => 5 sec,
     t1 => 10 sec,
     t2 => 15 sec,
     t3 => 20 sec,
     sw0 => SW(0),
     sw1 => SW(1),
     Durata_inregistrare =>durata);
     
AutSt: entity WORK.automat_de_stare port map
    (Clk => CLK,
     BTN1 => B1,
     BTN2 => B2,
     BTN3 => B3,
     BTN4 => B4,
     complet => complet,
     Durata_inregistrare => durata,
     starea_curenta => stare_curenta,
     ampSD => ampSD,
     micLRSel => micLRSel,
     D_inreg_init => d_inreg_init);
     
INREG: entity WORK.circuit_de_inregistrare port map(
     Clk => CLK,
     starea_curenta =>stare_curenta,
     mod_func => SW(2),
     D_inreg_init => d_inreg_init,
     micData => micData,
     BTN2 => B2,
     BTN3 => B3,
     timp_scurs => t_scurs,
     info => info_inreg,
     complet => complet,
     micCLK => micCLK);
     
Redare: entity WORK.circuit_redare port map(
  Clk=>CLK,
  D_inreg_init => d_inreg_init,
  BTN3=>B3,
  BTN4=>B4,
  mod_func => SW(2),
  starea_curenta => stare_curenta,
  timp_scurs => t_scurs,
  info => info_inreg,
  info_out => info_out,
  led_out => LED);
  
TIMP: entity WORK.masurare_timp_scurs port map(
  Clk => CLK,
  starea_curenta => stare_curenta,
  BTN2 =>B2,
  BTN3 => B3,
  BTN4 => B4,
  timp_scurs => t_scurs);
  
sevenSD: entity WORK.SSD port map(
  Clk => CLK,
  Rst => '0',
  Data_timp => t_scurs,
  An => AN,
  Seg => CAT);
  
 process(stare_curenta)
 begin
  if(stare_curenta = 0) then st_crt_led <= 0 sec;
  elsif(stare_curenta = 1) then st_crt_led <= 1 sec;
  elsif(stare_curenta = 2) then st_crt_led <= 2 sec;
  elsif(stare_curenta = 3) then st_crt_led <= 3 sec;
  else st_crt_led <= 4 sec;
  end if;
  end process;
     
end Behavioral;
