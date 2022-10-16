----------------------------------------------------------------------------------
-- Company : id3 Technologies - 2016
-- Engineer : Lionel ROMEAS
-- 
-- Module Name  : spi_slave - rtl 
-- Design Name  : 
-- Description  : 3-wire slave SPI controller.
--                      MSB first transfer. CPHA = 0 and CPOL = 0.
--
-- Revision             :
--      + REV 1: Creation
----------------------------------------------------------------------------------
library ieee;
use ieee.Std_Logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.math_real.all;

library UNISIM;
use UNISIM.VComponents.all;


entity spi_slave_with_regmap is
  generic (
    SPI_ADDR_WIDTH : natural := 16;
    SPI_DATA_WIDTH : natural := 16
    );
  port (
    rst  : in  std_logic;
    clk  : in  std_logic;
    sclk : in  std_logic;   -- serial data clock
    csn  : in  std_logic;   -- slave select
    mosi : in  std_logic;   -- MOSI serial data
    miso : out std_logic);  -- MISO serial data
end spi_slave_with_regmap;

architecture rtl of spi_slave_with_regmap is
  --
  type t_state is (st_idle, st_getaddr, st_switch2data, st_getsetdata, st_done);

  signal state       : t_state                                      := st_idle;
  signal csn_t       : std_logic;
  signal sdi_t       : std_logic;
  signal sdo_t       : std_logic;
  signal Add_vect    : std_logic_vector (SPI_ADDR_WIDTH-1 downto 0) := (0 => '1', others => '0');
  signal Add_int     : std_logic_vector (SPI_ADDR_WIDTH-1 downto 0) := (0 => '1', others => '0');
  signal Data_vect   : std_logic_vector (SPI_DATA_WIDTH-1 downto 0) := (0 => '1', others => '0');
  signal Data_int    : std_logic_vector (SPI_DATA_WIDTH-1 downto 0) := (0 => '1', others => '0');
  signal data_out    : std_logic_vector (SPI_DATA_WIDTH-1 downto 0) := (0 => '1', others => '0');
  signal sclk_re     : std_logic;
  signal sclk_fe     : std_logic;
  signal sclk_d      : std_logic                                    := '0';
  signal Csn_s       : std_logic;
  signal MOSI_R      : std_logic;
  signal valid_add   : std_logic;
  signal reg_add     : std_logic_vector (SPI_ADDR_WIDTH - 1 downto 0);
  signal valid_data  : std_logic;
  signal reg_data_wr : std_logic_vector (SPI_DATA_WIDTH - 1 downto 0);
  signal reg_data_rd : std_logic_vector (SPI_DATA_WIDTH - 1 downto 0);
  signal sm_rst      : std_logic;

  signal reg_addr  : std_logic_vector(SPI_ADDR_WIDTH-1 downto 0) := (others => '0');
  signal reg_wen   : std_logic                                   := '0';
  signal reg_wdata : std_logic_vector(SPI_DATA_WIDTH-1 downto 0) := (others => '0');
  signal reg_ren   : std_logic                                   := '0';
  signal reg_rdata : std_logic_vector(SPI_DATA_WIDTH-1 downto 0) := (others => '0');

begin

  miso <= data_out(SPI_DATA_WIDTH-1);
  sclk_re <= '1' when sclk = '1' and sclk_d = '0' else '0'; 
  sclk_fe <= '1' when sclk = '0' and sclk_d = '1' else '0';
  sm_rst  <= rst or csn;

  ctrl_p : process (sm_rst, clk)
  begin
    if Rising_edge(clk) then
      if sm_rst = '1' then
        Csn_s   <= '1';
        MOSI_R  <= '0';
        sclk_d <= '0';
      else
        Csn_s  <= Csn;
        MOSI_R <= MOSI;
        sclk_d <= sclk;
      end if;
    end if;
  end process;


  fsm_p : process(clk)
  begin
    if Rising_edge(clk) then
      if sm_rst = '1' then
        state       <= st_idle;
        Add_vect    <= (0      => '1', others => '0');
        Data_vect   <= (0      => '1', others => '0');
        valid_data  <= '0';
        valid_add   <= '0';
        reg_add     <= (others => '0');
        reg_data_wr <= (others => '0');
        data_out    <= (others => '0');
      else
        case state is
          when st_idle =>
            valid_data <= '0';
            valid_add  <= '0';
            if sclk_re = '1' then
              Add_vect <= Add_vect(SPI_ADDR_WIDTH-2 downto 0) & Add_vect(SPI_ADDR_WIDTH-1);
              Add_int  <= Add_int(SPI_ADDR_WIDTH-2 downto 0) & MOSI_R;
              state    <= st_getaddr;
            else
              Add_vect <= (0 => '1', others => '0');
            end if;

          when st_getaddr =>
            valid_data <= '0';
            valid_add  <= '0';
            if sclk_re = '1' then
              Add_vect <= Add_vect(SPI_ADDR_WIDTH-2 downto 0) & Add_vect(SPI_ADDR_WIDTH-1);
              Add_int  <= Add_int(SPI_ADDR_WIDTH-2 downto 0) & MOSI_R;
              if Add_Vect(SPI_ADDR_WIDTH-1) = '1' then
                state <= st_switch2data;
              end if;
            end if;

          when st_switch2data =>
            valid_data <= '0';
            valid_add  <= '1';
            reg_add    <= Add_int;
            Add_vect   <= (0 => '1', others => '0');
            if sclk_fe = '1' then
              --Data_vect  <= Data_vect(SPI_ADDR_WIDTH-2 downto 0) & Data_vect(SPI_ADDR_WIDTH-1);
              --Data_int   <= Data_int(SPI_ADDR_WIDTH-2 downto 0) & MOSI_R;
              state      <= st_getsetdata;
              data_out   <= data_out; --data_out(SPI_DATA_WIDTH-2 downto 0) & '0';
            else
              Data_vect  <= (0 => '1', others => '0');
              data_out   <= reg_data_rd;
            end if;


          when st_getsetdata =>
            valid_data <= '0';
            valid_add  <= '1';
            if (sclk_re = '1' and reg_add(SPI_ADDR_WIDTH-1) = '1') or  (sclk_fe = '1' and reg_add(SPI_ADDR_WIDTH-1) = '0') then
              Data_vect  <= Data_vect(SPI_ADDR_WIDTH-2 downto 0) & Data_vect(SPI_ADDR_WIDTH-1);
              Data_int   <= Data_int(SPI_ADDR_WIDTH-2 downto 0) & MOSI_R;
              data_out   <= data_out(SPI_DATA_WIDTH-2 downto 0) & '0';
              if Data_vect(SPI_ADDR_WIDTH-1) = '1' then
                state <= st_done;
              end if;
            end if;

          -- st_done
          when others =>
            valid_data  <= '1';
            valid_add   <= '1';
            reg_data_wr <= Data_int;
            Data_vect   <= (0 => '1', others => '0');
            state <= st_idle;
        end case;
      end if;
    end if;
  end process;

  reg_addr    <= reg_add;
  reg_ren     <= valid_add and (not reg_addr(SPI_ADDR_WIDTH-1));
  reg_data_rd <= reg_rdata;
  --
  reg_wdata   <= reg_data_wr;
  reg_wen     <= valid_data and (not reg_ren);

  spi_slave_regmap_1 : entity work.spi_slave_regmap
    generic map (
      ADDR_WIDTH => SPI_ADDR_WIDTH,
      DATA_WIDTH => SPI_DATA_WIDTH)
    port map (
      clk       => clk,
      rst       => rst,
      reg_addr  => reg_addr,
      reg_wen   => reg_wen,
      reg_wdata => reg_wdata,
      reg_ren   => reg_ren,
      reg_rdata => reg_rdata);
end architecture rtl;
