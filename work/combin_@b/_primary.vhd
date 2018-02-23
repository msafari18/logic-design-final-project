library verilog;
use verilog.vl_types.all;
entity combin_B is
    port(
        r               : in     vl_logic;
        ap              : in     vl_logic;
        bp              : in     vl_logic;
        bt              : in     vl_logic;
        a               : in     vl_logic;
        at              : in     vl_logic;
        b               : out    vl_logic
    );
end combin_B;
