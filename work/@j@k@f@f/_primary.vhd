library verilog;
use verilog.vl_types.all;
entity JKFF is
    port(
        Q               : out    vl_logic;
        J               : in     vl_logic;
        K               : in     vl_logic;
        CLK             : in     vl_logic;
        RST             : in     vl_logic
    );
end JKFF;
