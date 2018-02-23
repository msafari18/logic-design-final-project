library verilog;
use verilog.vl_types.all;
entity traffic_light_control_system is
    port(
        CLK             : in     vl_logic;
        R               : in     vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        A_Traffic       : in     vl_logic;
        B_Traffic       : in     vl_logic;
        en              : in     vl_logic;
        A_Time_L        : out    vl_logic_vector(3 downto 0);
        A_Time_H        : out    vl_logic_vector(3 downto 0);
        B_Time_L        : out    vl_logic_vector(3 downto 0);
        B_Time_H        : out    vl_logic_vector(3 downto 0);
        A_Light         : out    vl_logic;
        B_Light         : out    vl_logic
    );
end traffic_light_control_system;
