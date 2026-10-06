module packet_formatter(

    input  logic clk,
    input  logic rst,

    input  logic uart_ready,

    input  logic [7:0] roll_angle,
    input  logic [7:0] pitch_angle,
    input  logic [7:0] yaw_angle,

    input  logic fault_flag,

    output logic [7:0] packet_byte

);

logic [2:0] packet_index;

// Packet Index Controller

always_ff @(posedge clk or posedge rst)
begin

    if(rst)
        packet_index <= 0;

    else if(uart_ready)
    begin

        if(packet_index == 5)
            packet_index <= 0;
        else
            packet_index <= packet_index + 1;

    end

end

// Packet Formatter

always_comb
begin

    case(packet_index)

        3'd0: packet_byte = 8'hAA;

        3'd1: packet_byte = roll_angle;

        3'd2: packet_byte = pitch_angle;

        3'd3: packet_byte = yaw_angle;

        3'd4: packet_byte = {7'b0,fault_flag};

        3'd5: packet_byte = 8'h55;

        default:
              packet_byte = 8'h00;

    endcase

end

endmodule