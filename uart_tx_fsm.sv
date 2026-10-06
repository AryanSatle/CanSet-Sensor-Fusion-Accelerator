module uart_tx_fsm(

    input  logic clk,
    input  logic rst,

    input  logic baud_tick,
    input  logic send,

    input  logic [7:0] data_in,

    output logic tx,
    output logic busy

);

typedef enum logic [1:0] {

    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT

} state_t;

state_t state;

logic [7:0] shift_reg;
logic [2:0] bit_count;

always_ff @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        state     <= IDLE;
        tx        <= 1'b1;
        busy      <= 1'b0;
        bit_count <= 0;
    end

    else
    begin

        case(state)

            IDLE:
            begin
                tx   <= 1'b1;
                busy <= 1'b0;

                if(send)
                begin
                    shift_reg <= data_in;
                    state <= START_BIT;
                    busy  <= 1'b1;
                end
            end

            START_BIT:
            begin
                if(baud_tick)
                begin
                    tx <= 1'b0;
                    state <= DATA_BITS;
                    bit_count <= 0;
                end
            end

            DATA_BITS:
            begin
                if(baud_tick)
                begin
                    tx <= shift_reg[0];
                    shift_reg <= shift_reg >> 1;

                    if(bit_count == 7)
                        state <= STOP_BIT;

                    bit_count <= bit_count + 1;
                end
            end

            STOP_BIT:
            begin
                if(baud_tick)
                begin
                    tx <= 1'b1;
                    state <= IDLE;
                end
            end

        endcase

    end

end

endmodule