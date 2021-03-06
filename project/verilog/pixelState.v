
/* `timescale 1 ns / 1 ps */


module pixelState(
                       input logic  clk,
                       input  logic reset,
                       output logic erase,
                       output logic expose,
                       output logic read1,
                       output logic read2,
                       output logic convert
                      );


     //State duration in clock cycles
   parameter integer c_erase = 5;
   parameter integer c_expose = 255;
   parameter integer c_convert = 255;
   parameter integer c_read = 5;

   //------------------------------------------------------------
   // State Machine
   //------------------------------------------------------------
   parameter ERASE=0, EXPOSE=1, CONVERT=2, READ1=3, READ2=4, IDLE=5;


   logic               convert_stop;
   logic [2:0]         state,next_state;   //States
   integer             counter;


   // Control the output signals
   always_ff @(negedge clk ) begin
      case(state)
        ERASE: begin
           erase <= 1;
           read1 <= 0;
           read2 <= 0;
           expose <= 0;
           convert <= 0;
        end
        EXPOSE: begin
           erase <= 0;
           read1 <= 0;
           read2 <= 0;
           expose <= 1;
           convert <= 0;
        end
        CONVERT: begin
           erase <= 0;
           read1 <= 0;
           read2 <= 0;
           expose <= 0;
           convert = 1;
        end
        READ1: begin
           erase <= 0;
           read1 <= 1;
           read2 <= 0;
           expose <= 0;
           convert <= 0;
        end
        READ2: begin
           erase <= 0;
           read1 <= 0;
           read2 <= 1;
           expose <= 0;
           convert <= 0;
        end
        IDLE: begin
           erase <= 0;
           read1 <= 0;
           read2 <= 0;
           expose <= 0;
           convert <= 0;
        end
      endcase // case (state)
   end // always @ (state)


   // Control the state transitions.
   //TODO: The counter should probably be an always_comb. Might be a good idea
   //to also reset the counter from the state machine, i.e provide the count
   //down value, and trigger on 0
   always_ff @(posedge clk or posedge reset) begin
      if(reset) begin
         state = IDLE;
         next_state = ERASE;
         counter  = 0;
         convert  = 0;
      end
      else begin
         case (state)
           ERASE: begin
              if(counter == c_erase) begin
                 next_state <= EXPOSE;
                 state <= IDLE;
              end
           end
           EXPOSE: begin
              if(counter == c_expose) begin
                 next_state <= CONVERT;
                 state <= IDLE;
              end
           end
           CONVERT: begin
              if (counter == c_convert) begin
                next_state <= READ1;
                state <= IDLE;
            end
           end
           READ1:
             if(counter == c_read) begin
                next_state <= READ2;
                state <= IDLE;
             end
           READ2:
             if(counter == c_read) begin
                next_state <= ERASE;
                state <= IDLE;
             end
           IDLE:
             state <= next_state;
         endcase // case (state)
         if(state == IDLE)
           counter = 0;
         else
           counter = counter + 1;
      end
   end // always @ (posedge clk or posedge reset)

endmodule // test

