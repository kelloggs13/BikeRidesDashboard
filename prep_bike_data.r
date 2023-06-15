


df.calendar <- data.frame(Date=seq(as.Date('2023-05-01'), ceiling_date(Sys.Date(), unit = "week")-1, 1)) %>% 
  mutate( month = month(Date),
          year = year(Date),
          day = day(Date),
          week = isoweek(Date),
          dayofweek = wday(Date, week_start = 1, label = TRUE, locale = "en"),
          weekofmonth = ceiling((day(Date)- wday(Date)) / 7)
  ) 



df.plot.day <- left_join(df.calendar, strava.rides.day, by = "Date")  


plot.calendar.hm <- function(df, var, title, coltype){
  df %>% 
    ggplot(aes(week, reorder(dayofweek, desc(dayofweek)), fill = {{var}})) + 
    geom_tile(color ="grey") + 
    facet_wrap(~year, scales = "free", nrow = 2) + 
    { if(coltype == "disc") scale_fill_manual(values = c("#008B8B"), na.value = NA) } +
    { if(coltype == "cont") scale_fill_gradient(low = "lightblue", high = "darkblue", na.value = NA) } +
    scale_x_continuous("\nWeek", breaks = seq(0, 52, 1)) + 
    scale_y_discrete("Day of Week\n") + 
    theme_bw() +
    theme(legend.position = "none", panel.grid = element_blank()
          , strip.background = element_rect(fill="#AFEEEE")
          ) + 
    ggtitle(title)  
}

p.cal.ridedays <- plot.calendar.hm(df.plot.day, HasRun, title = "Days with Rides", "disc")

plot.timeseries <- function(df, var, col.line = "#008B8B", col.area = "#AFEEEE", title = ""){
  df %>% 
    ggplot(aes(Date, {{var}})) + 
    geom_area(fill = col.area, alpha = 1) +
    geom_line(linewidth = 0.5, col = col.line) +
    geom_point(size = 2, col = col.line) + 
    theme_bw() + 
    theme(panel.grid = element_blank()
          , axis.title = element_blank()
          ) + 
    ggtitle(title)
}

p.ts.distance <- plot.timeseries(strava.rides.day, distance, title = "Kilometers per Day")
p.ts.cheeseburgers <- plot.timeseries(strava.rides.day, cheeseburgers, title = "Cheeseburgers Burned per Day")

p.cal.ridedays <- ggplotly(p.cal.ridedays) 
p.ts.distance <- ggplotly(p.ts.distance)
p.ts.cheeseburgers <- ggplotly(p.ts.cheeseburgers)

vb_total_distance <- strava.rides.day %>% 
  summarise(vb_total_distance = sum(distance, na.rm = TRUE)) %>% 
  pull(vb_total_distance) %>% 
  round(0) 

vb_total_rides <- strava.rides.day %>% 
  filter(HasRun == 1) %>% 
  count() %>% 
  pull(n)

vb_total_cheeseburgers <- strava.rides %>% 
  summarise(cheeseburgers = sum(kilojoules) / kcal_per_cheeseburger) %>% 
  floor() %>% 
  pull(cheeseburgers)

t.lastride <- strava.rides %>% 
  arrange(start_date) %>% 
  tail(1) %>% 
  select(start_date) %>% 
  unite(lastride, sep = " -- ") %>% 
  pull(lastride) %>% 
  paste("Last Ride: ", .)
