
library(shiny)
library(shinythemes)
library(leaflet)
library(rnaturalearth)
library(maps)
library(shinydashboard)
library(shinydashboardPlus)
library(rsconnect)


 oceania <- ne_countries(continent = "Oceania", returnclass = "sf")
 nz <- ne_countries(country = "New Zealand", returnclass = "sf")
 nz_in_oceania <- nz[nz$name == "New Zealand", ]
 
 ui <- fluidPage(
   theme = shinytheme("united"),
   navbarPage(
     title = "New Zealand",
     tabPanel("General",
              div(style = "text-align: center;",
                  h1("Aotearoa: Land of the Long White Cloud"),
                  h2("New Zealand stands as a testament to diversity and natural 
                  allure. Embracing a population of approximately 5 million, this 
                  captivating country resonates with a rich tapestry of cultures 
                  and landscapes waiting to be explored. Comprising the majestic 
                  North and South Islands alongside smaller paradises in the vast 
                  Pacific, it showcases a harmonious blend of traditions. The 
                  traditional haka dance echoes the ancient Maori heritage, while 
                  the vibrant pulse of Auckland encapsulates a cosmopolitan fusion.

Agriculturally, New Zealand flourishes with an abundance of dairy, 
lamb, and world-renowned wines cultivated amidst verdant expanses. Beyond 
its culinary delights, the nation thrives in the realm of sports, with rugby, 
cricket, and netball capturing the nation's enthusiasm. Outdoor adventures
beckon amidst scenic vistas, from invigorating hikes to thrilling water sports.

Noteworthy is Wellington, the dynamic capital perched on the North Island's edge, 
serving as a vibrant hub for creativity, governance, and innovation.

New Zealand, with its symphony of culture, natural wonders, and 
the hospitable spirit of its people, invites exploration and promises an 
enriching experience for all who venture into its embrace.")
                  
              ),
              div(style = "text-align: center;",
                  img(src = "https://cdn.kimkim.com/files/a/content_articles/featured_photos/3117192df163b1c655a6081e58961533bd8e1afe/big-317a87546e8649aae22e694d77523453.jpg", width = "65%")
              ),
              fluidRow(
                column(width = 12,
                       align = "center",
                       tags$iframe(width = "30%",
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
                             width = "30%",
                             style = "display: block; margin: 0 auto;"
                           ),
                           img(
                             src = "https://www.cia.gov/the-world-factbook/static/d79ab0415f0ec4c4f9939b81275aa62c/15d60/NZ_popgraph2023.jpg",
                             width = "50%",
                             style = "display: block; margin: 0 auto;"
                           )
                         )
                ),
                tabPanel("SWOT",
                         div(
                           id = "swot_tabs_container",
                           # conditionalPanel(
                           #   condition = "input.swot_toggle %% 2 != 0",
                             tabsetPanel(
                               tabPanel("Strenghts", "New Zealand possesses several notable strengths. 
                                        The country's picturesque natural landscapes and rich biodiversity
                                        form a cornerstone for a thriving tourism industry. Moreover, its 
                                        robust agricultural sector, particularly in dairy and meat production, 
                                        stands as a significant economic driver. New Zealand is also recognized for 
                                        its stable political environment, efficient governance, and a pioneering 
                                        commitment to sustainability, positioning itself as a global leader in 
                                        eco-friendly policies."),
                               
                               tabPanel("Weaknesses", "Despite its strengths, New Zealand grapples with certain
                                        weaknesses. Its geographic isolation contributes to elevated transportation 
                                        costs and limits market access, posing challenges for international trade. 
                                        Furthermore, the economy's heavy reliance on agricultural exports exposes 
                                        vulnerability to fluctuations in global commodity prices. Diversification 
                                        beyond agriculture remains a pertinent challenge for sustained economic resilience."),
                               
                               tabPanel("Opportunities", "Opportunities abound for New Zealand's growth and advancement. 
                                        The country can capitalize on its potential in clean energy, technological innovation, 
                                        and diversification of its economy. Leveraging its thriving film industry, exemplified 
                                        by the success of the 'Lord of the Rings' series, offers an avenue to attract more 
                                        international investment and talent. Developing these sectors could pave the way for 
                                        increased economic dynamism and global competitiveness."),
                               
                               tabPanel("Threats", "Several threats loom over New Zealand's prospects. Environmental challenges, 
                                        particularly related to climate change, pose risks to agricultural productivity and natural 
                                        ecosystems. Additionally, the country's economic dependence on a few key industries and the 
                                        uncertainties prevailing in the global market landscape present threats to long-term
                                        stability. Addressing these challenges while seizing available opportunities will be
                                        crucial for New Zealand's sustained growth and resilience in the face of evolving global 
                                        dynamics.")
                             )
                           )
                )
     ),
     navbarMenu("Maps",
                tabPanel("New Zealand in Oceania",
                         leafletOutput("oceania_map")
                ),
                tabPanel("New Zealand in the World",
                         leafletOutput("world_map")
                )
     )
    )
   )
 )
     
 
 
 server <- function(input, output, session) {

   observeEvent(input$toggle_swot_tabs, {
     if (input$toggle_swot_tabs %% 2 == 0) {
       hide("swot_tabs_container")
     } else {
       show("swot_tabs_container")
     }
   })
   
   output$world_map <- renderLeaflet({
     world_map <- leaflet() |>
       addTiles() |>
       setView(lng = 174.885971, lat = -40.900557, zoom = 5) |>
       addPolygons(data = nz, color = "purple", weight = 2)
     world_map
   })
   
   output$oceania_map <- renderLeaflet({
     oceania_map <- leaflet() |>
       addTiles() |>
       setView(lng = 150, lat = -25, zoom = 3) |>
       addPolygons(data = oceania, color = "gray", fillOpacity = 0.2) |>
       addPolygons(data = nz_in_oceania, color = "red", weight = 2)
     oceania_map
   })
 }
 
 shinyApp(ui = ui, server = server)
 
          
          