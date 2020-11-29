source("data.R")
source("lasso_logistic_reg.R")
library(tidyverse)

# Visualization

# Top 30 positive and nagative words
plot(res %>%
       top_n(30, abs(coef)) %>%
       mutate(word = reorder(word, coef)) %>%
       head(30) %>%
       ggplot(aes(word, coef, fill = coef > 0)) +
       geom_col(show.legend = FALSE) +
       labs(y = "coef", x = "word") +
       theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
       coord_flip())

# Top 20 positive words
plot(res %>% 
       arrange(desc(coef)) %>% 
       head(20) %>%
       ggplot(aes(x=reorder(word,coef),y=coef,fill="red")) + 
       geom_col(show.legend = FALSE) + 
       labs(y = "coef", x = "word") + 
       theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
       coord_flip())



