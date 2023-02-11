#include <MovingAverages.mqh>

#property indicator_separate_window
#property indicator_buffers 2
#property indicator_plots   2
//---------------------------------------------------------------------------------------------------------
//--- plot close_volatil                        
#property indicator_label1  "close_volatil"     // Nombre 
#property indicator_type1   DRAW_LINE           // tipo de linea
#property indicator_color1  clrDodgerBlue       // color de la linea
#property indicator_style1  STYLE_SOLID         // estilo de la linea
#property indicator_width1  1                   // grosor de la linea
//---------------------------------------------------------------------------------------------------------
//--- plot ma_close_v                        
#property indicator_label2  "ma_close_v"        // Nombre 
#property indicator_type2  DRAW_LINE           // tipo de linea
#property indicator_color2  clrYellow           // color de la linea
#property indicator_style2  STYLE_SOLID         // estilo de la linea
#property indicator_width2  1                   // grosor de la linea

//---------------------------------------------------------------------------------------------------------
double   close_volatilBuffer[];
double ma_close_vBuffer[];
int SimpleMAOnBuffer;

//---------------------------------------------------------------------------------------------------------

int OnInit(){
   SetIndexBuffer(0,close_volatilBuffer,INDICATOR_DATA);
   SetIndexBuffer(1, ma_close_vBuffer,INDICATOR_DATA);
   
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){

   
   int star = 0;
   if(prev_calculated != 0 ) star = prev_calculated - 1;
 
   

   for(int i=star; i<rates_total; i++){
      int m = i - 1;
      if(i > 0)
      Print("i= ", i," ", close[m]);
      close_volatilBuffer[i] = close[i] + (high[i] - low[i]);  
   }
   
   
   SimpleMAOnBuffer(rates_total,star, 0,30,close_volatilBuffer,ma_close_vBuffer);


   return(rates_total);
}

