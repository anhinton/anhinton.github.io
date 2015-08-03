data_frame <- readRDS("/home/ahin017/uoastorage/openapi/documentation/litreview/workflows/pipelines/conduit_base/modules/readCSV/data_frame.rds")
cluster <- kmeans(data_frame, 3)
saveRDS(cluster, file = "cluster.rds")
