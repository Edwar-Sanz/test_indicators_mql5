cerrar todas las posiciones

int i = PositionsTotal() - 1;
   if( i > 0){
      while (i >= 0) {
         trade.PositionClose(PositionGetTicket(i));
         i--;   
      } 
   }
