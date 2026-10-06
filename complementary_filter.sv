module complementary_filter(
    input  logic [15:0] accel_angle,
    input  logic [15:0] gyro_angle,
    output logic [15:0] estimated_angle
);

logic [31:0] temp;

always_comb
begin
    // Approximates 98% and 2% using a denominator of 64
    temp = (63 * gyro_angle) + accel_angle;
    estimated_angle = temp >> 6; // Bitwise shift right by 6 (equivalent to dividing by 64)
end

endmodule