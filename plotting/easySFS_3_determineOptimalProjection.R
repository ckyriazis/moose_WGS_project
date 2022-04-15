library(dplyr)
library(ggplot2)
library(purrr) # for map
library(reshape2)
library(readr)
library(tidyr)

## these files are the result of easySFS_2_parseProjection
data.dir="/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SFS/projection/data"
plot.dir="/Users/christopherkyriazis/Documents/UCLA/Moose/Analysis/SFS/projection/plots"

file <- "IR.neutral.NC_037328.1"

# get list of files:
fileList=list.files(pattern=paste(file,sep=""),path = data.dir,full.names = F )
fileList
data1 <- data_frame(filename = fileList) %>% # create a data frame
  # holding the file names
  mutate(file_contents = map(filename,          # read files into
                             ~ read_delim(delim=",",file.path(data.dir, .)))# a new data column 
         
  )  


data <- unnest(data1)
data$population <-  sapply(strsplit(as.character(data$filename),"\\."),'[',1)

maxima <- data %>%
  group_by(population) %>%
  filter(snps==max(snps))



p0 <- ggplot(data,aes(x=projection,y=snps))+
  geom_point()+
  facet_wrap(~population,scales="free_x")+
  theme_bw()+
  scale_x_continuous(breaks=seq(2,80,2))
p0
# want to find the maximum # of snps that still has sample size >10
ggsave(paste(plot.dir,"/easySFS.projections.",file,".pdf",sep=""),p0,height=5,width=10)
