

mytheme <- create_theme(
  adminlte_color(
    light_blue = "#434C5E"
  ),
  adminlte_global(
    content_bg = "#FFF",
    box_bg = "#FFF", 
    info_box_bg = "#FFF"
  )
)

dashboardPage(skin = "black",
              

                    dashboardHeader(title = "", disable = TRUE),
                    dashboardSidebar(div(style='border: 0px solid grey; margin:15px;',
                                         h1("Bike Riding Data"),
                                         includeMarkdown("readme.md")
                                         )
                                     ),
                    dashboardBody(
                      
                      use_theme(mytheme),
                      
                      tags$style(".small-box.bg-green { background-color: #AFEEEE !important; color: #008B8B !important; }"),
                      
                      fluidRow(
                        column(4, h4(strong('Number of Days with Rides'))),
                        column(4, h4(strong('Total Kilometers'))),
                        column(4, h4(strong(paste("Total Number of Cheeseburgers Burned (1 Cheeseburger =" ,kcal_per_cheeseburger ,"kCal)"))))
                      ),
                      
                      fluidRow(
                        valueBox(vb_total_rides, '', color = "green"),
                        valueBox(vb_total_distance, '', color = "green"),
                        valueBox(vb_total_cheeseburgers, '', color = "green")
                      ),
      
                      fluidRow(
                        column(6,
                               plotlyOutput('p.cal.ridedays', height = 800)
                         ),
                        column(6,
                               plotlyOutput('p.ts.distance', height = 400), 
                               plotlyOutput('p.ts.cheeseburgers', height = 400)
                               )
                        ),
                      br(),
                      br(),
                      fluidRow(column(12, span(textOutput('t.lastride'), style="color:grey")))
                    )
              )

