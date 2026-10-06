module cansat_sensor_fusion_top(

    input  logic clk,

    input  logic [15:0] accel_x,
    input  logic [15:0] accel_y,
    input  logic [15:0] accel_z,

    input  logic [15:0] gyro_x,
    input  logic [15:0] gyro_y,
    input  logic [15:0] gyro_z,

    output logic [15:0] roll_angle,
    output logic [15:0] pitch_angle,
    output logic [15:0] yaw_angle,

    output logic fault_x,
    output logic fault_y,
    output logic fault_z,

    output logic system_fault

);

logic [15:0] filt_ax;
logic [15:0] filt_ay;
logic [15:0] filt_az;

// X Axis
moving_average_filter maf_x(
    .clk(clk),
    .accel_in(accel_x),
    .accel_filtered(filt_ax)
);

complementary_filter cf_x(
    .accel_angle(filt_ax),
    .gyro_angle(gyro_x),
    .estimated_angle(roll_angle)
);

fault_detector fd_x(
    .accel_angle(filt_ax),
    .gyro_angle(gyro_x),
    .fault_flag(fault_x)
);

// Y Axis
moving_average_filter maf_y(
    .clk(clk),
    .accel_in(accel_y),
    .accel_filtered(filt_ay)
);

complementary_filter cf_y(
    .accel_angle(filt_ay),
    .gyro_angle(gyro_y),
    .estimated_angle(pitch_angle)
);

fault_detector fd_y(
    .accel_angle(filt_ay),
    .gyro_angle(gyro_y),
    .fault_flag(fault_y)
);

// Z Axis
moving_average_filter maf_z(
    .clk(clk),
    .accel_in(accel_z),
    .accel_filtered(filt_az)
);

complementary_filter cf_z(
    .accel_angle(filt_az),
    .gyro_angle(gyro_z),
    .estimated_angle(yaw_angle)
);

fault_detector fd_z(
    .accel_angle(filt_az),
    .gyro_angle(gyro_z),
    .fault_flag(fault_z)
);

assign system_fault =
       fault_x |
       fault_y |
       fault_z;

endmodule