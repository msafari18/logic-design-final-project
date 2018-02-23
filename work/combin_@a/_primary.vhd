library verilog;
use verilog.vl_types.all;
entity combin_A is
    port(
        r               : in     vl_logic;
        ap              : in     vl_logic;
        bp              : in     vl_logic;
        bt              : in     vl_logic;
        b               : in     vl_logic;
        at              : in     vl_logic;
        a               : out    vl_logic
    );
end combin_A;
