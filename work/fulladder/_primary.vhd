library verilog;
use verilog.vl_types.all;
entity fulladder is
    port(
        S               : out    vl_logic;
        C               : out    vl_logic;
        x               : in     vl_logic;
        y               : in     vl_logic;
        z               : in     vl_logic
    );
end fulladder;
