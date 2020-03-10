----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2019 09:44:51 AM
-- Design Name: 
-- Module Name: circuit_de_inregistrare - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity circuit_de_inregistrare is
    Port ( Clk : in std_logic;
           starea_curenta : in integer;
           mod_func : in std_logic;
           D_inreg_init : in time;
           micData : in STD_LOGIC;
           BTN2 : in STD_LOGIC;
           BTN3 : in STD_LOGIC;
           timp_scurs : in time;
           info : out STD_LOGIC;
           complet : out STD_LOGIC;
           micCLK : out STD_LOGIC);
end circuit_de_inregistrare;

architecture Behavioral of circuit_de_inregistrare is

function clogb2( depth : natural) return integer is
variable temp    : integer := depth;
variable ret_val : integer := 0;
begin
    while temp > 1 loop
        ret_val := ret_val + 1;
        temp    := temp / 2;
    end loop;
    return ret_val;
end function;

constant C_RAM_WIDTH : integer := 1024;            		-- Specify RAM data width
constant C_RAM_DEPTH : integer := 1024;
type ramType is array(C_RAM_DEPTH - 1 downto 0) of std_logic_vector(C_RAM_WIDTH - 1 downto 0);
signal memRAM: ramType;

signal adr_linie: std_logic_vector((clogb2(C_RAM_DEPTH) - 1) downto 0) := (others => '1');
signal adr_coloana: std_logic_vector((clogb2(C_RAM_WIDTH) - 1) downto 0) := (others => '1');
signal cnt: std_logic_vector(4 downto 0) := "00000";

signal cntRead: integer := 0;

begin

process(Clk, BTN2, BTN3, starea_curenta)
  begin
  
   if(BTN2 = '1' and starea_curenta = 1) then
      complet <= '0';
      adr_linie <= (others => '1');
      adr_coloana <= (others => '1');
      
   elsif(starea_curenta = 4 and BTN3 = '1') then
       adr_linie <= (others => '1');
       adr_coloana <= (others => '1');
       
       
   elsif (starea_curenta = 2) then
       complet <= '1';
       
   elsif(rising_edge(Clk)) then
     if(cnt = "01111") then --face urat, foarte urat => musai schimbat
     
        if(mod_func = '1') then
          info <= micData;
        elsif(starea_curenta = 1 or starea_curenta =4) then
            if starea_curenta = 4 then
                 info <= memRAM(to_integer(unsigned(adr_linie)))(to_integer(unsigned(adr_coloana)));
            else
                memRAM(to_integer(unsigned(adr_linie)))(to_integer(unsigned(adr_coloana))) <= micData;
            end if;
        
            adr_coloana <= std_logic_vector(unsigned(adr_coloana) - 1);
            if adr_coloana <= "0000000000" then
                adr_linie <= std_logic_vector(unsigned(adr_linie) - 1);
                adr_coloana <= (others => '1');
            end if;
         end if;
              
        if(timp_scurs = D_inreg_init) then
            complet <= '1';
        else
            complet <= '0';
        end if;
       
     end if;
    end if;
end process;

process(Clk)
 begin
  if(rising_edge(Clk)) then
    cnt <= std_logic_vector(unsigned(cnt) + 1);
    cntRead <= cntRead + 1;
    if cntRead = 1250 then
        cntRead <= 0;
    end if;
  end if;
end process;

micCLK <= cnt(4);

end Behavioral;

