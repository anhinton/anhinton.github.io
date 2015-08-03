data_frame <- read.csv("data.csv")[,-1]
saveRDS(data_frame, file = "data_frame.rds")
