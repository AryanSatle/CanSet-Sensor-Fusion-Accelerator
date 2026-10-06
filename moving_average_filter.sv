module moving_average_filter(
    input  logic        clk,
    input  logic [15:0] accel_in,
    output logic [15:0] accel_filtered
);

logic [15:0] sample1;
logic [15:0] sample2;
logic [15:0] sample3;
logic [15:0] sample4;

logic [17:0] sum;

always_ff @(posedge clk)
begin
    sample4 <= sample3;
    sample3 <= sample2;
    sample2 <= sample1;
    sample1 <= accel_in;
end

always_comb
begin
    sum = sample1 + sample2 + sample3 + sample4;
    accel_filtered = sum >> 2; 
end

endmodule
