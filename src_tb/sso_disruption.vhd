-------------------------------------------------------------------------------
-- This is free and unencumbered software released into the public domain.
--
-- Anyone is free to copy, modify, publish, use, compile, sell, or distribute
-- this software, either in source code form or as a compiled bitstream, for 
-- any purpose, commercial or non-commercial, and by any means.
--
-- In jurisdictions that recognize copyright laws, the author or authors of 
-- this software dedicate any and all copyright interest in the software to 
-- the public domain. We make this dedication for the benefit of the public at
-- large and to the detriment of our heirs and successors. We intend this 
-- dedication to be an overt act of relinquishment in perpetuity of all present
-- and future rights to this software under copyright law.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN 
-- ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-- WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- THIS DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES. 
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sso_disruption is
  generic (
    LAT_WIDTH : integer := 8);
  port(
    clk     : in  std_logic;
    rst     : in  std_logic;
    lat     : in  std_logic_vector(LAT_WIDTH-1 downto 0);
    sso_cmd : in  std_logic;
    ssop_i  : in  std_logic;
    sson_i  : in  std_logic;
    ssop_o  : out std_logic;
    sson_o  : out std_logic
    );
end sso_disruption;

architecture rtl of sso_disruption is
  --
  signal ssop_d         : std_logic := '0';
  signal sson_d         : std_logic := '0';
  signal ssop_t         : std_logic := '0';
  signal sson_t         : std_logic := '0';
  signal sso_cmd_d      : std_logic := '0';
  signal sso_lock_value : std_logic := '0';
--
begin
  --

  delay_mux_1 : entity work.delay_mux
    generic map (
      LAT_WIDTH => LAT_WIDTH)
    port map (
      clk => clk,
      rst => rst,
      lat => lat,
      d   => ssop_i,
      q   => ssop_d);

  delay_mux_2 : entity work.delay_mux
    generic map (
      LAT_WIDTH => LAT_WIDTH)
    port map (
      clk => clk,
      rst => rst,
      lat => lat,
      d   => sson_i,
      q   => sson_d);

  delay_mux_3 : entity work.delay_mux
    generic map (
      LAT_WIDTH => LAT_WIDTH)
    port map (
      clk => clk,
      rst => rst,
      lat => lat,
      d   => sso_cmd,
      q   => sso_cmd_d);

  sso_lock_value <= sso_cmd and not sso_cmd_d;

  process(clk)
  begin
    if rising_edge(clk) then
      if sso_lock_value = '1' then
        ssop_t <= ssop_t;
        sson_t <= sson_t;
      elsif sso_cmd = '0' then
        ssop_t <= ssop_i;
        sson_t <= sson_i;
      else
        ssop_t <= ssop_d;
        sson_t <= sson_d;
      end if;
    end if;
  end process;

  ssop_o <= ssop_t;
  sson_o <= sson_t;
  
end rtl;
