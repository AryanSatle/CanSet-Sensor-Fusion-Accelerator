module telemetry_uart_top(

    input  logic clk,
    input  logic rst,

    input  logic [7:0] roll_angle,
    input  logic [7:0] pitch_angle,
    input  logic [7:0] yaw_angle,

    input  logic fault_flag,

    output logic tx

);

logic [2:0] packet_index;
logic [7:0] packet_byte;

logic send;
logic busy;
logic baud_tick;

// Baud Generator

baud_generator baud_gen(

    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick)

);

// Packet Index Counter

always_ff @(posedge clk or posedge rst)
begin

    if(rst)
        packet_index <= 0;

    else if(!busy)
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
        3'd4: packet_byte = {7'b0, fault_flag};
        3'd5: packet_byte = 8'h55;

        default: packet_byte = 8'h00;

    endcase

end

// Send whenever UART is idle

assign send = ~busy;

// UART Transmitter

uart_tx_fsm uart(

    .clk(clk),
    .rst(rst),

    .baud_tick(baud_tick),

    .send(send),

    .data_in(packet_byte),

    .tx(tx),

    .busy(busy)

);

endmodule