install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
library(shiny)
library(shinythemes)
library(leaflet)
library(rnaturalearth)
library(maps)
library(shinydashboard)
library(shinydashboardPlus)

 oceania <- ne_countries(continent = "Oceania", returnclass = "sf")
 nz <- ne_countries(country = "New Zealand", returnclass = "sf")
 nz_in_oceania <- nz[nz$name == "New Zealand", ]

 ui <- fluidPage(theme = shinytheme("united"),
                 navbarPage(
                   title = "New Zealand",
                   tabPanel("General",
                            div(style = "text-align: center;",
                                h1("Aotearoa: Land of the Long White Cloud"),
                                h2("New Zealand, an enthralling haven, stands as a testament to diversity and natural allure. Embracing a population of approximately 5 million, this captivating country resonates with a rich tapestry of cultures and landscapes waiting to be explored. Comprising the majestic North and South Islands alongside smaller paradises in the vast Pacific, it showcases a harmonious blend of traditions. The traditional haka dance echoes the ancient Maori heritage, while the vibrant pulse of Auckland encapsulates a cosmopolitan fusion.

Agriculturally, New Zealand flourishes with an abundance of creamy dairy, succulent lamb, and world-renowned wines cultivated amidst verdant expanses. Beyond its culinary delights, the nation thrives in the realm of sports, with rugby, cricket, and netball capturing the nation's enthusiasm. Outdoor adventures beckon amidst scenic vistas, from invigorating hikes to thrilling water sports.

Noteworthy is Wellington, the dynamic capital perched on the North Island's edge, serving as a vibrant hub for creativity, governance, and innovation.

New Zealand, with its symphony of culture, natural wonders, and the hospitable spirit of its people, invites exploration and promises an enriching experience for all who venture into its embrace.")
                            ),
                            div(style = "text-align: center;",
                                img(src = "https://cdn.kimkim.com/files/a/content_articles/featured_photos/3117192df163b1c655a6081e58961533bd8e1afe/big-317a87546e8649aae22e694d77523453.jpg", width = "65%")
                            ),
                            fluidRow(
                              column(width = 12,
                                     align = "center",
                                     tags$iframe(width = "560", height = "315",
                                                 src = "https://www.youtube.com/embed/hhfZ0hvrhmA?autoplay=1",
                                                 frameborder = "0", allowfullscreen = TRUE)
                              )
                            )
                   ),
                   navbarMenu("About",
                              tabPanel("Key Demographics",
                                       div(
                                         style = "text-align: center;",
                                         h1("Key Demographics"),
                                         img(
                                           src = "https://www.stats.govt.nz/assets/Uploads/Subnational-population-estimates/Subnational-population-estimates-At-30-June-2023/Download-data/EEP-change-by-regional-council-30-June-2023.png",
                                           width = "80%",
                                           style = "display: block; margin: 0 auto;"
                                         ),
                                       )
                              ),
                   ),
                   navbarMenu("Maps",
                              tabPanel("New Zealand"),
                              tabPanel("New Zealand in Oceania",
                                       leafletOutput("oceania_map")
                              ),
                              tabPanel("New Zealand in the World",
                                       leafletOutput("world_map")
                              )
                   )
                 ),
 )
 
 
 server <- function(input, output) {
   output$world_map <- renderLeaflet({
     world_map <- leaflet() %>%
       addTiles() %>%
       setView(lng = 174.885971, lat = -40.900557, zoom = 5) %>%
       addPolygons(data = nz, color = "red", weight = 2)
     world_map
   })
   
   output$oceania_map <- renderLeaflet({
     oceania_map <- leaflet() %>%
       addTiles() %>%
       setView(lng = 150, lat = -25, zoom = 3) %>%
       addPolygons(data = oceania, color = "gray", fillOpacity = 0.2) %>%
       addPolygons(data = nz_in_oceania, color = "red", weight = 2)
     oceania_map
   })
 }
 
 shinyApp(ui = ui, server = server)
          
          