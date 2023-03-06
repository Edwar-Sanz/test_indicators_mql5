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
double   highsBuffer[];
double   lowssBuffer[];
double maxi = 0;
double mini = 0;

input int periodos = 3;
//---------------------------------------------------------------------------------------------------------

int OnInit(){
 
   SetIndexBuffer(0, midBuffer,INDICATOR_DATA);
   SetIndexBuffer(1, highsBuffer,INDICATOR_CALCULATIONS);
   SetIndexBuffer(2, lowssBuffer,INDICATOR_CALCULATIONS);
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){  
  
      
   for(int i=0; i < rates_total; i++){   
      if(i > periodos){
         
         
         maxi = high[i];
         mini = low [i];
         
         for(int j=i-periodos; j < i; j++){
            if(high[j] > maxi){ maxi = high[j];}
            if(high[j] < maxi){ maxi = maxi   ;}
            if(low [j] < mini){ mini = low[j] ;}
            if(low [j] > mini){ mini = mini   ;}
         }
         
         midBuffer[i] = (maxi+mini)/2;
         maxi = 0;
         mini = 0;
      }
      
    }  
      
   return(rates_total);
}



