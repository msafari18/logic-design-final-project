library verilog;
use verilog.vl_types.all;
entity E_comparator is
    port(
        A               : in     vl_logic_vector(6 downto 0);
        B0              : in     vl_logic;
        B1              : in     vl_logic;
        B2              : in     vl_logic;
        B3              : in     vl_logic;
        B4              : in     vl_logic;
        B5              : in     vl_logic;
        B6              : in     vl_logic;
        En              : in     vl_logic;
        Equal           : out    vl_logic
    );
end E_comparator;
