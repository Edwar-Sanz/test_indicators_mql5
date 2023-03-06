#property copyright "Edwar-Sanz"
#property link      "https://github.com/Edwar-Sanz"
#property version   "1.00"


#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   1
//---------------------------------------------------------------------------------------------------------
//--- plot vela_power                        
#property indicator_label1  "mid"        // Nombre 
#property indicator_type1   DRAW_LINE      // tipo de linea
#property indicator_color1  clrDodgerBlue       // color de la linea
#property indicator_style1  STYLE_SOLID         // estilo de la linea
#property indicator_width1  1                   // grosor de la linea
//---------------------------------------------------------------------------------------------------------

//inputs
input int muestra = 10;
input int suavizado = 200;
input int shift = 0;
//---------------------------------------------------------------------------------------------------------
double   midBuffer[];
double   imaBuffer[];
int      handle_ima;

//---------------------------------------------------------------------------------------------------------

int OnInit(){
   SetIndexBuffer(0, midBuffer,INDICATOR_DATA);
   SetIndexBuffer(1, imaBuffer,INDICATOR_DATA);
   handle_ima = iMA(_Symbol,_Period,suavizado,shift,MODE_SMA,PRICE_TYPICAL);
   
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){

   
   
   CopyBuffer(handle_ima, 0, 0, rates_total, imaBuffer);
   double d =  pow(10, -_Digits);
   
   int date_1 = muestra + muestra;
   int date_2 = date_1 + date_1;
   int date_3 = (date_2 + date_2 + date_1)*2;
   int date_4 = (date_3 + date_3)*2;
   
   for(int i=0; i<rates_total; i++){
      if(i > date_4 + 1){
   
      
      midBuffer[i] = (imaBuffer[i] +
                      imaBuffer[i-date_1] + 
                      imaBuffer[i-date_2] + 
                      imaBuffer[i-date_3] + 
                      imaBuffer[i-date_4])/5 ;
      
      } 
   } 
   

   return(rates_total);
}




