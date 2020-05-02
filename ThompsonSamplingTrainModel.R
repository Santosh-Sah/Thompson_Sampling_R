source("ThompsonSamplingUtils.R")

#reading dataset 
thompsonSamplingDataset = importThompsonSamplingDataset("Ads_CTR_Optimisation.csv")

set.seed(1234)

# Fitting ThompsonSampling to dataset
trainThompsonSampling <- function(thompsonSamplingDataset){
  
  #number of times the different advertisement shown to the users on the social media.
  N = 10000
  
  #number of version of the advertisement
  d = 10
  
  #different versions of advertisements selected
  advertisementsSelected = integer(0)
  
  #there are three steps present in the training of trainUpperConfidenceBound.
  #We are creating a model which used to select the best advertisement of a company.
  #step 1
  #the number of times the ad i got reward 1 up to round n
  #first is the number of times the ad i was selected up to round n
  #second is the number of times the ad i was selected up to round n
  numberOfRewards_1 = integer(d)
  numberOfRewards_0 = integer(d)
  totalRewards = 0
  
  #step 2
  #for each ad i we take a random draw from the distribution
  for (n in 1:N) {
   
    advertisementWithMaxRandom = 0
    
    maximumRandom = 0
    
    for (i in 1:d) {
      
      #generate the random draw for these 10 advertisement.
      #random draws from the beta distribution.
      randomBeta = rbeta(n = 1,
                         shape1 = numberOfRewards_1[i] + 1,
                         shape2 = numberOfRewards_0[i] + 1)
      
      #step 3
      #select the ad i that has the maximum upper confidence bound
      if (randomBeta > maximumRandom) {
        
        maximumRandom = randomBeta
        
        advertisementWithMaxRandom = i
        
      }
    }
    
    advertisementsSelected = append(advertisementsSelected, advertisementWithMaxRandom)
    
    #calculate rewards
    rewards = thompsonSamplingDataset[n, advertisementWithMaxRandom]
    
    #update numberOfRewards_1 and numberOfRewards_0
    if (rewards == 1) {
      
      numberOfRewards_1[advertisementWithMaxRandom] = numberOfRewards_1[advertisementWithMaxRandom] + 1
      
    } else{
      
      numberOfRewards_0[advertisementWithMaxRandom] = numberOfRewards_0[advertisementWithMaxRandom] + 1 
    }
    
    totalRewards = totalRewards + rewards 
  }
  
  returnList <- list(advertisementsSelected, totalRewards)
  
  return(returnList)
}


advertisementsSelected = trainThompsonSampling(thompsonSamplingDataset)[[1]]
totalRewards = trainThompsonSampling(thompsonSamplingDataset)[[2]] #total rewards is 2632

#saving advertisement selected 
saveThompsonSamplingAdvertisementSeleted(advertisementsSelected)

sink("advertisementsSelected.csv")
print(advertisementsSelected)
sink()