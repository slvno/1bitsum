module summator_bit1
#(parameter serial_number = 0)
( 
  // объявление входных портов или входов
  input wire input_number0, input_number1, 
  //input wire input_reset,
  input wire input_clk,
  //
  input wire input_write_enabled,  
  // объявление выходных портов или выходов
  
    
  output reg output_bit1, 
             output_bit2,
			 output_calculated
  ); 
  
 //объявление внутренней цепи, необходимой для работы
 // схемы и не являющейся входным/выходным портом
 wire bit1, bit0;  
 
 reg r_calculated;
 wire w_calculated;
 
 assign bit1 = (input_number0 & input_number1);
 assign bit0 = (!(input_number0 & input_number1)) & (input_number0 | input_number1);
 assign w_calculated = r_calculated; 
 
 always @ (posedge input_clk //or posedge input_reset
 )
 begin
	/*
	if (input_reset)
	    begin
	      output_bit1 <= 1'bX;
		  output_bit2 <= 1'bX;
		  r_calculated  <= 0;		  		    
		  
		  $display("Reset (summator 1 bit %d): %b %b", serial_number, output_bit1, output_bit2);
	    end
    else   */
	if(input_write_enabled)
        begin		
          output_bit1 <= bit1;
		  output_bit2 <= bit0;
		  
		  r_calculated <= 1;  
		  output_calculated <= w_calculated;  
		  
          $display("summator 1 bit %d: Writte enabled, input=%b%b, output=%b%b", serial_number , input_number0, input_number1, output_bit1, output_bit2);
        end
    else
        begin
		  //Рабочий цикл
		  //if (!w_calculated)
		  //    begin
		  //	    output_bit1 <= 1'bX;
		  //      output_bit2 <= 1'bX;
		  //	  end
			  
		  //output_calculated = w_calculated;  
		  output_bit1 <= 1'bX;
		  output_bit2 <= 1'bX;
		  r_calculated <= 0;  
		  output_calculated <= r_calculated;  		

		  //$display("Summ (summator 1 bit %d): %b %b", serial_number ,output_bit1, output_bit2);
		end 
end

endmodule 
