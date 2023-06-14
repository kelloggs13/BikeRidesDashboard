
function(input, output, session) {

  output$vb_total_distance <- renderValueBox({vb_total_distance})
  output$vb_total_rides <- renderValueBox({vb_total_dvb_total_ridesistance})
  output$vb_total_cheeseburgers <- renderValueBox({vb_total_cheeseburgers})
  
  output$p.cal.ridedays <- renderPlotly({p.cal.ridedays})
  output$p.ts.distance <- renderPlotly({p.ts.distance})
  output$p.ts.cheeseburgers <- renderPlotly({p.ts.cheeseburgers})
  output$p.ts.cheeseburgers2 <- renderPlotly({p.ts.cheeseburgers})
  
  output$t.lastride <- renderText({t.lastride})

}

