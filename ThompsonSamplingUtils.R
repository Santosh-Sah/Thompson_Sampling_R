importThompsonSamplingDataset <- function(thompsonSamplingDatasetFileName) {
  
  #getting ThompsonSampling dataset
  thompsonSamplingDataset = read.csv(thompsonSamplingDatasetFileName)
  
  return (thompsonSamplingDataset)
  
}

#Save ThompsonSampling advertisement selection
saveThompsonSamplingAdvertisementSeleted <- function(thompsonSamplingAdvertisementSeleted) {
  
  saveRDS(thompsonSamplingAdvertisementSeleted, file = "ThompsonSamplingAdvertisementSeleted.RDS")
}