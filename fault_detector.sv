module fault_detector(

    input  logic [15:0] accel_angle,
    input  logic [15:0] gyro_angle,

    output logic fault_flag

);

always_comb
begin

    if(accel_angle > 1000)
        fault_flag = 1'b1;

    else if(gyro_angle > 1000)
        fault_flag = 1'b1;

    else
        fault_flag = 1'b0;

end

endmodule