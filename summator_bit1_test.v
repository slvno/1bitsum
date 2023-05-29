 
 module summator_bit1_test;

wire number0, number1;

reg
// reset, 
clk, wr;

//Выходные данные
wire [1:0] w_data;
reg [1:0]wdata;
wire w_data_calculated;
reg data_calculated;

reg [1:0] counter;

//устанавливаем экземпляр тестируемого модуля
summator_bit1 #(.serial_number(123456789)) summator1bit ( 
  // объявление входных портов или входов
  .input_number0(number0), .input_number1(number1), 
  //.input_reset(reset),
  .input_clk(clk),
  //Разрешение подсчета
  .input_write_enabled(wr),  
  // объявление выходных портов или выходов
  
    
  .output_bit1(w_data[1]), 
  .output_bit2(w_data[0]),
  .output_calculated(w_data_calculated)
  ); 
  
assign number0 = counter[0];
assign number1 = counter[1];

//моделируем сигнал тактовой частоты
always
  #10 begin
      clk = ~clk;
  
      if (wr == 1'b0)
	  begin
	   if (counter == 2'b00) 
	     counter <= 2'b01;
       else if (counter == 2'b01) 
	     counter <= 2'b10;
       else if (counter == 2'b10) 
	     counter <= 2'b11;
	   else if (counter == 2'b11) 
	     counter <= 2'b00;
       else  
	     counter <= 2'b00;
	   
	   wr <= 1'b1;	
	  end
	  
	  if (w_data_calculated == 0)
	    begin
	      $display("summator_bit1_test (%d): %d", summator1bit.serial_number , w_data);
	      wdata <= w_data;
	      if (wr == 1'b1)
          wr <= 1'b0;	  
        end	 
	 end
/*
always @(posedge w_data_calculated)
  begin
	   $display("summator_bit1_test (%d): %d", summator1bit.serial_number , w_data);
	   wdata <= w_data;
	   if (wr == 1'b1)
         wr <= 1'b0;	  
    end	 
	*/
//от начала времени...

initial
begin
  clk = 0;
  //reset = 0;
  wr = 1'b0;
  counter = 2'b00;
  
//через временной интервал "50" подаем сигнал сброса
  //#50 reset = 1;

//еще через время "4" снимаем сигнал сброса

  //#10 reset = 0;

//пауза длительностью "50"
  #50;

//ждем фронта тактовой частоты и сразу после нее подаем сигнал записи
  @(posedge clk)
  #0
    begin 	  
      //wr = 1'b1;
    end

//по следующему фронту снимаем сигнал записи
  @(posedge clk)
  #0
    begin
      //wr = 1'b0;
    end
 /*
  @(posedge data_calculated)
  #0
    begin
	   $display("Summator (1 bit %d): %d", summator1bit.serial_number , w_data);
	   wdata <= w_data;
      //wr = 1'b0;
	  
    end
  */
  
end

//заканчиваем симуляцию в момент времени "400"
initial
begin
  #400 $finish;
end

//создаем файл VCD для последующего анализа сигналов
initial
begin
  $dumpfile("out.vcd");
  $dumpvars(0,summator_bit1_test);
end

//наблюдаем на некоторыми сигналами системы
initial
$monitor($stime,, clk,,, number0, number1,, wdata,, wr,, w_data_calculated);

endmodule

