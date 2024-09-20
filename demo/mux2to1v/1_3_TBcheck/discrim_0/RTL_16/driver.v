`timescale 1ns / 1ps
module testbench;
    reg [99:0] a;
    reg [99:0] b;
    reg sel;
    wire [99:0] out;
    integer file;
    integer scenario;

    // Instantiate the DUT
    top_module dut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Open file for writing
        file = $fopen("TBout.txt", "w");

        // Scenario 1
        scenario = 1;
        a = 100'b0;
        b = 100'b0;
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 2
        scenario = 2;
        a = 100'b1;
        b = 100'b0;
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 3
        scenario = 3;
        a = 100'b1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010;
        b = 100'b0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101;
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 4
        scenario = 4;
        a = $random;
        b = $random;
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 5
        scenario = 5;
        a = {50'b1, 50'b0};
        b = {50'b0, 50'b1};
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 6
        scenario = 6;
        a = 100'b0;
        b = 100'b0;
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 7
        scenario = 7;
        a = 100'b0;
        b = 100'b1;
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 8
        scenario = 8;
        a = 100'b0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101;
        b = 100'b1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010;
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 9
        scenario = 9;
        a = $random;
        b = $random;
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 10
        scenario = 10;
        a = {50'b0, 50'b1};
        b = {50'b1, 50'b0};
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 11
        scenario = 11;
        a = $random;
        b = $random;
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 12
        scenario = 12;
        a = $random;
        b = $random;
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 13
        scenario = 13;
        a = $random;
        b = $random;
        sel = 0; // Ensure 'sel' has an initial value to avoid indefinite toggling
        repeat (10) begin
            sel = ~sel;
            #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        end

        // Close file
        $fclose(file);
        $finish; // Ensure simulation ends gracefully instead of using $stop
    end
endmodule
