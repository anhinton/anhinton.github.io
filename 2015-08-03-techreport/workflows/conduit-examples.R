library(conduit)

## basic example
conduit_base <- loadPipeline("conduit_base",
                             "conduit/conduit_base/pipeline.xml")
runPipeline(conduit_base)

## change data source
conduit_data <- loadPipeline("conduit_data",
                             "conduit/conduit_data/pipeline.xml")
runPipeline(conduit_data)

## alternative plotting
conduit_plot <- loadPipeline("conduit_plot",
                             "conduit/conduit_plot/pipeline.xml")
runPipeline(conduit_plot)
