

# ideas:
# - add tabs (overview/graphics/analysis & rawdata)
# - readme (in tab or in sidebar) so the dashboard is self-documented
# - githup repo einrichten

rm(list=ls())

here::i_am("global.r")

require(shiny)
require(shinydashboard)
require(tidyverse)
require(ggplot2)
require(lubridate)
require(patchwork)
require(trackeR) # https://cran.r-project.org/web/packages/trackeR/vignettes/TourDetrackeR.html
require(reshape2)
require(RColorBrewer)
require(cowplot)
require(FITfileR) 
require(ggthemes)
require(rStrava)
require(httr)
require(fresh)
require(patchwork)

kcal_per_cheeseburger <- 275


source("./import_bike_files.r")
source("./prep_bike_data.r")