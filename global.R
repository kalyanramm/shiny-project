library(dplyr)
library(ggplot2)
library(DT)
library(shiny)
library(shinydashboard)
library(googleVis)


whr_df = read.csv('./data/data.csv', stringsAsFactors = FALSE)
colnames(whr_df) = c("X", "Country", "Happiness Rank", "Happiness Score", "GDP Per Capita", "Family", "Health Life Expectancy", "Freedom",  "Perceptions Of Corruption", "Generosity", "Year")

countries = sort(unique(whr_df$Country))
years = sort(unique(whr_df$Year))
factors = sort(colnames(whr_df)[5:10])