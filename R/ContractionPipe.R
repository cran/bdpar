#
# Bdpar provide a tool to easily build customized data flows to pre-process
# large volumes of information from different sources. To this end, bdpar allows
# to (i) easily use and create new functionalities and (ii) develop new data
# source extractors according to the user needs. Additionally, the package
# provides by default a predefined data flow to extract and preprocess the most
# relevant information (tokens, dates, ... ) from some textual sources (SMS,
# email, tweets, YouTube comments).
#
# Copyright (C) 2018 Sing Group (University of Vigo)
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/gpl-3.0.html>

#' @title Class to find and/or replace the contractions on the data field of a Instance
#'
#' @description \code{\link{ContractionPipe}} class is responsible for detecting
#' the existing contractions in the \strong{data} field of each \code{\link{Instance}}.
#' Identified contractions are stored inside the \strong{contraction} field of
#' \code{\link{Instance}} class. Moreover if needed, is able to perform inline
#' contractions replacement.
#'
#' @docType class
#'
#' @format NULL
#'
#' @section Constructor:
#' \preformatted{
#' ContractionsPipe$new(propertyName = "contractions",
#'                      propertyLanguageName = "language",
#'                      alwaysBeforeDeps = list("GuessLanguagePipe"),
#'                      notAfterDeps = list())
#' }
#' \itemize{
#' \item{\emph{Arguments:}}{
#' \itemize{
#' \item{\strong{propertyName:}}{
#' (\emph{character}) name of the property associated with the Pipe.
#' }
#' \item{\strong{propertyLanguageName:}}{
#' (\emph{character}) name of the language property.
#' }
#' \item{\strong{alwaysBeforeDeps:}}{
#' (\emph{list}) the dependences alwaysBefore (Pipes that must be executed before this
#' one).
#' }
#' \item{\strong{notAfterDeps:}}{
#' (\emph{list}) the dependences notAfter (Pipes that cannot be executed after this one).
#' }
#' }
#' }
#' }
#'
#' @section Details:
#' \code{\link{ContractionPipe}} class requires the resource files (in json format)
#' containing the correspondence between contractions and meaning. To this end,
#' the language of the text indicated in the \emph{propertyLanguageName} should
#' be contained in the resource file name (ie. contr.xxx.json where xxx is the
#' value defined in the \emph{propertyLanguageName} ). The location of the
#' resources should defined in the \emph{resourcesPath} section of the
#' configuration file.
#'
#' \strong{[resourcesPath]}
#'
#' resourcesContractionsPath = \emph{<<resources_contractions_path>>}
#'
#' @section Note:
#' \code{\link{ContractionPipe}} will automatically invalidate the
#' \code{\link{Instance}} whenever the obtained data is empty.
#'
#' @section Inherit:
#' This class inherits from \code{\link{PipeGeneric}} and implements the
#' \code{pipe} abstract function.
#'
#' @section Methods:
#' \itemize{
#' \item{\bold{pipe:}}{
#' preprocesses the \code{\link{Instance}} to obtain/replace the contractions.
#' The contractions found in the Pipe are added to the list of properties of
#' the \code{\link{Instance}} If the \code{replaceContractions} parameter is TRUE,
#' the \code{\link{Instance}} data will be modified by replacing the contractions found.
#' \itemize{
#' \item{\emph{Usage:}}{
#' \code{pipe(instance, replaceContractions = TRUE)}
#' }
#' \item{\emph{Value:}}{
#' the \code{\link{Instance}} with the modifications that have occurred in the Pipe.
#' }
#' \item{\emph{Arguments:}}{
#' \itemize{
#' \item{\strong{instance:}}{
#' (\emph{Instance}) \code{\link{Instance}} to preproccess.
#' }
#' \item{\strong{replaceContractions:}}{
#' (\emph{logical}) indicates if the contractions are replace or not.
#' }
#' }
#' }
#' }
#' }
#'
#' \item{\bold{findContraction:}}{
#' checks if the contractions is in the data.
#' \itemize{
#' \item{\emph{Usage:}}{
#' \code{findContraction(data, contraction)}
#' }
#' \item{\emph{Value:}}{
#' boolean, depending on whether the contraction is on the data.
#' }
#' \item{\emph{Arguments:}}{
#' \itemize{
#' \item{\strong{data:}}{
#' (\emph{character}) text where contraction will be searched.
#' }
#' \item{\strong{contraction:}}{
#' (\emph{character}) indicates the contraction to find.
#' }
#' }
#' }
#' }
#' }
#'
#' \item{\bold{replaceContraction:}}{
#' replaces the contraction in the data for the \emph{extendedContraction}.
#' \itemize{
#' \item{\emph{Usage:}}{
#' \code{replaceContraction(contraction, extendedContraction, data)}
#' }
#' \item{\emph{Value:}}{
#' the data with the contractions replaced.
#' }
#' \item{\emph{Arguments:}}{
#' \itemize{
#' \item{\strong{contraction:}}{
#' (\emph{character}) indicates the contraction to remove.
#' }
#' \item{\strong{extendedContraction:}}{
#' (\emph{character}) indicates the string to replace for the contraction found.
#' }
#' \item{\strong{data:}}{
#' (\emph{character}) text where contraction will be replaced.
#' }
#' }
#' }
#' }
#' }
#'
#' \item{\bold{getPropertyLanguageName:.}}{
#' gets of name of property language.
#' \itemize{
#' \item{\emph{Usage:}}{
#' \code{getPropertyLanguageName()}
#' }
#' \item{\emph{Value:}}{
#' value of name of property language.
#' }
#' }
#' }
#'
#' \item{\bold{getResourcesContractionsPath:}}{
#' gets of path of contractions resources.
#' \itemize{
#' \item{\emph{Usage:}}{
#' \code{getResourcesContractionsPath()}
#' }
#' \item{\emph{Value:}}{
#' value of path of contractions resources.
#' }
#' }
#' }
#'
#' \item{\bold{setResourcesContractionsPath:}}{
#' sets the path of contractions resources.
#' \itemize{
#' \item{\emph{Usage:}}{
#' \code{setResourcesContractionsPath(path)}
#' }
#' \item{\emph{Arguments:}}{
#' \itemize{
#' \item{\strong{path:}}{
#' (\emph{character}) the new value of the path of contractions resources.
#' }
#' }
#' }
#' }
#' }
#' }
#'
#' @section Private fields:
#' \itemize{
#' \item{\bold{propertyLanguageName:}}{
#'  (\emph{character}) the name of property about language.
#' }
#' \item{\bold{resourcesContractionsPath:}}{
#'  (\emph{character}) the path where are the resources.
#' }
#' }
#'
#' @seealso \code{\link{AbbreviationPipe}}, \code{\link{File2Pipe}},
#'          \code{\link{FindEmojiPipe}}, \code{\link{FindEmoticonPipe}},
#'          \code{\link{FindHashtagPipe}}, \code{\link{FindUrlPipe}},
#'          \code{\link{FindUserNamePipe}}, \code{\link{GuessDatePipe}},
#'          \code{\link{GuessLanguagePipe}}, \code{\link{Instance}},
#'          \code{\link{InterjectionPipe}}, \code{\link{MeasureLengthPipe}},
#'          \code{\link{PipeGeneric}}, \code{\link{ResourceHandler}},
#'          \code{\link{SlangPipe}}, \code{\link{StopWordPipe}},
#'          \code{\link{StoreFileExtPipe}}, \code{\link{TargetAssigningPipe}},
#'          \code{\link{TeeCSVPipe}}, \code{\link{ToLowerCasePipe}}
#'
#' @keywords NULL
#'
#' @import ini pipeR R6 rlist
#' @export ContractionPipe

ContractionPipe <- R6Class(

  "ContractionPipe",

  inherit = PipeGeneric,

  public = list(

    initialize = function(propertyName = "contractions",
                          propertyLanguageName = "language",
                          alwaysBeforeDeps = list("GuessLanguagePipe"),
                          notAfterDeps = list()) {

      if (!requireNamespace("rex", quietly = TRUE)) {
        stop("[ContractionPipe][initialize][Error]
                Package \"rex\" needed for this class to work.
                  Please install it.",
                    call. = FALSE)
      }

      if (!requireNamespace("textutils", quietly = TRUE)) {
        stop("[ContractionPipe][initialize][Error]
                Package \"textutils\" needed for this class to work.
                  Please install it.",
                    call. = FALSE)
      }

      if (!"character" %in% class(propertyName)) {
        stop("[ContractionPipe][initialize][Error]
                Checking the type of the variable: propertyName ",
                  class(propertyName))
      }

      if (!"character" %in% class(propertyLanguageName)) {
        stop("[ContractionPipe][initialize][Error]
                Checking the type of the variable: propertyLanguageName ",
                  class(propertyLanguageName))
      }

      if (!"list" %in% class(alwaysBeforeDeps)) {
        stop("[ContractionPipe][initialize][Error]
                Checking the type of the variable: alwaysBeforeDeps ",
                  class(alwaysBeforeDeps))
      }
      if (!"list" %in% class(notAfterDeps)) {
        stop("[ContractionPipe][initialize][Error]
                Checking the type of the variable: notAfterDeps ",
                  class(notAfterDeps))
      }

      super$initialize(propertyName, alwaysBeforeDeps, notAfterDeps)

      private$propertyLanguageName <- propertyLanguageName

      private$resourcesContractionsPath <- read.ini(Bdpar[["private_fields"]][["configurationFilePath"]])$resourcesPath$resourcesContractionsPath

    },

    pipe = function(instance, replaceContractions = TRUE) {

      if (!"Instance" %in% class(instance)) {
        stop("[ContractionPipe][pipe][Error]
                Checking the type of the variable: instance ",
                  class(instance))
      }

      if (!"logical" %in% class(replaceContractions)) {
        stop("[ContractionPipe][pipe][Error]
                Checking the type of the variable: replaceContractions ",
                  class(replaceContractions))
      }

      instance$addFlowPipes("ContractionPipe")

      if (!instance$checkCompatibility("ContractionPipe", self$getAlwaysBeforeDeps())) {
        stop("[ContractionPipe][pipe][Error] Bad compatibility between Pipes.")
      }

      instance$addBanPipes(unlist(super$getNotAfterDeps()))

      languageInstance <- "Unknown"

      languageInstance <- instance$getSpecificProperty( self$getPropertyLanguageName())

      # If the language property is not found, the instance can not be preprocessed
      if (is.null(languageInstance) ||
          is.na(languageInstance) ||
          "Unknown" %in% languageInstance) {

        instance$addProperties(list(),super$getPropertyName())

        warning("[ContractionPipe][pipe][Warning] ",
                "The file: " , instance$getPath() ," has not language property\n")

        return(instance)

      }

      JsonFile <- paste(self$getResourcesContractionsPath(),
                        "/contr.",
                        languageInstance,
                        ".json",
                        sep = "")

      jsonData <- Bdpar[["private_fields"]][["resourceHandler"]]$isLoadResource(JsonFile)
      #It is verified that there is a resource associated to the language of the instance
      if (!is.null(jsonData)) {

        #Variable which stores the contractions located in the data
        contractionsLocated <- list()

        for (contraction in names(jsonData)) {

          if (self$findContraction(instance$getData(), contraction)) {

            contractionsLocated <- list.append(contractionsLocated,
                                               contraction)
          }

          if (replaceContractions && contraction %in% contractionsLocated) {

            instance$getData() %>>%
              {self$replaceContraction(contraction,
                                        as.character(jsonData[contraction]),
                                        .)} %>>%
                textutils::trim() %>>%
                  instance$setData()
          }
        }

        instance$addProperties(paste(contractionsLocated),
                               super$getPropertyName())

      } else {

        instance$addProperties(list(),super$getPropertyName())

        warning("[ContractionPipe][pipe][Warning] ",
                "The file: " , instance$getPath() , " has not an contractionsJsonFile ",
                "to apply to the language ->", languageInstance, " \n")

        return(instance)
      }

      if (is.na(instance$getData()) ||
          all(instance$getData() == "") ||
          is.null(instance$getData())) {

        message <- c( "The file: " , instance$getPath() , " has data empty on pipe Contractions")

        instance$addProperties(message, "reasonToInvalidate")

        warning("[ContractionPipe][pipe][Warning] ", message, " \n")

        instance$invalidate()

        return(instance)
      }

      return(instance)
    },

    findContraction = function(data, contraction) {

      if (!"character" %in% class(data)) {
        stop("[ContractionPipe][findContraction][Error]
                Checking the type of the variable: data ",
                  class(data))
      }

      if (!"character" %in% class(contraction)) {
        stop("[ContractionPipe][findContraction][Error]
                Checking the type of the variable: contraction ",
                  class(contraction))
      }

      contractionEscaped <- rex::escape(contraction)

      regularExpresion <- paste0("(?:[[:space:]]|[\"><\u00A1?\u00BF!;:,.'-]|^)(",
                                 contractionEscaped,
                                 ")[;:?\"!,.'>-]?(?=(?:[[:space:]]|$|>))",
                                 sep = "")

      return(grepl(pattern = rex::regex(regularExpresion), x = data, perl = TRUE, ignore.case = TRUE))
    },

    replaceContraction = function(contraction, extendedContraction, data) {

      if (!"character" %in% class(contraction)) {
        stop("[ContractionPipe][replaceContraction][Error]
                Checking the type of the variable: contraction ",
                  class(contraction))
      }

      if (!"character" %in% class(extendedContraction)) {
        stop("[ContractionPipe][replaceContraction][Error]
                Checking the type of the variable: extendedContraction ",
                  class(extendedContraction))
      }

      if (!"character" %in% class(data)) {
        stop("[ContractionPipe][replaceContraction][Error]
                Checking the type of the variable: data ",
                  class(data))
      }

      contractionEscaped <- rex::escape(contraction)

      regularExpresion <- paste0("(?:[[:space:]]|[\"><\u00A1?\u00BF!;:,.'-]|^)(",
                                 contractionEscaped,
                                 ")[;:?\"!,.'>-]?(?=(?:[[:space:]]|$|>))",
                                 sep = "")

      return(gsub(rex::regex(regularExpresion),
                  paste(" ", extendedContraction, " ", sep = ""), data, perl = TRUE, ignore.case = TRUE))
    },

    getPropertyLanguageName = function() {

      return(private$propertyLanguageName)
    },

    getResourcesContractionsPath = function() {

      return(private$resourcesContractionsPath)
    },

    setResourcesContractionsPath = function(path) {

      if (!"character" %in% class(path)) {
        stop("[ContractionPipe][setResourcesContractionsPath][Error]
                Checking the type of the variable: path ",
                  class(path))
      }

      private$resourcesContractionsPath <- path

      return()
    }
  ),

  private = list(
    propertyLanguageName = "",
    resourcesContractionsPath = ""
  )
)