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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_slave_regmap is
  generic (
    ADDR_WIDTH : natural := 16;
    DATA_WIDTH : natural := 16
    );
  port (
    clk       : in  std_logic;
    rst       : in  std_logic;
    reg_addr  : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    reg_wen   : in  std_logic;
    reg_wdata : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    reg_ren   : in  std_logic;
    reg_rdata : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end spi_slave_regmap;

architecture rtl of spi_slave_regmap is
  --signal reg_addr          : std_logic_vector(15 downto 0) := (others => '0');
  --signal reg_rdata         : std_logic_vector(15 downto 0) := (others => '0');
  --signal reg_wdata         : std_logic_vector(15 downto 0) := (others => '0');
  --signal reg_wen           : std_logic                     := '0';
  --signal reg_ren           : std_logic                     := '0';
  --
  constant reg_0000_addr : std_logic_vector(ADDR_WIDTH-1 downto 0) := x"0000";
  constant reg_0001_addr : std_logic_vector(ADDR_WIDTH-1 downto 0) := x"0001";
  constant reg_0011_addr : std_logic_vector(ADDR_WIDTH-1 downto 0) := x"0011";
  constant reg_0B1B_addr : std_logic_vector(ADDR_WIDTH-1 downto 0) := x"0B1B";
  --
  signal reg_0000_m      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
  -- OTP loading register: addr 0x0001
  signal reg_0001_m      : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
  signal reg_0001_os     : std_logic                               := '0';
  -- Chip ID register: addr 0x0011
  signal reg_0011_m      : std_logic_vector(DATA_WIDTH-1 downto 0) := x"0914";
  -- ADX4 license register: addr 0x0B1B 
  -- -- bits 10 downto 3: license number 0x65
  -- -- bit 2: license enable 0x1
  -- -- bit 1 downto 0: info tester 0x3
  signal reg_0B1B_m      : std_logic_vector(DATA_WIDTH-1 downto 0) := x"032F";

--
begin

  wr_p : process (clk)
  begin  -- process
    if rising_edge(clk) then
      if rst = '1' then
        reg_0000_m  <= (others => '0');
        reg_0001_m  <= (others => '0');
        reg_0001_os <= '0';
        reg_0011_m  <= x"8915";
        reg_0B1B_m  <= x"032F";
      elsif reg_addr(ADDR_WIDTH-1) = '1' and reg_wen = '1' then  -- write operation
        case ('0' & reg_addr(ADDR_WIDTH-2 downto 0)) is
          when reg_0000_addr => reg_0000_m <= reg_wdata;
          when reg_0001_addr => reg_0001_m <= reg_wdata;
          when reg_0011_addr => reg_0011_m <= reg_wdata;
          when reg_0B1B_addr => reg_0B1B_m <= reg_wdata;
          when others        => null;
        end case;
      else
        reg_0001_os <= '0';
      end if;
    end if;
  end process;
  --
  rd_p : process (clk)
  begin  -- process
    if rising_edge(clk) then
      if reg_addr(ADDR_WIDTH-1) = '0' and reg_ren = '1' then     -- read operation
        case ('0' & reg_addr(ADDR_WIDTH-2 downto 0)) is
          when reg_0000_addr => reg_rdata <= reg_0000_m;
          when reg_0001_addr => reg_rdata <= reg_0001_m;
          when reg_0011_addr => reg_rdata <= reg_0011_m;
          when reg_0B1B_addr => reg_rdata <= reg_0B1B_m;
          when others        => reg_rdata <= x"DEAD";
        end case;
      else
        reg_rdata <= x"0000";
      end if;
    end if;
  end process;


-------------------------------------------------------------------------------
-- Template:
-------------------------------------------------------------------------------
-- process(clk)
-- begin
--   if rising_edge(clk) then
--  
--   end if;
-- end process;
-------------------------------------------------------------------------------

end rtl;
