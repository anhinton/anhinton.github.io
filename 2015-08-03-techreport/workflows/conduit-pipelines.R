library(conduit)

iris_csv <- module(
    "iris_csv",
    language = "R",
    description = "Hack module to provide CSV file to a pipeline. Development version of conduit could not handle these properly as at 2015-06-19. Source script is empty for similar reasons. \n\n Absolute file path to iris.csv will need to be altered from machine to machine",
    sources = list(
        moduleSource(scriptVessel(""))),
    outputs = list(
        moduleOutput(
            "iris_csv",
            fileVessel(normalizePath("iris.csv")),
            ioFormat("CSV file"))))
# runModule(iris_csv)

readCSV <- module(
    "readCSV",
    language = "R",
    inputs = list(
        moduleInput(
            "data.csv",
            fileVessel(normalizePath("data.csv")),
            ioFormat("CSV file"))),
    sources = list(
        moduleSource(
            scriptVessel("data_frame <- read.csv(\"data.csv\")[,-5]"))),
    outputs = list(
        moduleOutput(
            "data_frame",
            internalVessel("data_frame"),
            ioFormat("R data frame"))))
# runModule(readCSV, list(data.csv = normalizePath("iris.csv")))

kmeans_cluster <- module(
    "kmeans_cluster",
    language = "R",
    inputs = list(
        moduleInput(
            "data_frame",
            internalVessel("data_frame"),
            ioFormat("R data frame"))),
    sources = list(
        moduleSource(scriptVessel(
            "cluster <- kmeans(data_frame, 3)"))),
    outputs = list(
        moduleOutput(
            "cluster",
            internalVessel("cluster"),
            ioFormat("R kmeans object"))))
## runModule(kmeans_cluster,
##           list(data_frame = "/home/ashley/uoastorage/openapi/documentation/litreview/workflows/modules/readCSV/data_frame.rds"))

clusterplot <- module(
    "clusterplot",
    language = "R",
    inputs = list(
        moduleInput(
            "data_frame",
            internalVessel("data_frame"),
            ioFormat("R data frame")),
        moduleInput(
            "cluster",
            internalVessel("cluster"),
            ioFormat("R kmeans object"))),
    sources = list(
        moduleSource(
            scriptVessel(
                c("library(lattice)",
                  "xyplot(data_frame$Sepal.Width~data_frame$Sepal.Length,
       groups = cluster$cluster, xlab = \"sepal length\", ylab = \"sepal width\", 
       main = \"Scatterplot of iris data\")")))),
    outputs = list(
        moduleOutput(
            "Rplots.pdf",
            fileVessel("Rplots.pdf"),
            ioFormat("PDF file"))))

conduit_base <- pipeline(
    "conduit_base",
    modules = list(iris_csv, readCSV, kmeans_cluster, clusterplot),
    pipes = list(
        pipe("iris_csv", "iris_csv", "readCSV", "data.csv"),
        pipe("readCSV", "data_frame", "kmeans_cluster", "data_frame"),
        pipe("readCSV", "data_frame", "clusterplot", "data_frame"),
        pipe("kmeans_cluster", "cluster", "clusterplot", "cluster")))
## runPipeline(conduit_example)
exportPipeline(conduit_base, "conduit")

### conduit_plot example

scattermatrix <- module(
    "scattermatrix",
    language = "R",
    inputs = list(
        moduleInput(
            "data_frame",
            internalVessel("data_frame"),
            ioFormat("R data frame"))),
    sources = list(
        moduleSource(
            scriptVessel("pairs(data_frame)"))),
    outputs = list(
        moduleOutput(
            "Rplots.pdf",
            fileVessel("Rplots.pdf"),
            ioFormat("PDF file"))))

conduit_plot <- pipeline(
    "conduit_plot",
    modules = list(iris_csv, readCSV, scattermatrix),
    pipes = list(
        pipe("iris_csv", "iris_csv", "readCSV", "data.csv"),
        pipe("readCSV", "data_frame", "scattermatrix", "data_frame")))

## runPipeline(conduit_plot)

exportPipeline(conduit_plot, "conduit")

### conduit_data example

kyphosis_csv <- module(
    "kyphosis_csv",
    language = "R",
    description = "Hack module to provide CSV file to a pipeline. Development version of conduit could not handle these properly as at 2015-06-19. Source script is empty for similar reasons. \n\n Absolute file path to iris.csv will need to be altered from machine to machine",
    sources = list(
        moduleSource(scriptVessel(""))),
    outputs = list(
        moduleOutput(
            "kyphosis_csv",
            fileVessel(normalizePath("kyphosis.csv")),
            ioFormat("CSV file"))))
## runModule(kyphosis_csv)

readCSV <- module(
    "readCSV",
    language = "R",
    inputs = list(
        moduleInput(
            "data.csv",
            fileVessel("data.csv"),
            ioFormat("CSV file"))),
    sources = list(
        moduleSource(
            scriptVessel("data_frame <- read.csv(\"data.csv\")[,-1]"))),
    outputs = list(
        moduleOutput(
            "data_frame",
            internalVessel("data_frame"),
            ioFormat("R data frame"))))
## runModule(readCSV, list(data.csv = normalizePath("kyphosis.csv")))

kmeans_cluster <- module(
    "kmeans_cluster",
    language = "R",
    inputs = list(
        moduleInput(
            "data_frame",
            internalVessel("data_frame"),
            ioFormat("R data frame"))),
    sources = list(
        moduleSource(scriptVessel(
            "cluster <- kmeans(data_frame, 2)"))),
    outputs = list(
        moduleOutput(
            "cluster",
            internalVessel("cluster"),
            ioFormat("R kmeans object"))))
## runModule(kmeans_cluster,
##           list(data_frame = "/home/ashley/uoastorage/openapi/documentation/litreview/workflows/modules/readCSV/data_frame.rds"))

clusterplot <- module(
    "clusterplot",
    language = "R",
    inputs = list(
        moduleInput(
            "data_frame",
            internalVessel("data_frame"),
            ioFormat("R data frame")),
        moduleInput(
            "cluster",
            internalVessel("cluster"),
            ioFormat("R kmeans object"))),
    sources = list(
        moduleSource(
            scriptVessel(
                c("library(lattice)",
                  "xyplot(data_frame$Number~data_frame$Age,
       groups = cluster$cluster, xlab = \"Age\", ylab = \"Number\", 
       main = \"Scatterplot of kyphosis data\")")))),
    outputs = list(
        moduleOutput(
            "Rplots.pdf",
            fileVessel("Rplots.pdf"),
            ioFormat("PDF file"))))

conduit_data <- pipeline(
    "conduit_data",
    modules = list(kyphosis_csv, readCSV, kmeans_cluster, clusterplot),
    pipes = list(
        pipe("kyphosis_csv", "kyphosis_csv", "readCSV", "data.csv"),
        pipe("readCSV", "data_frame", "kmeans_cluster", "data_frame"),
        pipe("readCSV", "data_frame", "clusterplot", "data_frame"),
        pipe("kmeans_cluster", "cluster", "clusterplot", "cluster")))

runPipeline(conduit_data)

exportPipeline(conduit_data, "conduit")
