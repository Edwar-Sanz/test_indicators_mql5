#property copyright "Edwar-Sanz"
#property link      "https://github.com/Edwar-Sanz"
#property version   "1.00"


#property indicator_chart_window
#property indicator_buffers 5
#property indicator_plots   1
//---------------------------------------------------------------------------------------------------------
//--- hi_lo_meanBuffer                        
#property indicator_label1  "hi_lo_meanBuffer"  // Nombre 
#property indicator_type1   DRAW_LINE          // tipo de linea
#property indicator_color1  clrDodgerBlue       // color de la linea
#property indicator_style1  STYLE_SOLID         // estilo de la linea
#property indicator_width1  1                   // grosor de la linea
//---------------------------------------------------------------------------------------------------------

double   midBuffer[];

//---------------------------------------------------------------------------------------------------------

int OnInit(){
 
   SetIndexBuffer(0, midBuffer,INDICATOR_DATA);
   
   
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){  
  
      double higher = 0;
      double lower  = 0;
      
      for(int i=0;   i<rates_total;   i++){
         if(i > 0){
                   
            string current_Time = TimeToString(time[i],   TIME_DATE);
            string pass_current = TimeToString(time[i-1], TIME_DATE);
            
            
            int    bar_shif      = iBarShift(_Symbol, PERIOD_D1, time[i] - 86400);
            double high_last_day = iHigh    (_Symbol, PERIOD_D1, bar_shif );
            double low_last_day  = iLow     (_Symbol, PERIOD_D1, bar_shif );
            double mid_last_day = (high_last_day + low_last_day)/2;
            
            // Si es el mismo dia
            if(current_Time == pass_current){
             
               if(high[i] > higher){ higher = high[i]; }
               if(low [i] < lower ){ lower  = low [i]; }
               
               midBuffer[i] = ((((higher + lower)/2) + mid_last_day) / 2);
                                  
            // Si pasa el dia 
            }else{
                     
               midBuffer[i] = ((((higher + lower)/2) + mid_last_day) / 2);            
               higher = high[i];
               lower  = low [i];
            }
         }   
      }
      
      
      
   return(rates_total);
}



