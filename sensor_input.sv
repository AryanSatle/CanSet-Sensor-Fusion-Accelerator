module sensor_input(
    input  logic [15:0] accel_x,
    input  logic [15:0] accel_y,
    input  logic [15:0] accel_z,
    input  logic [15:0] gyro_x,
    input  logic [15:0] gyro_y,
    input  logic [15:0] gyro_z,

    output logic [15:0] accel_x_out,
    output logic [15:0] accel_y_out,
    output logic [15:0] accel_z_out,
    output logic [15:0] gyro_x_out,
    output logic [15:0] gyro_y_out,
    output logic [15:0] gyro_z_out
);

assign accel_x_out = accel_x;
assign accel_y_out = accel_y;
assign accel_z_out = accel_z;

assign gyro_x_out = gyro_x;
assign gyro_y_out = gyro_y;
assign gyro_z_out = gyro_z;

endmodule