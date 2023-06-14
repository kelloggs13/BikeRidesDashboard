
function(input, output, session) {

  output$vb_total_distance <- renderValueBox({vb_total_distance})
  output$vb_total_rides <- renderValueBox({vb_total_dvb_total_ridesistance})
  output$vb_total_cheeseburgers <- renderValueBox({vb_total_cheeseburgers})
  
  output$p.all <- renderPlot({p.all})
  
  output$t.lastride <- renderText({t.lastride})

}

