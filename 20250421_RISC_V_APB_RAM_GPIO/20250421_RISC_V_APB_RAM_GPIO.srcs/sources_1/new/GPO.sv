`timescale 1ns / 1ps

module GPO (
    input  logic [7:0] moder,
    input  logic [7:0] odr,
    output logic [7:0] outPort
);

    genvar i;
    generate
        for (i = 0; i < 8; i++) begin
            assign outPort[i] = moder[i] ? odr[i] : 1'bz;
        end
    endgenerate

    // assign outPort = moder[0] ? odr[0] : 1'bz;
    // assign outPort = moder[1] ? odr[1] : 1'bz;
    // assign outPort = moder[2] ? odr[2] : 1'bz;
    // assign outPort = moder[3] ? odr[3] : 1'bz;
    // assign outPort = moder[4] ? odr[4] : 1'bz;
    // assign outPort = moder[5] ? odr[5] : 1'bz;
    // assign outPort = moder[6] ? odr[6] : 1'bz;
    // assign outPort = moder[7] ? odr[7] : 1'bz;

    // always_comb begin
    //     for (i = 0; i < 8; i++) begin
    //         assign outPort[i] = moder[i] ? odr[i] : 1'bz;
    //     end
    // end

endmodule
