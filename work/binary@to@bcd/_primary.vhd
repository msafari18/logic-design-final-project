library verilog;
use verilog.vl_types.all;
entity binaryToBcd is
    port(
        binary          : in     vl_logic_vector(7 downto 0);
        ten             : out    vl_logic_vector(3 downto 0);
        one             : out    vl_logic_vector(3 downto 0);
        clk             : in     vl_logic
    );
end binaryToBcd;
