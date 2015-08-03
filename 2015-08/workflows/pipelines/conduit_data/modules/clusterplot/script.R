data_frame <- readRDS("/home/ahin017/uoastorage/openapi/documentation/litreview/workflows/pipelines/conduit_data/modules/readCSV/data_frame.rds")
cluster <- readRDS("/home/ahin017/uoastorage/openapi/documentation/litreview/workflows/pipelines/conduit_data/modules/kmeans_cluster/cluster.rds")
library(lattice)
xyplot(data_frame$Number~data_frame$Age,
       groups = cluster$cluster, xlab = "Age", ylab = "Number", 
       main = "Scatterplot of kyphosis data")
