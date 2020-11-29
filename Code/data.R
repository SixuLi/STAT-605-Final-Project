library(dplyr)
library(ggplot2)
library(stringr)
#library(lubridate)
#library(tidytext)
library(DT)
#library(leaflet)
library(textcat)
#library(forcats)
#library(pacman)
library(tm)
library(SnowballC)
library(glmnet)
#library(jsonlite)
library(caret)
rm(list = ls())

movies_reviews <- read.csv('movies_data.csv')


# Transform the target reviews to corpus
movies_reviews_corpus <- VCorpus(VectorSource(movies_reviews$review.text))
# Change to lower case
movies_reviews_corpus <- tm_map(movies_reviews_corpus,
                                   content_transformer(tolower))
# Remove numbers
movies_reviews_corpus <- tm_map(movies_reviews_corpus,
                                   removeNumbers)
# Remove stop words
movies_reviews_corpus <- tm_map(movies_reviews_corpus,
                                   removeWords,
                                   c("the", "and", stopwords("english")))
# Strip Whitespace
movies_reviews_corpus <- tm_map(movies_reviews_corpus,
                                   stripWhitespace)
# Remove punctuation
movies_reviews_corpus <- tm_map(movies_reviews_corpus,
                                   removePunctuation)

inspect(movies_reviews_corpus[1])

# Change to Document-Term Matrix (DTM) representation:
# documents as the rows, terms/words as the columns

# tf base
movies_reviews_dtm <- DocumentTermMatrix(movies_reviews_corpus)
movies_reviews_dtm

inspect(movies_reviews_dtm[1:10, 1:10])

# Reduce the dimension of DTM
movies_reviews_dtm <- removeSparseTerms(movies_reviews_dtm, 0.99)
movies_reviews_dtm

findFreqTerms(movies_reviews_dtm, 1000)

# tf-idf base
movies_reviews_dtm_tfidf <- DocumentTermMatrix(movies_reviews_corpus,
                                        control = list(weighting = weightTfIdf))
movies_reviews_dtm_tfidf <- removeSparseTerms(movies_reviews_dtm_tfidf, 0.99)
movies_reviews_dtm_tfidf

inspect(movies_reviews_dtm_tfidf[1, 1:20])

# Obtain binary variable
movies_reviews <- movies_reviews %>% 
  mutate(label = as.factor(ifelse(review.score >= 4, 1, 0)))

# Change tibble to dataframe
data <- as.data.frame(movies_reviews)
data <- data[-c(1:10)]
#data <- cbind(data, as.matrix(movies_reviews_dtm_tfidf))

# Split training and test data
split_data <- function(data) {
  set.seed(628)
  id_train <- createDataPartition(data$label, p=0.8,list=FALSE)
  
  data_train <- data[id_train,]
  data_test <- data[-id_train,]
  
  return(list(data_train, data_test))
}

# data_total <- split_data(data)
# data_train <- data_total[[1]]
# data_test <- data_total[[2]]


# Use Bigram
BigramTokenizer <- function(x) {
    unlist(lapply(ngrams(words(x), 1:2), paste, collapse = " "), use.names = FALSE)
}

tdm <- DocumentTermMatrix(movies_reviews_corpus, control = list(tokenize = BigramTokenizer,
                                                                weighting = weightTfIdf))
inspect(tdm)
tdm <- removeSparseTerms(tdm, 0.998)
inspect(tdm)
inspect(tdm[1, 1:10])

data_bigram <- cbind(data, as.matrix(tdm))

# Split training and test data
data_total <- split_data(data_bigram)
data_train <- data_total[[1]]
data_test <- data_total[[2]]





