#Author: Huan Chen
#Date: 10-2023

#! /bin/R

library(sf) #'simple features' package
library(leaflet) # web-embeddable interactive maps
library(ggplot2) # general purpose plotting
library(rnaturalearth) # map data
library(rnaturalearthdata)# map data
library(ggspatial) # scale bars and north arrows
library(rnaturalearthhires)# map data

theme_set(theme_bw())

#world <- ne_countries(scale="medium", returnclass = "sf")
selectedcou <- ne_countries(
  country = c('Canada','Greenland','Mexico','United States of America', #North America
              'Anguilla','Antigua and Barbuda','Aruba','Bahamas','Barbados','Bermuda','British Virgin Islands','Cayman Islands','Cuba','Curaçao','Dominica','Dominican Republic','Grenada','Guadeloupe','Haiti','Jamaica','Martinique','Montserrat','Puerto Rico','Saint Kitts and Nevis','Saint Lucia','Saint Vincent and the Grenadines','Trinidad and Tobago','US Virgin Islands',#Countries in the Caribbean
              'Belize','Costa Rica','El Salvador','Guatemala','Honduras','Nicaragua','	Panama',#Central America
              'Argentina','Bolivia','Brazil','Chile','Colombia','Ecuador','French','Guyana','Paraguay','Peru','Suriname','Uruguay','Venezuela'),#South America
  type="countries", scale='large', returnclass = "sf")
ggplot(data = selectedcou) + geom_sf()

#Adding titles and axis labels
ggplot(data = selectedcou) +
  geom_sf() +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("Test")

#Adding scale bars and a north arrow
ggplot(data = selectedcou) +
  geom_sf() +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("Test") +
  annotation_scale(location = "br", width_hint = 0.4) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         pad_x = unit(0.0, "in"), pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering)

data <- read.table("sample_location_info_2023.txt",header = T)
data_lat <- data$X_lat
data_lot <- data$Y_lon
locname <- data$Name
#Adding points to the map
#build my own data as the following:data_lat,data_lot and locname
#locname <-c(rep("Argentina",2),rep("Brazil",21),rep("Colombia",15),rep("Ecuador",4),rep("Guatemala",8),rep("Mexico",100),rep("Paraguay",1),rep("Peru",34),rep("USA",16))
#locname <-c(rep("A",2),rep("B",21),rep("C",15),rep("E",4),rep("G",8),rep("M",95),rep("Pa",1),rep("P",33),rep("USA",12))
locname
cols <- c(rep("salmon",2), #Z66,Z67
          rep("plum3",19), #modern Brazil
          rep("salmon",2), #Z2,Z6
          rep("salmon",2), #Arica4, Arica5
          rep("plum3",6), #modern Colombia
          rep("plum3",2), #modern Ecuador
          rep("olivedrab",4), #modern Guatemala
          rep("salmon",3), #Eg84, EG85, EG90
          rep("cyan3",60), #modern Mexico
          rep("salmon",3), #Tehuacan162, SM3, SM10
          rep("plum3",1), #Paraguay
          rep("plum3",23), #modern Peru
          rep("salmon",3), #Z61,Z64, Z65
          rep("cyan3",6), #modenr USA
          rep("plum3",3), #modern Bolivia
          rep("salmon",1)) #aBM found location)

city_data <- data.frame(city_name = locname)
city_data$lat <- data_lat#N or S; Y-axis
city_data$lon <- data_lot #W or E; X-axis

#draw samples on the whole size map
ggplot(data = selectedcou) +
  geom_sf() +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("Sample Location") +
  annotation_scale(location = "br", width_hint = 0.4) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         pad_x = unit(0.0, "in"), pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  geom_point(data = city_data, mapping = aes(x = lon, y = lat), 
             colour = cols, size = 0.5) +
  geom_text(data = city_data, mapping=aes(x=lon, y=lat, label= locname),nudge_y = 0.5, size = 0.5,color="black",
            show.legend = TRUE) + #"check_overlap = TRUE" Avoid overlaps 
  annotate("text", label = "USA",x = -180, y = 15, size = 2, colour = "red")


#draw your sample location and Zoom and Pan your map
ggplot(data = selectedcou) +
  geom_sf() +
  coord_sf(xlim = c(-172,-17), ylim = c(-55,82),expand = TRUE) +#ZOOM your map by setting X,Y value
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("") +
  annotation_scale(location = "bl", width_hint = 0.6) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.0, "in"), pad_y = unit(0.2, "in"),
                         style = north_arrow_fancy_orienteering) +
  geom_point(data = city_data, mapping = aes(x = lon, y = lat), colour = cols, size = 1) +
  geom_text(data = city_data, mapping=aes(x=lon, y=lat,label=locname), nudge_y = 0.5, vjust = 0, size = 2,color="black",
            show.legend = TRUE, check_overlap = FALSE) +
  annotate("text", label = "United States of America",x = -101, y = 40, size = 3, colour = "gray24") +
  annotate("text", label = "Mexico",x = -102, y = 24, size = 3, colour = "gray24") +
  annotate("text", label = "Peru",x = -82, y = -13, size = 3, colour = "gray24") +
  annotate("text", label = "Ecuador",x = -86, y = -1, size = 3, colour = "gray24") +
  annotate("text", label = "Guatemala",x = -103, y = 14, size = 3, colour = "gray24") +
  annotate("text", label = "Argentina",x = -64, y = -36, size = 3, colour = "gray24") +
  annotate("text", label = "Brazil",x = -55, y = -8, size = 3, colour = "gray24") +
  annotate("text", label = "Colombia",x = -67, y = 7, size = 3, colour = "gray24") +
  annotate("text", label = "Paraguay",x = -65, y = -22, size = 3, colour = "gray24") +
  annotate("text", label = "Chile",x = -75, y = -35, size = 3, colour = "gray24") +
  annotate("text", label = "Honduras",x = -75, y = 15, size = 3, colour = "gray24") +
  annotate("text", label = "Bolivia",x = -63, y = -15, size = 3, colour = "gray24")






