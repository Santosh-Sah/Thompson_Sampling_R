source("ThompsonSamplingUtils.R")
library(ggplot2)

#reading ThompsonSampling advertisement selected
thompsonSamplingAdvertisementSeleted <- readRDS("ThompsonSamplingAdvertisementSeleted.RDS")

#create histogram plot for the adertisment selected matrix which we get from ThompsonSampling algorithms
histogramOfThompsonSamplingAdvertisementSeleted <- function(ThompsonSamplingAdvertisementSeleted){
  
  png("ThompsonSamplingAdvertisementSeleted.png")
  
  hist(thompsonSamplingAdvertisementSeleted,
       col = 'blue',
       main = 'Histogram of ads selections',
       xlab = 'Ads',
       ylab = 'Number of times each ad was selected')
  
  
  dev.off()
  
}

histogramOfThompsonSamplingAdvertisementSeleted(thompsonSamplingAdvertisementSeleted)