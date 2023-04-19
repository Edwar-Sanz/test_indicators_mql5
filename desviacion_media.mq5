#property copyright "Edwar-Sanz"
#property link      "https://github.com/Edwar-Sanz"
#property version   "1.00"


#include <Math\Stat\Stat.mqh>

#property indicator_separate_window
#property indicator_buffers 5
#property indicator_plots   1
//---------------------------------------------------------------------------------------------------------
//--- tendence                        
#property indicator_label1  "tendence"          // Nombre 
#property indicator_type1   DRAW_LINE           // tipo de linea
#property indicator_color1  clrDodgerBlue       // color de la linea
#property indicator_style1  STYLE_SOLID         // estilo de la linea
#property indicator_width1  1                   // grosor de la linea
//---------------------------------------------------------------------------------------------------------

//inputs
input int                  periodos   = 5;
input ENUM_MA_METHOD       modo       = MODE_SMA;

//---------------------------------------------------------------------------------------------------------
double   dev_mediaBuffer[];
double   imaBuffer[];
int      handle_ima;
double   aux_array[];
//---------------------------------------------------------------------------------------------------------

int OnInit(){
   SetIndexBuffer(0, dev_mediaBuffer,INDICATOR_DATA);
   SetIndexBuffer(1, imaBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(2, aux_array,INDICATOR_CALCULATIONS);
   handle_ima = iMA(_Symbol,_Period,periodos,-1,modo,PRICE_CLOSE);
   
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){ 
   
   CopyBuffer(handle_ima, 0, 0, prev_calculated, imaBuffer);
   double d =  pow(10, -_Digits);    
   for(int i=0; i<prev_calculated; i++){
      if(i > periodos){      
         double contador = 0;
         for(int j=0; j<periodos;j++){
            aux_array[j] = MathAbs(close[i-periodos+j] - imaBuffer[i]);
            contador += aux_array[j];
         }
         dev_mediaBuffer[i] = MathRound(contador / periodos, _Digits);   
      }
   }
   return(rates_total);
}




