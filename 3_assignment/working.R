ggg <- read.csv('3_assignment/ggg.csv')
library(tidyverse)
library(plotly)

ggg <- ggg %>% 
  rename('erupt' = "Number.of.significant.volcanic.eruptions..NGDC.WDS.")


ggg %>% group_by(Code) %>% summarize(eruptions = sum(erupt))



# make state borders red
borders <- list(color = toRGB("red"))
# Set up some mapping options
map_options <- list(
  scope = 'world',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

plot_ly(z=volcanoes$eruptions, text = volcanoes$Entity, locations = volcanoes$Code,
        type = 'choropleth', locationmode = 'world',
        color = volcanoes$eruptions, colors = 'Blues', marker = list(line = borders)) %>% 
  layout(title = 'US Population in 1975', geo=map_options)


plot_ly(type='choropleth', 
        locations=volcanoes$Code, 
        z=volcanoes$eruptions, 
        text=volcanoes$Entity, 
        colorscale="rdylbu" ) %>% 
  layout(title = "Significant Volcanic Eruptions since 1900 (by Country) ") %>%  
  add_annotations( 
    text='Source: National Geophysical Data Center / World Data Service (NGDC/WDS): NCEI/WDS Global Significant Volcanic Eruptions Database. NOAA National Centers for Environmental Information. doi:10.7289/V5JW8BSH',
    xref='x domain',
    x=0.5,
    yref='y domain',
    y=-0.5,
    font = list(size=10)
  )




>   add_annotations( gg,
                     +     showarrow=False,
                     +     text='Source: National Geophysical Data Center / World Data Service (NGDC/WDS): NCEI/WDS Global Significant Volcanic Eruptions Database. NOAA National Centers for Environmental Information. doi:10.7289/V5JW8BSH',
                     +     font=dict(size=10), 
                     +     xref='x domain',
                     +     x=0.5,
                     +     yref='y domain',
                     +     y=-0.5
                     +   )
