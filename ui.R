
shinyUI(dashboardPage(
  dashboardHeader(titleWidth = 0),
  dashboardSidebar(
    img(src="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQmhewfATjoPTRIIP5YEVrIfi-xrLnvWkcsQD7SsU9wn4w7OgIm&usqp=CAU", 
        width="100%", height="75%"),
    sidebarMenu(
      menuItem("Map", tabName = "map", icon = icon("map")),
      menuItem("Country", tabName = "flag", icon = icon("flag")),
      menuItem("Contributing Factors", tabName = "factors", icon = icon("certificate")),
      menuItem("Data", tabName = "data", icon = icon("database"))
    ),
    selectizeInput("year",
                   "Select Year",
                   years),
    selectizeInput("country",
                   "Select Country",
                   countries),
    selectizeInput("factor",
                   "Select Factor",
                   factors)
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tabItems(
      tabItem(tabName = "map",
              fluidRow(infoBoxOutput("yearBox"),
                       infoBoxOutput("maxBox"),
                       infoBoxOutput("minBox")),
              fluidRow(box(htmlOutput("map"), width = "100%"))),
      tabItem(tabName = "flag",
              fluidRow(infoBoxOutput("countryBox")),
              fluidRow(box(plotOutput("flag"), width = "100%", height = 600))),
      tabItem(tabName = "factors",
              fluidRow(infoBoxOutput("factorBox")),
              fluidRow(box(plotOutput("factors"), width =  "100%", height = 300))),
      tabItem(tabName = "data",
              fluidRow(box(DT::dataTableOutput("table"), width = "100%", height = "600")))
    )
  )
))