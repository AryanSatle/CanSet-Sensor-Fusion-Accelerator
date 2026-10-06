module baud_generator #(

    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 9600

)(

    input  logic clk,
    input  logic rst,

    output logic baud_tick

);

localparam integer BAUD_COUNT = CLK_FREQ / BAUD_RATE;

integer counter;

always_ff @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        counter   <= 0;
        baud_tick <= 0;
    end

    else
    begin

        if(counter == BAUD_COUNT-1)
        begin
            counter   <= 0;
            baud_tick <= 1;
        end

        else
        begin
            counter   <= counter + 1;
            baud_tick <= 0;
        end

    end

end

endmodule