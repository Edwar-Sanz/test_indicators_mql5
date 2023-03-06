#property copyright "Edwar-Sanz"
#property link      "https://github.com/Edwar-Sanz"
#property version   "1.00"


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
input int                  back       = 3;
input int                  periodos   = 20;
input ENUM_MA_METHOD       modo       = MODE_EMA;
input ENUM_APPLIED_PRICE   aplicado_a = PRICE_WEIGHTED;
//---------------------------------------------------------------------------------------------------------
double   tendenceBuffer[];
double   imaBuffer[];
int      handle_ima;

//---------------------------------------------------------------------------------------------------------

int OnInit(){
   SetIndexBuffer(0, tendenceBuffer,INDICATOR_DATA);
   SetIndexBuffer(1, imaBuffer,INDICATOR_DATA);
   handle_ima = iMA(_Symbol,_Period,periodos,0,modo,aplicado_a);
   
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){

   
   
   CopyBuffer(handle_ima, 0, 0, rates_total, imaBuffer);
   double d =  pow(10, -_Digits);
   
   
   for(int i=0; i<rates_total; i++){
      if(i > back + 1){
      
         if(imaBuffer[i] - imaBuffer[i - back] > 0){
            tendenceBuffer[i] = 1;   
         }else{
            tendenceBuffer[i] = -1;
         }
       
                      
      
      } 
   } 
   

   return(rates_total);
}




