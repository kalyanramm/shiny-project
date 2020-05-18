
shinyServer(function(input, output){
  
  output$map <- renderGvis({
    
    df = 
      whr_df %>%
      filter(Year == input$year)
    
      gvisGeoChart(
        df,
        "Country",
        colorvar = "Happiness Score",
        options = list(
          projection = "kavrayskiy-vii",
          backgroundColor = "lightblue",
          width = "100%",
          height = "100%"
        )
      )
      
  })
  
  output$flag <- renderPlot({
    
    df = 
      whr_df %>% 
      filter(Country == input$country) %>% 
      tidyr::gather(key='factor', value='value', `Happiness Score`, `GDP Per Capita`, `Family`, `Health Life Expectancy`, `Freedom`,  `Perceptions Of Corruption`, `Generosity`)
    
    df %>% 
      ggplot(aes(x=Year, y =value, group=factor)) + 
      geom_line(aes(col=factor)) + 
      ylab('Contributing Factors')
    
  },
  height = 1000)
  
  output$factors <- renderPlot({
    
    df = 
      whr_df %>%
      select(Country,`Happiness Score`, Factor= eval(input$factor), Year)
    
    df %>% 
      ggplot(aes(x=`Happiness Score`, y=Factor)) +
      geom_point(aes(col=Country)) +
      geom_smooth(method = 'lm') +
      facet_wrap( ~ Year) + 
      ylab(input$factor) + 
      theme(legend.position = 'none')
    
  },
  height = 1000)
  
  output$table <- DT::renderDataTable({
    
    df = 
      whr_df %>%
      filter(Year == input$year) %>% 
      select("Country", "Happiness Rank", "Happiness Score", "GDP Per Capita", "Family", "Health Life Expectancy", "Freedom",  "Perceptions Of Corruption", "Generosity")
    
    datatable(df, rownames=FALSE) %>% 
      formatStyle("Country", background="skyblue", fontWeight='bold')
    
  })
  
  output$yearBox <- renderInfoBox({
    infoBox(input$year, icon = icon("calendar"))
  })
  
  output$countryBox <- renderInfoBox({
    infoBox(input$country, icon = icon("flag"))
  })
  
  output$factorBox <- renderInfoBox({
    infoBox(input$factor, icon = icon("certificate"))
  })
  
  output$maxBox <- renderInfoBox({
    max_value <- max(whr_df$`Happiness Score`[whr_df$Year == input$year])
    max_state <- 
      whr_df$Country[whr_df$`Happiness Score` == max_value & whr_df$Year == input$year]
    infoBox(max_state, max_value, icon = icon("hand-o-up"))
  })
  
  output$minBox <- renderInfoBox({
    min_value <- min(whr_df$`Happiness Score`[whr_df$Year == input$year])
    min_state <- 
      whr_df$Country[whr_df$`Happiness Score` == min_value & whr_df$Year == input$year]
    infoBox(min_state, min_value, icon = icon("hand-o-down"))
  })
})