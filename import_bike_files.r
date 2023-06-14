



httr::config(token = strava_oauth("BikeRideDashboard",
                                  "108841",
                                  "dd5edb16a11718bf5086264c2eac255e969059a8",
                                  app_scope = "activity:read_all", 
                                  cache = TRUE
                                  )
             )


strava.activities <- get_activity_list(strava_oauth("BikeRideDashboard",
                                                    "108841",
                                                    "dd5edb16a11718bf5086264c2eac255e969059a8",
                                                    app_scope = "activity:read_all", 
                                                    cache = TRUE
                                                    )
                                       ) 

strava.rides <- compile_activities(strava.activities)

strava.rides <- strava.rides %>% 
  mutate(Date = lubridate::as_date(start_date_local)
         , HasRun = ifelse(!is.na(athlete.id), 1, 0)
         )



strava.rides.day <- strava.rides %>% 
  group_by(Date) %>% 
  summarise(HasRun = factor(max(HasRun))
            , distance = sum(distance)
            , average_watts = median(average_watts)
            , kilocal = sum(kilojoules)
            ) %>% 
  mutate(cheeseburgers = floor(kilocal / kcal_per_cheeseburger))

