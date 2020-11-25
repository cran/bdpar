## ---- echo = TRUE, results = "hide"-------------------------------------------
library(R6)
ExtractorTytb <- R6Class(
  classname = "ExtractorTytb",
  inherit = Instance,
  public = list(
    initialize = function(path) {
      if (!"character" %in% class(path)) {
        stop("[ExtractorTytb][initialize][Error] ",
             "Checking the type of the variable: path ",
             class(path))
      }
      super$initialize(path)
    },
    obtainDate = function() {
      super$setDate(file.info(super$getPath())[["ctime"]])
    },
    obtainSource = function() {
      super$setSource(readLines(super$getPath(), 
                                warn = FALSE))
      super$setData(super$getSource())
    }
  )
)

## ---- echo = TRUE, results = "hide",ExtractorTytb-----------------------------
library(bdpar)
extractors <- ExtractorFactory$new()
extractors$registerExtractor("tytb", ExtractorTytb)

## ---- echo = TRUE, results = "hide"-------------------------------------------
library(R6)
RemovesWhiteSpaces <- R6Class(
  "RemovesWhiteSpaces",
  inherit = GenericPipe,
  public = list(
    initialize = function(propertyName = "",
                          alwaysBeforeDeps = list(),
                          notAfterDeps = list()) {
      if (!"character" %in% class(propertyName)) {
        stop("[RemovesWhiteSpaces][initialize][Error] ",
             "Checking the type of the 'propertyName' variable: ",
             class(propertyName))
      }
      if (!"list" %in% class(alwaysBeforeDeps)) {
        stop("[RemovesWhiteSpaces][initialize][Error] ",
             "Checking the type of the 'alwaysBeforeDeps' variable: ",
             class(alwaysBeforeDeps))
      }
      if (!"list" %in% class(notAfterDeps)) {
        stop("[RemovesWhiteSpaces][initialize][Error] ",
             "Checking the type of the 'notAfterDeps' variable: ",
             class(notAfterDeps))
      }
      super$initialize(propertyName, alwaysBeforeDeps, notAfterDeps)
    },
    pipe = function(instance) {
      if (!"Instance" %in% class(instance)) {
        stop("[RemovesWhiteSpaces][pipe][Error] ",
             "Checking the type of the 'instance' variable: ",
             class(instance))
      }
      instance$setData(trimws(x = instance$getData()))
      
      if (length(instance$getData()) == 0) {
        instance$invalidate()
      }
      
      return(instance)
    }
  )
)


## ---- echo = TRUE, results = "hide", RemovesWhiteSpaces-----------------------
library(R6)
library(bdpar)
TestPipeline <- R6Class(
  "TestPipeline",
  inherit = GenericPipeline,
  public = list(
    initialize = function() {
    },
    execute = function(instance) {
      if (!"Instance" %in% class(instance)) {
        stop("[TestPipeline][execute][Error] ",
             "Checking the type of the 'instance' variable: ",
             class(instance))
      }
      message("[TestPipeline][execute][Info] ", instance$getPath())
      tryCatch(
        instance %>|%
          TargetAssigningPipe$new() %>|%
          StoreFileExtPipe$new() %>|%
          File2Pipe$new() %>|%
          RemovesWhiteSpaces$new() %>|%
          TeeCSVPipe$new()
        ,
        error = function(e) {
          message("[TestPipeline][execute][Error]", instance$getPath(), " :", paste(e))
          instance$invalidate()
        }
      )
      return(instance)
    }
  )
)

## ---- echo = TRUE, results = "hide"-------------------------------------------
library(bdpar)
pipeline <- DynamicPipeline$new()
pipeline$add(list(TargetAssigningPipe$new(),StoreFileExtPipe$new(),File2Pipe$new()), pos = NULL)
pipeline$add(list(TeeCSVPipe$new()), pos = NULL)

