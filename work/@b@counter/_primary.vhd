library verilog;
use verilog.vl_types.all;
entity BCounter is
    port(
        result          : out    vl_logic_vector(6 downto 0);
        Re              : in     vl_logic;
        CLK             : in     vl_logic;
        en              : in     vl_logic
    );
end BCounter;
