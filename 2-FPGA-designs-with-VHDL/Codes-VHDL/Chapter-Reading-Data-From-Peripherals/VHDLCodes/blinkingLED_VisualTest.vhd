-- blinkingLED_VisualTest.vhd

library ieee;
use ieee.std_logic_1164.all;

entity blinkingLED_VisualTest is
port(
    CLOCK_50, reset : in std_logic;
    SW : in std_logic_vector(7 downto 0);
    LEDG : out std_logic_vector(1 downto 0)
);
end blinkingLED_VisualTest;

architecture arch of blinkingLED_VisualTest is
component nios_blinkingLED is
  port (
    clk_clk                           : in std_logic; -- clk
    reset_reset_n                     : in std_logic; -- reset_n
    -- switch;
    switch_external_connection_export : in std_logic_vector(7 downto 0) := (others => 'X');
    led_external_connection_export    : out std_logic_vector(1 downto 0) -- LED
  );
end component nios_blinkingLED;
begin

    u0 : component nios_blinkingLED
        port map (
        clk_clk                             => CLOCK_50, -- clk.clk
        reset_reset_n                       => reset, -- reset.reset_n
        switch_external_connection_export   => SW, -- led_external_connection.export
        led_external_connection_export      => LEDG  -- led_external_connection.export
      );
end arch;    