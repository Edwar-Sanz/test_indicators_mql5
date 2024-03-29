#property copyright "Edwar-Sanz"
#property link      "https://github.com/Edwar-Sanz"
#property version   "1.00"



#property indicator_chart_window
#property indicator_buffers 5
#property indicator_plots   1

#property indicator_label1  "close"        // Nombre 
#property indicator_type1   DRAW_LINE      // tipo de linea
#property indicator_color1  clrTurquoise       // color de la linea
#property indicator_style1  STYLE_SOLID         // estilo de la linea
#property indicator_width1  1                   // grosor de la linea
//---------------------------------------------------------------------------------------------------------
input int periodos = 10;

double   closeBuffer        [];
double   close_capadoBuffer [];
double   copia_closeBuffer[];
//---------------------------------------------------------------------------------------------------------

int OnInit(){
   SetIndexBuffer(0, close_capadoBuffer ,INDICATOR_DATA);
   SetIndexBuffer(1, closeBuffer ,INDICATOR_CALCULATIONS);
   
   
   return(INIT_SUCCEEDED);
}

//------------------------------------------------------------------------------------------------------------------

int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[],
                const double &open[], const double &high[], const double &low[], const double &close[],
                const long &tick_volume[], const long &volume[], const int &spread[]){    
               
   
   for(int i=0; i < prev_calculated; i++){   
      if(i > periodos){
         
         ArrayCopy(closeBuffer, close,i-periodos, i-periodos, periodos);
            
         
         //copialos valores del array dinámico
         ArrayCopy(copia_closeBuffer, closeBuffer,0, i-periodos, periodos);
                
         //ordena el array
         ArraySort(copia_closeBuffer);
         
         
         
         // calculando cuartiles
         
         double index_q1 = MathCeil((48*periodos)/100);
         double index_q2 = MathCeil((50*periodos)/100);
         double index_q3 = MathCeil((52*periodos)/100);
         
         double q1 = copia_closeBuffer[(int)index_q1];
         double q2 = copia_closeBuffer[(int)index_q2];
         double q3 = copia_closeBuffer[(int)index_q3];
         
         //Print(q1, " ",q2, " ",q3);
         
         
         
         // calculando rango intercuartil
         
         double rango_intercuartil = q3 - q1;
         double k = 1.5;
         double out_range = rango_intercuartil * k;
         
         
         if(close[i] > (q3 + out_range) ){           
            close_capadoBuffer[i] = q3 + out_range;
         }else if(close[i] < (q1 - out_range) ){    
            close_capadoBuffer[i] = q1 - out_range;
         }else{
             close_capadoBuffer[i] = close[i];
         }
         
   
      }else{
         closeBuffer[i]=close[i];
      }
    }
      
   return(rates_total);
}



