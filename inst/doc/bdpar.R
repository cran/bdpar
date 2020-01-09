## ---- echo = TRUE, results = "hide"-------------------------------------------
library(R6)
library(pipeR)
library(readr)
ExtractorTytb <- R6Class(
  classname = "ExtractorTytb",
  inherit = Instance,
  public = list(
    initialize = function(path) {
      if (!"character" %in% class(path)) {
        stop("[ExtractorTytb][initialize][Error]
                Checking the type of the variable: path ",
                  class(path))
      }
      path %>>%
        super$initialize()
    },
    obtainDate = function() {
      "" %>>%
        super$setDate()
      return()
    },
    obtainSource = function() {
      super$getPath() %>>%
      read_file() %>>%
      super$setSource()
        
    super$getSource() %>>%
      super$setData()
    
      return()
    }
  )
)


## ---- echo = TRUE, results = "hide",ExtractorTytb-----------------------------
library(R6)
library(tools)
library(bdpar)
InstanceFactoryCustom <- R6Class(
  "InstanceFactoryCustom",
  public = list(
    initialize = function() {
    },
    createInstance = function(path) {
      if (!"character" %in% class(path)) {
        stop("[InstanceFactoryCustom][createInstance][Error]
                Checking the type of the variable: path ",
                  class(path))
      }
      switch(file_ext(path),
       `email` =  return(ExtractorEml$new(path)),
       `tytb` = return(ExtractorTytb$new(path))
      )
        
      return()
    }
  )
)

## ---- echo = TRUE, results = "hide"-------------------------------------------
library(R6)
library(pipeR)
library(stringr)
RemovesWhiteSpaces <- R6Class(
  "RemovesWhiteSpaces",
  inherit = PipeGeneric,
  public = list(
    initialize = function(propertyName = "",
                          alwaysBeforeDeps = list(),
                          notAfterDeps = list()) {
      if (!"character" %in% class(propertyName)) {
        stop("[RemovesWhiteSpaces][initialize][Error]
                Checking the type of the variable: propertyName ",
                  class(propertyName))
      }
      if (!"list" %in% class(alwaysBeforeDeps)) {
        stop("[RemovesWhiteSpaces][initialize][Error]
                Checking the type of the variable: alwaysBeforeDeps ",
                  class(alwaysBeforeDeps))
      }
      if (!"list" %in% class(notAfterDeps)) {
        stop("[RemovesWhiteSpaces][initialize][Error]
                Checking the type of the variable: notAfterDeps ",
                  class(notAfterDeps))
      }
      super$initialize(propertyName, alwaysBeforeDeps, notAfterDeps)
    },
    pipe = function(instance) {
      if (!"Instance" %in% class(instance)) {
        stop("[RemovesWhiteSpaces][pipe][Error]
                Checking the type of the variable: instance ",
                  class(instance))
      }
      instance$addFlowPipes("RemovesWhiteSpaces")
      if (!instance$checkCompatibility("RemovesWhiteSpaces", 
                                       self$getAlwaysBeforeDeps())) {
        stop("[RemovesWhiteSpaces][pipe][Error] Bad compatibility between
                                                Pipes.")
      }
      instance$addBanPipes(unlist(super$getNotAfterDeps()))
      instance$getData() %>>%
        stringr::str_trim() %>>%
        stringr::str_squish() %>>%
        instance$setData()
      
      return(instance)
    }
  )
)


## ---- echo = TRUE, results = "hide",RemovesWhiteSpaces------------------------
library(R6)
library(bdpar)
TestPipe <- R6Class(
  "TestPipe",
  inherit = TypePipe,
  public = list(
    initialize = function() {
    },
    pipeAll = function(instance) {
      if (!"Instance" %in% class(instance)) {
        stop("[TestPipe][pipeAll][Error]
             Checking the type of the variable: instance ",
             class(instance));
      }
      message("[TestPipe][pipeAll][Info] ", instance$getPath(), "\n")
      tryCatch(
        instance %>I%
          TargetAssigningPipe$new()$pipe() %>I%
          StoreFileExtensionPipe$new()$pipe() %>I%
          File2Pipe$new()$pipe() %>I%
          RemovesWhiteSpaces$new()$pipe() %>I%
          TeeCSVPipe$new()$pipe()
        ,
        error = function(e) {
          message("[TestPipe][pipeAll][Error]", 
              instance$getPath(),
              " :", 
              paste(e), 
              "\n")
          instance$invalidate()
        }
      )
      return(instance)
    }
  )
)

