library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        D               : out    vl_logic_vector(0 to 3)
    );
end decoder;
