library verilog;
use verilog.vl_types.all;
entity clockDivider is
    generic(
        divValue        : integer := 0
    );
    port(
        clockIn         : in     vl_logic;
        clockOut        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of divValue : constant is 1;
end clockDivider;
