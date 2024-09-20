`timescale 1ns / 1ps

module tb_top_module;
    reg [99:0] a;
    reg [99:0] b;
    reg sel;
    wire [99:0] out;
    
    integer file;
    integer scenario;
    
    top_module DUT (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );
    
    initial begin
        file = $fopen("TBout.txt", "w");
        
        // Scenario 1
        scenario = 1;
        a = 100'b0; b = 100'b0; sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 2
        scenario = 2;
        a = {100{1'b1}}; b = 100'b0; sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 3
        scenario = 3;
        a = 100'b1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010;
        b = 100'b0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101;
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 4
        scenario = 4;
        a = 100'b1101011001_0110010110_1001101101_0001011101_0110100101_1010011001_1100101010_1010110111_0011001011_1100101010;
        b = 100'b0010110101_1001010101_1100100101_1101101010_1001010101_1011100101_1101010101_0010101110_1101101010_0010101100;
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 5
        scenario = 5;
        a = {50{1'b1}, 50'b0};
        b = {50'b0, 50{1'b1}};
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 6
        scenario = 6;
        a = 100'b0; b = 100'b0; sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 7
        scenario = 7;
        a = 100'b0; b = {100{1'b1}}; sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 8
        scenario = 8;
        a = 100'b0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101;
        b = 100'b1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010;
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 9
        scenario = 9;
        a = 100'b1110010101_1111110011_0001111001_1001110100_0100111001_1011110110_1111010101_1101110101_0000110010_1101001110;
        b = 100'b0101100110_0110110010_1001011100_0011010101_1110011000_1010011101_0001101001_1011101001_1011101011_0011010111;
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 10
        scenario = 10;
        a = {50'b0, 50{1'b1}};
        b = {50{1'b1}, 50'b0};
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 11
        scenario = 11;
        a = 100'b1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010_1010101010;
        b = 100'b0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101_0101010101;
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        
        // Scenario 12
        scenario = 12;
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        sel = 0;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        sel = 1;
        #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);

        // Scenario 13
        scenario = 13;
        repeat (6) begin
            a = $random; b = $random; sel = ~sel;
            #10 $fdisplay(file, "scenario: %d, a = %d, b = %d, sel = %d, out = %d", scenario, a, b, sel, out);
        end

        $fclose(file);
    end
endmodule
