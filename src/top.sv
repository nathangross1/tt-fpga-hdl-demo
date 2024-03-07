//_\TLV_version 1d: tl-x.org, generated by SandPiper(TM) 1.14-2022/10/10-beta-Pro
//_\source top.tlv 41

//_\SV
   // Include Tiny Tapeout Lab.
   // Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlv_lib/tiny_tapeout_lib.tlv"// Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlv_lib/fpga_includes.tlv"
//_\source top.tlv 272

//_\SV

// ================================================
// A simple Makerchip Verilog test bench driving random stimulus.
// Modify the module contents to your needs.
// ================================================

module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
   // Tiny tapeout I/O signals.
   logic [7:0] ui_in, uo_out;
   
   logic [31:0] r;  // a random value
   always @(posedge clk) r <= 0;
   assign ui_in = r[7:0];
   
   logic ena = 1'b0;
   logic rst_n = ! reset;

   /*
   // Or, to provide specific inputs at specific times (as for lab C-TB) ...
   // BE SURE TO COMMENT THE ASSIGNMENT OF INPUTS ABOVE.
   // BE SURE TO DRIVE THESE ON THE B-PHASE OF THE CLOCK (ODD STEPS).
   // Driving on the rising clock edge creates a race with the clock that has unpredictable simulation behavior.
   initial begin
      #1  // Drive inputs on the B-phase.
         ui_in = 8'h0;
      #10 // Step 5 cycles, past reset.
         ui_in = 8'hFF;
      // ...etc.
   end
   */

   // Instantiate the Tiny Tapeout module.
   my_design tt(.*);

   assign passed = top.cyc_cnt > 60;
   assign failed = 1'b0;
endmodule


// Provide a wrapper module to debounce input signals if requested.
// The Tiny Tapeout top-level module.
// This simply debounces and synchronizes inputs.
// Debouncing is based on a counter. A change to any input will only be recognized once ALL inputs
// are stable for a certain duration. This approach uses a single counter vs. a counter for each
// bit.
module tt_um_template (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    /*   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    */
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    
    // Synchronize.
    logic [9:0] inputs_ff, inputs_sync;
    always @(posedge clk) begin
        inputs_ff <= {ui_in, ena, rst_n};
        inputs_sync <= inputs_ff;
    end

    // Debounce.
    `define DEBOUNCE_MAX_CNT 14'h3fff
    logic [9:0] inputs_candidate, inputs_captured;
    logic sync_rst_n = inputs_sync[0];
    logic [13:0] cnt;
    always @(posedge clk) begin
        if (!sync_rst_n)
           cnt <= `DEBOUNCE_MAX_CNT;
        else if (inputs_sync != inputs_candidate) begin
           // Inputs changed before stablizing.
           cnt <= `DEBOUNCE_MAX_CNT;
           inputs_candidate <= inputs_sync;
        end
        else if (cnt > 0)
           cnt <= cnt - 14'b1;
        else begin
           // Cnt == 0. Capture candidate inputs.
           inputs_captured <= inputs_candidate;
        end
    end
    logic [7:0] clean_ui_in;
    logic clean_ena, clean_rst_n;
    assign {clean_ui_in, clean_ena, clean_rst_n} = inputs_captured;

    my_design my_design (
        .ui_in(clean_ui_in),
        
        .ena(clean_ena),
        .rst_n(clean_rst_n),
        .*);
endmodule
//_\SV



// =======================
// The Tiny Tapeout module
// =======================

module my_design (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    /*   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    */
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
   wire reset = ! rst_n;

// ---------- Generated Code Inlined Here (before 1st \TLV) ----------
// Generated by SandPiper(TM) 1.14-2022/10/10-beta-Pro from Redwood EDA, LLC.
// (Installed here: /usr/local/mono/sandpiper/distro.)
// Redwood EDA, LLC does not claim intellectual property rights to this file and provides no warranty regarding its correctness or quality.


// For silencing unused signal messages.
`define BOGUS_USE(ignore)


genvar digit, input_label, leds, switch;


//
// Signals declared top-level.
//

// For $slideswitch.
logic [7:0] L0_slideswitch_a0;

// For $sseg_decimal_point_n.
logic L0_sseg_decimal_point_n_a0;

// For $sseg_digit_n.
logic [7:0] L0_sseg_digit_n_a0;

// For $sseg_segment_n.
logic [6:0] L0_sseg_segment_n_a0;

// For /fpga_pins/fpga|project$bl.
logic [6:0] FpgaPins_Fpga_PROJECT_bl_a0;

// For /fpga_pins/fpga|project$bot.
logic [6:0] FpgaPins_Fpga_PROJECT_bot_a0;

// For /fpga_pins/fpga|project$br.
logic [6:0] FpgaPins_Fpga_PROJECT_br_a0;

// For /fpga_pins/fpga|project$button_num.
logic [6:0] FpgaPins_Fpga_PROJECT_button_num_a0,
            FpgaPins_Fpga_PROJECT_button_num_a1;

// For /fpga_pins/fpga|project$button_ones.
logic [4:0] FpgaPins_Fpga_PROJECT_button_ones_a0;

// For /fpga_pins/fpga|project$button_ones_temp.
logic [6:0] FpgaPins_Fpga_PROJECT_button_ones_temp_a0;

// For /fpga_pins/fpga|project$button_press.
logic FpgaPins_Fpga_PROJECT_button_press_a0,
      FpgaPins_Fpga_PROJECT_button_press_a1;

// For /fpga_pins/fpga|project$button_tens.
logic [4:0] FpgaPins_Fpga_PROJECT_button_tens_a0;

// For /fpga_pins/fpga|project$button_tens_temp.
logic [6:0] FpgaPins_Fpga_PROJECT_button_tens_temp_a0;

// For /fpga_pins/fpga|project$counter.
logic [31:0] FpgaPins_Fpga_PROJECT_counter_a0,
             FpgaPins_Fpga_PROJECT_counter_a1;

// For /fpga_pins/fpga|project$die_ones.
logic [4:0] FpgaPins_Fpga_PROJECT_die_ones_a0;

// For /fpga_pins/fpga|project$die_ones_temp.
logic [6:0] FpgaPins_Fpga_PROJECT_die_ones_temp_a0;

// For /fpga_pins/fpga|project$die_size.
logic [6:0] FpgaPins_Fpga_PROJECT_die_size_a0;

// For /fpga_pins/fpga|project$die_tens.
logic [4:0] FpgaPins_Fpga_PROJECT_die_tens_a0;

// For /fpga_pins/fpga|project$die_tens_temp.
logic [6:0] FpgaPins_Fpga_PROJECT_die_tens_temp_a0;

// For /fpga_pins/fpga|project$ee.
logic [6:0] FpgaPins_Fpga_PROJECT_ee_a0;

// For /fpga_pins/fpga|project$eight.
logic [6:0] FpgaPins_Fpga_PROJECT_eight_a0;

// For /fpga_pins/fpga|project$five.
logic [6:0] FpgaPins_Fpga_PROJECT_five_a0;

// For /fpga_pins/fpga|project$four.
logic [6:0] FpgaPins_Fpga_PROJECT_four_a0;

// For /fpga_pins/fpga|project$mid.
logic [6:0] FpgaPins_Fpga_PROJECT_mid_a0;

// For /fpga_pins/fpga|project$nine.
logic [6:0] FpgaPins_Fpga_PROJECT_nine_a0;

// For /fpga_pins/fpga|project$one.
logic [6:0] FpgaPins_Fpga_PROJECT_one_a0;

// For /fpga_pins/fpga|project$out.
logic [4:0] FpgaPins_Fpga_PROJECT_out_a0;

// For /fpga_pins/fpga|project$output.
logic [6:0] FpgaPins_Fpga_PROJECT_output_a0;

// For /fpga_pins/fpga|project$output_switch.
logic [7:0] FpgaPins_Fpga_PROJECT_output_switch_a0,
            FpgaPins_Fpga_PROJECT_output_switch_a1;

// For /fpga_pins/fpga|project$rand_num.
logic [6:0] FpgaPins_Fpga_PROJECT_rand_num_a0,
            FpgaPins_Fpga_PROJECT_rand_num_a1;

// For /fpga_pins/fpga|project$reset.
logic FpgaPins_Fpga_PROJECT_reset_a0,
      FpgaPins_Fpga_PROJECT_reset_a1;

// For /fpga_pins/fpga|project$rr.
logic [6:0] FpgaPins_Fpga_PROJECT_rr_a0;

// For /fpga_pins/fpga|project$seven.
logic [6:0] FpgaPins_Fpga_PROJECT_seven_a0;

// For /fpga_pins/fpga|project$six.
logic [6:0] FpgaPins_Fpga_PROJECT_six_a0;

// For /fpga_pins/fpga|project$three.
logic [6:0] FpgaPins_Fpga_PROJECT_three_a0;

// For /fpga_pins/fpga|project$tl.
logic [6:0] FpgaPins_Fpga_PROJECT_tl_a0;

// For /fpga_pins/fpga|project$top.
logic [6:0] FpgaPins_Fpga_PROJECT_top_a0;

// For /fpga_pins/fpga|project$tr.
logic [6:0] FpgaPins_Fpga_PROJECT_tr_a0;

// For /fpga_pins/fpga|project$two.
logic [6:0] FpgaPins_Fpga_PROJECT_two_a0;

// For /fpga_pins/fpga|project$zero.
logic [6:0] FpgaPins_Fpga_PROJECT_zero_a0;




   //
   // Scope: /fpga_pins
   //


      //
      // Scope: /fpga
      //


         //
         // Scope: |project
         //

            // Staging of $button_num.
            always_ff @(posedge clk) FpgaPins_Fpga_PROJECT_button_num_a1[6:0] <= FpgaPins_Fpga_PROJECT_button_num_a0[6:0];

            // Staging of $button_press.
            always_ff @(posedge clk) FpgaPins_Fpga_PROJECT_button_press_a1 <= FpgaPins_Fpga_PROJECT_button_press_a0;

            // Staging of $counter.
            always_ff @(posedge clk) FpgaPins_Fpga_PROJECT_counter_a1[31:0] <= FpgaPins_Fpga_PROJECT_counter_a0[31:0];

            // Staging of $output_switch.
            always_ff @(posedge clk) FpgaPins_Fpga_PROJECT_output_switch_a1[7:0] <= FpgaPins_Fpga_PROJECT_output_switch_a0[7:0];

            // Staging of $rand_num.
            always_ff @(posedge clk) FpgaPins_Fpga_PROJECT_rand_num_a1[6:0] <= FpgaPins_Fpga_PROJECT_rand_num_a0[6:0];

            // Staging of $reset.
            always_ff @(posedge clk) FpgaPins_Fpga_PROJECT_reset_a1 <= FpgaPins_Fpga_PROJECT_reset_a0;








//
// Debug Signals
//

   if (1) begin : DEBUG_SIGS_GTKWAVE

      (* keep *) logic [7:0] \@0$slideswitch ;
      assign \@0$slideswitch = L0_slideswitch_a0;
      (* keep *) logic  \@0$sseg_decimal_point_n ;
      assign \@0$sseg_decimal_point_n = L0_sseg_decimal_point_n_a0;
      (* keep *) logic [7:0] \@0$sseg_digit_n ;
      assign \@0$sseg_digit_n = L0_sseg_digit_n_a0;
      (* keep *) logic [6:0] \@0$sseg_segment_n ;
      assign \@0$sseg_segment_n = L0_sseg_segment_n_a0;

      //
      // Scope: /digit[0:0]
      //
      for (digit = 0; digit <= 0; digit++) begin : \/digit 

         //
         // Scope: /leds[7:0]
         //
         for (leds = 0; leds <= 7; leds++) begin : \/leds 
            (* keep *) logic  \//@0$viz_lit ;
            assign \//@0$viz_lit = L1_Digit[digit].L2_Leds[leds].L2_viz_lit_a0;
         end
      end

      //
      // Scope: /fpga_pins
      //
      if (1) begin : \/fpga_pins 

         //
         // Scope: /fpga
         //
         if (1) begin : \/fpga 

            //
            // Scope: |project
            //
            if (1) begin : P_project
               (* keep *) logic [6:0] \///@0$bl ;
               assign \///@0$bl = FpgaPins_Fpga_PROJECT_bl_a0;
               (* keep *) logic [6:0] \///@0$bot ;
               assign \///@0$bot = FpgaPins_Fpga_PROJECT_bot_a0;
               (* keep *) logic [6:0] \///@0$br ;
               assign \///@0$br = FpgaPins_Fpga_PROJECT_br_a0;
               (* keep *) logic [6:0] \///@0$button_num ;
               assign \///@0$button_num = FpgaPins_Fpga_PROJECT_button_num_a0;
               (* keep *) logic [4:0] \///@0$button_ones ;
               assign \///@0$button_ones = FpgaPins_Fpga_PROJECT_button_ones_a0;
               (* keep *) logic [6:0] \///@0$button_ones_temp ;
               assign \///@0$button_ones_temp = FpgaPins_Fpga_PROJECT_button_ones_temp_a0;
               (* keep *) logic  \///@0$button_press ;
               assign \///@0$button_press = FpgaPins_Fpga_PROJECT_button_press_a0;
               (* keep *) logic [4:0] \///@0$button_tens ;
               assign \///@0$button_tens = FpgaPins_Fpga_PROJECT_button_tens_a0;
               (* keep *) logic [6:0] \///@0$button_tens_temp ;
               assign \///@0$button_tens_temp = FpgaPins_Fpga_PROJECT_button_tens_temp_a0;
               (* keep *) logic [31:0] \///@0$counter ;
               assign \///@0$counter = FpgaPins_Fpga_PROJECT_counter_a0;
               (* keep *) logic [4:0] \///@0$die_ones ;
               assign \///@0$die_ones = FpgaPins_Fpga_PROJECT_die_ones_a0;
               (* keep *) logic [6:0] \///@0$die_ones_temp ;
               assign \///@0$die_ones_temp = FpgaPins_Fpga_PROJECT_die_ones_temp_a0;
               (* keep *) logic [6:0] \///@0$die_size ;
               assign \///@0$die_size = FpgaPins_Fpga_PROJECT_die_size_a0;
               (* keep *) logic [4:0] \///@0$die_tens ;
               assign \///@0$die_tens = FpgaPins_Fpga_PROJECT_die_tens_a0;
               (* keep *) logic [6:0] \///@0$die_tens_temp ;
               assign \///@0$die_tens_temp = FpgaPins_Fpga_PROJECT_die_tens_temp_a0;
               (* keep *) logic [6:0] \///@0$ee ;
               assign \///@0$ee = FpgaPins_Fpga_PROJECT_ee_a0;
               (* keep *) logic [6:0] \///@0$eight ;
               assign \///@0$eight = FpgaPins_Fpga_PROJECT_eight_a0;
               (* keep *) logic [6:0] \///@0$five ;
               assign \///@0$five = FpgaPins_Fpga_PROJECT_five_a0;
               (* keep *) logic [6:0] \///@0$four ;
               assign \///@0$four = FpgaPins_Fpga_PROJECT_four_a0;
               (* keep *) logic [6:0] \///@0$mid ;
               assign \///@0$mid = FpgaPins_Fpga_PROJECT_mid_a0;
               (* keep *) logic [6:0] \///@0$nine ;
               assign \///@0$nine = FpgaPins_Fpga_PROJECT_nine_a0;
               (* keep *) logic [6:0] \///@0$one ;
               assign \///@0$one = FpgaPins_Fpga_PROJECT_one_a0;
               (* keep *) logic [4:0] \///@0$out ;
               assign \///@0$out = FpgaPins_Fpga_PROJECT_out_a0;
               (* keep *) logic [6:0] \///@0$output ;
               assign \///@0$output = FpgaPins_Fpga_PROJECT_output_a0;
               (* keep *) logic [7:0] \///@0$output_switch ;
               assign \///@0$output_switch = FpgaPins_Fpga_PROJECT_output_switch_a0;
               (* keep *) logic [6:0] \///@0$rand_num ;
               assign \///@0$rand_num = FpgaPins_Fpga_PROJECT_rand_num_a0;
               (* keep *) logic  \///@0$reset ;
               assign \///@0$reset = FpgaPins_Fpga_PROJECT_reset_a0;
               (* keep *) logic [6:0] \///@0$rr ;
               assign \///@0$rr = FpgaPins_Fpga_PROJECT_rr_a0;
               (* keep *) logic [6:0] \///@0$seven ;
               assign \///@0$seven = FpgaPins_Fpga_PROJECT_seven_a0;
               (* keep *) logic [6:0] \///@0$six ;
               assign \///@0$six = FpgaPins_Fpga_PROJECT_six_a0;
               (* keep *) logic [6:0] \///@0$three ;
               assign \///@0$three = FpgaPins_Fpga_PROJECT_three_a0;
               (* keep *) logic [6:0] \///@0$tl ;
               assign \///@0$tl = FpgaPins_Fpga_PROJECT_tl_a0;
               (* keep *) logic [6:0] \///@0$top ;
               assign \///@0$top = FpgaPins_Fpga_PROJECT_top_a0;
               (* keep *) logic [6:0] \///@0$tr ;
               assign \///@0$tr = FpgaPins_Fpga_PROJECT_tr_a0;
               (* keep *) logic [6:0] \///@0$two ;
               assign \///@0$two = FpgaPins_Fpga_PROJECT_two_a0;
               (* keep *) logic [6:0] \///@0$zero ;
               assign \///@0$zero = FpgaPins_Fpga_PROJECT_zero_a0;
            end
         end
      end

      //
      // Scope: /switch[7:0]
      //
      for (switch = 0; switch <= 7; switch++) begin : \/switch 
         (* keep *) logic  \/@0$viz_switch ;
         assign \/@0$viz_switch = L1_Switch[switch].L1_viz_switch_a0;
      end


   end

// ---------- Generated Code Ends ----------
//_\TLV
   /* verilator lint_off UNOPTFLAT */
   // Connect Tiny Tapeout I/Os to Virtual FPGA Lab.
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlvlib/tinytapeoutlib.tlv 76   // Instantiated from top.tlv, 341 as: m5+tt_connections()
      assign L0_slideswitch_a0[7:0] = ui_in;
      assign L0_sseg_segment_n_a0[6:0] = ~ uo_out[6:0];
      assign L0_sseg_decimal_point_n_a0 = ~ uo_out[7];
      assign L0_sseg_digit_n_a0[7:0] = 8'b11111110;
   //_\end_source

   // Instantiate the Virtual FPGA Lab.
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 307   // Instantiated from top.tlv, 344 as: m5+board(/top, /fpga, 7, $, , my_design)
      
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 355   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 309 as: m4+thanks(m5__l(309)m5_eval(m5_get(BOARD_THANKS_ARGS)))
         //_/thanks
            
      //_\end_source
      
   
      // Board VIZ.
   
      // Board Image.
      
      //_/fpga_pins
         
         //_/fpga
            //_\source top.tlv 48   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 340 as: m4+my_design.
            
               //_|project
                  //_@0
                     //TODO: get rid of tens if single digit
                     //TODO: Animation
                     //TODO: err if 0
                     //TODO: fix counter recycling issue
                     //TODO: same clock on ASIC?
            
                     assign FpgaPins_Fpga_PROJECT_reset_a0 = reset;
            
                     //Constants
                     assign FpgaPins_Fpga_PROJECT_zero_a0[6:0] = 7'b0111111;
                     assign FpgaPins_Fpga_PROJECT_one_a0[6:0] = 7'b0000110;
                     assign FpgaPins_Fpga_PROJECT_two_a0[6:0] = 7'b1011011;
                     assign FpgaPins_Fpga_PROJECT_three_a0[6:0] = 7'b1001111;
                     assign FpgaPins_Fpga_PROJECT_four_a0[6:0] = 7'b1100110;
                     assign FpgaPins_Fpga_PROJECT_five_a0[6:0] = 7'b1101101;
                     assign FpgaPins_Fpga_PROJECT_six_a0[6:0] = 7'b1111101;
                     assign FpgaPins_Fpga_PROJECT_seven_a0[6:0] = 7'b0000111;
                     assign FpgaPins_Fpga_PROJECT_eight_a0[6:0] = 7'b1111111;
                     assign FpgaPins_Fpga_PROJECT_nine_a0[6:0] = 7'b1101111;
            
                     assign FpgaPins_Fpga_PROJECT_ee_a0[6:0] = 7'b1111001;
                     assign FpgaPins_Fpga_PROJECT_rr_a0[6:0] = 7'b1010000;
            
                     assign FpgaPins_Fpga_PROJECT_top_a0[6:0] = 7'b0000001;
                     assign FpgaPins_Fpga_PROJECT_tr_a0[6:0] = 7'b0000010;
                     assign FpgaPins_Fpga_PROJECT_br_a0[6:0] = 7'b0000100;
                     assign FpgaPins_Fpga_PROJECT_bot_a0[6:0] = 7'b0001000;
                     assign FpgaPins_Fpga_PROJECT_bl_a0[6:0] = 7'b0010000;
                     assign FpgaPins_Fpga_PROJECT_tl_a0[6:0] = 7'b0100000;
            
                     assign FpgaPins_Fpga_PROJECT_mid_a0[6:0] = 7'b1000000;
            
                     // Gather inputs
                     //Die size inputs 0-6
                     assign FpgaPins_Fpga_PROJECT_die_size_a0[6:0] = ui_in[6:0];
                     //Button press at input 7
                     assign FpgaPins_Fpga_PROJECT_button_press_a0 = ui_in[7];
            
                     // From 1 to die size, count. reset to 1 if at die size
                     assign FpgaPins_Fpga_PROJECT_rand_num_a0[6:0] =
                        FpgaPins_Fpga_PROJECT_reset_a1 ?
                           7'b0000001 :
                        FpgaPins_Fpga_PROJECT_rand_num_a1 >= FpgaPins_Fpga_PROJECT_die_size_a0 ?
                           7'b0000001 :
                        //else
                           FpgaPins_Fpga_PROJECT_rand_num_a1 + 1;
            
                     //Get ones and tens values for die size for display
                     //If >99 save Er chars
                     assign FpgaPins_Fpga_PROJECT_die_ones_temp_a0[6:0] = FpgaPins_Fpga_PROJECT_die_size_a0 % 10;
                     assign FpgaPins_Fpga_PROJECT_die_tens_temp_a0[6:0] = FpgaPins_Fpga_PROJECT_die_size_a0 / 10;
            
                     assign FpgaPins_Fpga_PROJECT_die_ones_a0[4:0] =
                        FpgaPins_Fpga_PROJECT_die_size_a0 > 7'd99 ?
                           5'b01011 :
                        //else
                        FpgaPins_Fpga_PROJECT_die_ones_temp_a0[4:0];
            
                     assign FpgaPins_Fpga_PROJECT_die_tens_a0[4:0] =
                        FpgaPins_Fpga_PROJECT_die_size_a0 > 7'd99 ?
                           5'b01010 :
                        //else
                        FpgaPins_Fpga_PROJECT_die_tens_temp_a0[4:0];
            
                     //After button press
                       //find trailing edge of button press
                     assign FpgaPins_Fpga_PROJECT_button_num_a0[6:0] =
                        FpgaPins_Fpga_PROJECT_reset_a1 ?
                           7'b0 :
                        ((FpgaPins_Fpga_PROJECT_button_press_a1 == 0) & (FpgaPins_Fpga_PROJECT_button_press_a0 == 1)) ?
                           FpgaPins_Fpga_PROJECT_rand_num_a0 :
                        //else
                           FpgaPins_Fpga_PROJECT_button_num_a1;
            
                     assign FpgaPins_Fpga_PROJECT_counter_a0[31:0] =
                        FpgaPins_Fpga_PROJECT_reset_a1 ?
                           32'b0 :
                        ((FpgaPins_Fpga_PROJECT_button_press_a1 == 0) & (FpgaPins_Fpga_PROJECT_button_press_a0 == 1)) ?
                           32'b0 :
                        //else
                           FpgaPins_Fpga_PROJECT_counter_a1 + 1 ;
            
            
                     //Get ones and tens values after button press
                        //Display Er for >99 roll
                        //Display animation
                     assign FpgaPins_Fpga_PROJECT_button_ones_temp_a0[6:0] = FpgaPins_Fpga_PROJECT_button_num_a0 % 10;
                     assign FpgaPins_Fpga_PROJECT_button_tens_temp_a0[6:0] = FpgaPins_Fpga_PROJECT_button_num_a0 / 10;
                     assign FpgaPins_Fpga_PROJECT_button_ones_a0[4:0] =
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd5000000 ?
                           5'b01100 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd10000000 ?
                           5'b01101 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd15000000 ?
                           5'b01110 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd20000000 ?
                           5'b01111 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd25000000 ?
                           5'b10000 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd30000000 ?
                           5'b10001 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd35000000 ?
                           5'b01100 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd40000000 ?
                           5'b01101 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd45000000 ?
                           5'b01110 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd50000000 ?
                           5'b01111 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd55000000 ?
                           5'b10000 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd60000000 ?
                           5'b10001 :
                        FpgaPins_Fpga_PROJECT_die_size_a0 > 7'd99 ?
                           5'b01011 :
                        //else
                        FpgaPins_Fpga_PROJECT_button_ones_temp_a0[4:0];
                     assign FpgaPins_Fpga_PROJECT_button_tens_a0[4:0] =
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd5000000 ?
                           5'b01100 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd10000000 ?
                           5'b01101 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd15000000 ?
                           5'b01110 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd20000000 ?
                           5'b01111 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd25000000 ?
                           5'b10000 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd30000000 ?
                           5'b10001 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd35000000 ?
                           5'b01100 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd40000000 ?
                           5'b01101 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd45000000 ?
                           5'b01110 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd50000000 ?
                           5'b01111 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd55000000 ?
                           5'b10000 :
                        FpgaPins_Fpga_PROJECT_counter_a0 < 32'd60000000 ?
                           5'b10001 :
                        FpgaPins_Fpga_PROJECT_die_size_a0 > 7'd99 ?
                           5'b01011 :
                        //else
                        FpgaPins_Fpga_PROJECT_button_tens_temp_a0[4:0];
            
                     //Switch outputs every 128 cycles
                     assign FpgaPins_Fpga_PROJECT_output_switch_a0[7:0] =
                        FpgaPins_Fpga_PROJECT_reset_a1 ?
                           8'b0 :
                        //else
                           FpgaPins_Fpga_PROJECT_output_switch_a1 + 1;
            
                     //Output selector
                     // If button not pressed, display die size
                        //If >99, display err
                     // When pressed, display result, excluding tens if one digit
                     assign FpgaPins_Fpga_PROJECT_out_a0[4:0] =
                        ((FpgaPins_Fpga_PROJECT_button_press_a0 == 0) && (FpgaPins_Fpga_PROJECT_output_switch_a0[7] == 0)) ?
                           FpgaPins_Fpga_PROJECT_die_ones_a0 :
                        ((FpgaPins_Fpga_PROJECT_button_press_a0 == 0) && (FpgaPins_Fpga_PROJECT_output_switch_a0[7] == 1)) ?
                           FpgaPins_Fpga_PROJECT_die_tens_a0 :
                        ((FpgaPins_Fpga_PROJECT_button_press_a0 == 1) && (FpgaPins_Fpga_PROJECT_output_switch_a0[7] == 0)) ?
                           FpgaPins_Fpga_PROJECT_button_ones_a0 :
                        //else
                        FpgaPins_Fpga_PROJECT_button_tens_a0;
            
                     //Format output to 7 segment
                     assign FpgaPins_Fpga_PROJECT_output_a0[6:0] =
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b00000 ?
                           FpgaPins_Fpga_PROJECT_zero_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b00001 ?
                           FpgaPins_Fpga_PROJECT_one_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b00010 ?
                           FpgaPins_Fpga_PROJECT_two_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b00011 ?
                           FpgaPins_Fpga_PROJECT_three_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b00100 ?
                           FpgaPins_Fpga_PROJECT_four_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b00101 ?
                           FpgaPins_Fpga_PROJECT_five_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b00110 ?
                           FpgaPins_Fpga_PROJECT_six_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b00111 ?
                           FpgaPins_Fpga_PROJECT_seven_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b01000 ?
                           FpgaPins_Fpga_PROJECT_eight_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b01001 ?
                           FpgaPins_Fpga_PROJECT_nine_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b01010 ?
                           FpgaPins_Fpga_PROJECT_ee_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b01011 ?
                           FpgaPins_Fpga_PROJECT_rr_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b01100 ?
                           FpgaPins_Fpga_PROJECT_top_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b01101 ?
                           FpgaPins_Fpga_PROJECT_tr_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b01110 ?
                           FpgaPins_Fpga_PROJECT_br_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b01111 ?
                           FpgaPins_Fpga_PROJECT_bot_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b10000 ?
                           FpgaPins_Fpga_PROJECT_bl_a0 :
                        FpgaPins_Fpga_PROJECT_out_a0 == 5'b10001 ?
                           FpgaPins_Fpga_PROJECT_tl_a0 :
                        //default
                           FpgaPins_Fpga_PROJECT_mid_a0;
            
                     //Concatenate output for display
                     assign uo_out =
                        FpgaPins_Fpga_PROJECT_output_switch_a0[7] == 0 ?
                           {1'b0, FpgaPins_Fpga_PROJECT_output_a0} :
                        //else
                           {1'b1, FpgaPins_Fpga_PROJECT_output_a0};
            
               // Note that pipesignals assigned here can be found under /fpga_pins/fpga.
            
               // Connect Tiny Tapeout outputs. Note that uio_ outputs are not available in the Tiny-Tapeout-3-based FPGA boards.
               
               
            //_\end_source
   
      // LEDs.
      
   
      // 7-Segment
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 395   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 346 as: m4+fpga_sseg.
         for (digit = 0; digit <= 0; digit++) begin : L1_Digit //_/digit
            
            for (leds = 0; leds <= 7; leds++) begin : L2_Leds //_/leds

               // For $viz_lit.
               logic L2_viz_lit_a0;

               assign L2_viz_lit_a0 = (! L0_sseg_digit_n_a0[digit]) && ! ((leds == 7) ? L0_sseg_decimal_point_n_a0 : L0_sseg_segment_n_a0[leds % 7]);
               
            end
         end
      //_\end_source
   
      // slideswitches
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 454   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 349 as: m4+fpga_switch.
         for (switch = 0; switch <= 7; switch++) begin : L1_Switch //_/switch

            // For $viz_switch.
            logic L1_viz_switch_a0;

            assign L1_viz_switch_a0 = L0_slideswitch_a0[switch];
            
         end
      //_\end_source
   
      // pushbuttons
      
   //_\end_source
   // Label the switch inputs [0..7] (1..8 on the physical switch panel) (top-to-bottom).
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlvlib/tinytapeoutlib.tlv 82   // Instantiated from top.tlv, 346 as: m5+tt_input_labels_viz(⌈"UNUSED", "UNUSED", "UNUSED", "UNUSED", "UNUSED", "UNUSED", "UNUSED", "UNUSED"⌉)
      for (input_label = 0; input_label <= 7; input_label++) begin : L1_InputLabel //_/input_label
         
      end
   //_\end_source

//_\SV
endmodule


// Undefine macros defined by SandPiper.
`undef BOGUS_USE
