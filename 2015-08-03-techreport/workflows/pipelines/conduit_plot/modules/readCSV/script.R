data_frame <- read.csv("data.csv")[,-5]
saveRDS(data_frame, file = "data_frame.rds")
