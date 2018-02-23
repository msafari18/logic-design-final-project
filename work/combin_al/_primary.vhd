library verilog;
use verilog.vl_types.all;
entity combin_al is
    port(
        al              : out    vl_logic;
        r               : in     vl_logic;
        ap              : in     vl_logic;
        bp              : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic
    );
end combin_al;
