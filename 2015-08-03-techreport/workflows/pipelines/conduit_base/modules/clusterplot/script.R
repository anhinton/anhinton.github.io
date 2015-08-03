data_frame <- readRDS("/home/ahin017/uoastorage/openapi/documentation/litreview/workflows/pipelines/conduit_base/modules/readCSV/data_frame.rds")
cluster <- readRDS("/home/ahin017/uoastorage/openapi/documentation/litreview/workflows/pipelines/conduit_base/modules/kmeans_cluster/cluster.rds")
library(lattice)
xyplot(data_frame$Sepal.Width~data_frame$Sepal.Length,
       groups = cluster$cluster, xlab = "sepal length", ylab = "sepal width", 
       main = "Scatterplot of iris data")
