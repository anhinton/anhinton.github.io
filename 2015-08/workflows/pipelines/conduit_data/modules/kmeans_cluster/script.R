data_frame <- readRDS("/home/ahin017/uoastorage/openapi/documentation/litreview/workflows/pipelines/conduit_data/modules/readCSV/data_frame.rds")
cluster <- kmeans(data_frame, 2)
saveRDS(cluster, file = "cluster.rds")
