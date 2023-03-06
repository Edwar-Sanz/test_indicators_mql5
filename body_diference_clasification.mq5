#property copyright "Edwar-Sanz"
#property link      "https://github.com/Edwar-Sanz"
#property version   "1.00"


#property indicator_separate_window
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
double d =  pow(10, _Digits);
double   midBuffer[];
double sum = 0;

input int entre = 10;
input int periodos = 3;
//---------------------------------------------------------------------------------------------------------

int OnInit(){
   
   SetIndexBuffer(0, midBuffer,INDICATOR_DATA);
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){  
  
      
   for(int i=0; i < rates_total; i++){   
      if(i > periodos){
         
         
         sum = 0;

         for(int j=i-periodos; j < i; j++){
            sum = sum + (close[j] - open[j]);
         }
         
         if((sum*d) > entre ){ midBuffer[i] = 1;};
         if((sum*d) < entre && (sum*d) > (entre*-1)){ midBuffer[i] = 0;};
         if((sum*d) < (entre*-1)){ midBuffer[i] = -1;};
         
         
         
         sum = 0;
        
      }
      
    }  
      
   return(rates_total);
}



