#include <MovingAverages.mqh>

#property indicator_separate_window
#property indicator_buffers 2
#property indicator_plots   2
//---------------------------------------------------------------------------------------------------------
//--- plot vela_angle                        
#property indicator_label1  "vela_angle"        // Nombre 
#property indicator_type1   DRAW_HISTOGRAM      // tipo de linea
#property indicator_color1  clrDodgerBlue       // color de la linea
#property indicator_style1  STYLE_SOLID         // estilo de la linea
#property indicator_width1  1                   // grosor de la linea
//---------------------------------------------------------------------------------------------------------
//--- plot ma_v_angle                        
#property indicator_label2  "ma_v_angle"        // Nombre 
#property indicator_type2  DRAW_LINE           // tipo de linea
#property indicator_color2  clrYellow           // color de la linea
#property indicator_style2  STYLE_SOLID         // estilo de la linea
#property indicator_width2  1                   // grosor de la linea

//---------------------------------------------------------------------------------------------------------
double   vela_angleBuffer[];
double ma_v_angleBuffer[];
int SimpleMAOnBuffer;

//---------------------------------------------------------------------------------------------------------

int OnInit(){
   SetIndexBuffer(0,vela_angleBuffer,INDICATOR_DATA);
   SetIndexBuffer(1, ma_v_angleBuffer,INDICATOR_DATA);
   
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){

   
   int star = 0;
   if(prev_calculated != 0 ) star = prev_calculated - 1;
 
   

   for(int i=star; i<rates_total; i++){
      if(i > 0){
      
      double cateto = 100;
      double digitos =  pow(10, _Digits);
      double puntos = (close[i] * digitos) - (open[i] * digitos); 
      string tm = TimeToString(time[i],TIME_MINUTES);

         if (tm <= "16:30" || tm >= "22:30"){ 
            vela_angleBuffer[i] = 0;
         }else{
            vela_angleBuffer[i] = ((MathArctan(puntos / cateto) * 180) / 3.14);   
         }
      } 
   }
   
   
   SimpleMAOnBuffer(rates_total,star, 0, 3, vela_angleBuffer, ma_v_angleBuffer);


   return(rates_total);
}

