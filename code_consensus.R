library(tidyverse)
library(openxlsx)
library(ConsensusClusterPlus)
library(Publish)

dt <- read_csv('values.csv') 

d.mat <- dt %>% select(-c(1:2)) %>% t()

title <- 'output'

results = ConsensusClusterPlus(d.mat,maxK=10,reps=100,pItem=0.8, pFeature=1, 
                              title=title,clusterAlg="hc",distance="spearman",seed=123,plot='pdf')
# 
dt[, 1:2] %>% add_column(Group = results[[3]]$consensusClass,
.before = 1) %>% write_csv('group.csv')
