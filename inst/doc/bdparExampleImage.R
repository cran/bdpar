## ----echo = TRUE, results = "hide", eval = FALSE------------------------------
#  library(bdpar)
#  library(imager)

## ----echo = TRUE, results = "hide", eval = FALSE------------------------------
#  library(R6)
#  ExtractorImage <- R6Class(
#  
#    classname = "ExtractorImage",
#  
#    inherit = Instance,
#  
#    public = list(
#      initialize = function(path) {
#        super$initialize(path)
#      },
#      obtainSource = function() {
#        source <- imager::load.image(super$getPath())
#        super$setSource(source)
#        super$setData(source)
#      }
#    )
#  )

## ----echo = TRUE, results = "hide", eval = FALSE------------------------------
#  extractors <- ExtractorFactory$new()
#  extractors$registerExtractor(extension = "png", extractor = ExtractorImage)

## ----echo = TRUE, results = "hide", eval = FALSE------------------------------
#  library(R6)
#  Image2Pipe <- R6Class(
#    "Image2Pipe",
#    inherit = GenericPipe,
#    public = list(
#      initialize = function(propertyName = "",
#                            alwaysBeforeDeps = list(),
#                            notAfterDeps = list()) {
#        super$initialize(propertyName, alwaysBeforeDeps, notAfterDeps)
#      },
#      pipe = function(instance) {
#        instance$obtainSource()
#        instance
#      }
#    )
#  )
#  
#  ImageCroppingPipe <- R6Class(
#    "ImageCroppingPipe",
#    inherit = GenericPipe,
#    public = list(
#      initialize = function(propertyName = "",
#                            alwaysBeforeDeps = list(),
#                            notAfterDeps = list()) {
#        super$initialize(propertyName, alwaysBeforeDeps, notAfterDeps)
#      },
#      pipe = function(instance) {
#        data <- instance$getData()
#        data <- imager::imsub(data, x > height/2)
#        instance$setData(data)
#        instance
#      }
#    )
#  )
#  
#  ImageResizePipe <- R6Class(
#    "ImageResizePipe",
#    inherit = GenericPipe,
#    public = list(
#      initialize = function(propertyName = "",
#                            alwaysBeforeDeps = list(),
#                            notAfterDeps = list()) {
#        super$initialize(propertyName, alwaysBeforeDeps, notAfterDeps)
#      },
#      pipe = function(instance) {
#        data <- instance$getData()
#        data <- imager::imrotate(data, 30)
#        instance$setData(data)
#        instance
#      }
#    )
#  )
#  

## ----echo = TRUE, results = "hide", eval = FALSE------------------------------
#  pipeline <- DynamicPipeline$new(pipeline = list(Image2Pipe$new(),
#                                                  ImageCroppingPipe$new(),
#                                                  ImageResizePipe$new()))

## ----echo = TRUE, results = "hide", eval = FALSE------------------------------
#  runPipeline(path = "imageExample/parrots.png",
#              extractors = extractors,
#              pipeline = pipeline,
#              cache = FALSE,
#              verbose = FALSE,
#              summary = FALSE)
#  

