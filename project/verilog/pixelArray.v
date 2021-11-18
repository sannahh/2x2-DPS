module PIXEL_ARRAY(
   input logic      VBN1,
   input logic      RAMP,
   input logic      RESET,
   input logic      ERASE,
   input logic      EXPOSE,
   input logic      READ1,
   input logic      READ2,
   inout [7:0]      DATA1,
   inout [7:0]      DATA2,
   inout [7:0]      DATA3,
   inout [7:0]      DATA4);



/*     logic [7:0] new_data;
    
    PIXEL_SENSOR(VBN1, RAMP, RESET, ERASE, EXPOSE, READ, DATA)
    

    DATA = PIXEL_SENSOR(VBN1, RAMP, RESET, ERASE, EXPOSE, READ, new_data)

    logic [7:0] matrix [0:1][0:1] */
    /* logic [7:0] pArr1 [0:1];
    logic [7:0] pArr2 [0:1]; */
  
    parameter real dv_pixel1 = 0.2;
    parameter real dv_pixel2 = 0.4;
    parameter real dv_pixel3 = 0.6;
    parameter real dv_pixel4 = 0.8;

    PIXEL_SENSOR #(.dv_pixel(dv_pixel1)) p1(VBN1, RAMP, RESET, ERASE, EXPOSE, READ1, DATA1);
    /* pArr1[0] = DATA1; */
    PIXEL_SENSOR #(.dv_pixel(dv_pixel2)) p2(VBN1, RAMP, RESET, ERASE, EXPOSE, READ2, DATA2);
    /* pArr1[1] = DATA2; */
    PIXEL_SENSOR #(.dv_pixel(dv_pixel3)) p3(VBN1, RAMP, RESET, ERASE, EXPOSE, READ1, DATA3);
    /* pArr2[0] = DATA3; */
    PIXEL_SENSOR #(.dv_pixel(dv_pixel4)) p4(VBN1, RAMP, RESET, ERASE, EXPOSE, READ2, DATA4);
    /* pArr2[1] = DATA4; */


endmodule

