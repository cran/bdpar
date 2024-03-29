#
# Bdpar provide a tool to easily build customized data flows to pre-process
# large volumes of information from different sources. To this end, bdpar allows
# to (i) easily use and create new functionalities and (ii) develop new data
# source extractors according to the user needs. Additionally, the package
# provides by default a predefined data flow to extract and preprocess the most
# relevant information (tokens, dates, ... ) from some textual sources (SMS,
# email, YouTube comments).
#
# Copyright (C) 2020-2022 Sing Group (University of Vigo)
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

#' @title Class to handle email files with eml extension
#'
#' @description This class inherits from the \code{\link{Instance}} class and
#' implements the functions of extracting the text and the date from an eml type
#' file.
#'
#' @section Details:
#' The way to indicate which part to choose in the email, when is a multipart email,
#' is through the \strong{"extractorEML.mpaPartSelected"}
#' field of \code{\link{bdpar.Options}} variable.
#'
#' @section Note:
#' To be able to use this class it is necessary to have Python installed.
#'
#' @section Inherit:
#' This class inherits from \code{\link{Instance}} and implements the
#' \code{obtainSource} and \code{obtainDate} abstracts functions.
#'
#' @seealso \code{\link{bdpar.Options}}, \code{\link{ExtractorSms}},
#' \code{\link{ExtractorYtbid}}, \code{\link{Instance}}
#'
#' @keywords NULL
#'
#' @import R6
#' @export ExtractorEml

ExtractorEml <- R6Class(

  classname = "ExtractorEml",

  inherit = Instance,

  public = list(
    #'
    #' @description Creates a \code{\link{ExtractorEml}} object.
    #'
    #' @param path A \code{\link{character}} value. Path of the eml file.
    #' @param PartSelectedOnMPAlternative A \code{\link{character}} value. Configuration to read
    #' the eml files. If it is NULL, checks if is defined in the
    #' \strong{"extractorEML.mpaPartSelected"} field of \emph{\link{bdpar.Options}}
    #' variable.
    #'
    initialize = function(path,
                          PartSelectedOnMPAlternative = NULL) {

      if (!"character" %in% class(path)) {
        bdpar.log(message = paste0("Checking the type of the 'path' variable: ",
                                   class(path)),
                  level = "FATAL",
                  className = class(self)[1],
                  methodName = "initialize")
      }

      super$initialize(path)

      if (is.null(PartSelectedOnMPAlternative)) {
        if (!bdpar.Options$isSpecificOption("extractorEML.mpaPartSelected") ||
            is.null(bdpar.Options$get("extractorEML.mpaPartSelected"))) {
          bdpar.log(message = paste0("Part of select on .eml files is neither ",
                                     "defined in initialize or in bdpar.Options"),
                    level = "FATAL",
                    className = class(self)[1],
                    methodName = "initialize")
        } else {
          PartSelectedOnMPAlternative <- bdpar.Options$get("extractorEML.mpaPartSelected")
        }
      }

      if (!"character" %in% class(PartSelectedOnMPAlternative)) {
        bdpar.log(message = paste0("Checking the type of the ",
                                   "'PartSelectedOnMPAlternative' variable: ",
                                   class(PartSelectedOnMPAlternative)),
                  level = "FATAL",
                  className = class(self)[1],
                  methodName = "initialize")
      }

      self$setPartSelectedOnMPAlternative(PartSelectedOnMPAlternative)
    },
    #'
    #' @description Obtains the date of the eml file. Calls the function
    #' \emph{read_emails} and obtains the date of the file indicated in the path
    #' and then transforms it into the generic date format, that is
    #' "\%a \%b \%d \%H:\%M:\%S \%Z \%Y" (Example: "Thu May 02 06:52:36 UTC 2013").
    #'
    obtainDate = function() {

      dateEml <- tryCatch(

        read_emails(super$getPath(),self$getPartSelectedOnMPAlternative())["date"],

        error = function(e) {
          bdpar.log(message = paste0("Date eml error ", super$getPath(),
                                     " ", paste(e)),
                    level = "ERROR",
                    className = class(self)[1],
                    methodName = "obtainDate")
        }
      )

      tryCatch({
        formatDateEml <- "%a, %d %b %Y %H:%M:%S %z"
        StandardizedDate <- as.POSIXct(dateEml[[1]], format = formatDateEml)
        formatDateGeneric <- "%a %b %d %H:%M:%S %Z %Y"
        super$setDate(format(StandardizedDate,
                             formatDateGeneric))
        },
        error = function(e) {
          bdpar.log(message = paste0("Date eml error in standardized proccess ",
                                     super$getPath(), " ", paste(e)),
                    level = "ERROR",
                    className = class(self)[1],
                    methodName = "obtainDate")
        }
      )
    },
    #'
    #' @description Obtains the source of the eml file. Calls the function
    #' \emph{read_emails} and obtains the source of the file indicated in the
    #' path. In addition, it initializes the data with the initial source.
    #'
    obtainSource = function() {

      private$source <- tryCatch(

        paste(read_emails(super$getPath(),
                          self$getPartSelectedOnMPAlternative())["message"],
              collapse = " "),

        error = function(e) {
          bdpar.log(message = paste0("Source eml error ",
                                     super$getPath(), " ", paste(e)),
                    level = "ERROR",
                    className = class(self)[1],
                    methodName = "obtainSource")
        }
      )

      super$setData(super$getSource())
    },
    #'
    #' @description Gets of \emph{PartSelectedOnMPAlternative} variable.
    #'
    #' @return Value of \emph{PartSelectedOnMPAlternative} variable.
    #'
    getPartSelectedOnMPAlternative = function() {
      private$PartSelectedOnMPAlternative
    },
    #'
    #' @description Gets of \code{PartSelectedOnMPAlternative} variable.
    #'
    #' @param PartSelectedOnMPAlternative A \code{\link{character}} value. The
    #' new value of \emph{PartSelectedOnMPAlternative} variable.
    #'
    setPartSelectedOnMPAlternative = function(PartSelectedOnMPAlternative) {

      if (!"character" %in% class(PartSelectedOnMPAlternative)) {
        bdpar.log(message = paste0("Checking the type of the ",
                                   "'PartSelectedOnMPAlternative' variable: ",
                                   class(PartSelectedOnMPAlternative)),
                  level = "FATAL",
                  className = class(self)[1],
                  methodName = "setPartSelectedOnMPAlternative")
      }

      private$PartSelectedOnMPAlternative <- PartSelectedOnMPAlternative
    },
    #'
    #' @description Returns a \code{\link{character}} representing the instance
    #'
    #' @return \code{\link{Instance}} \code{\link{character}} representation
    #'
    toString = function() {
      toRet <- paste0("\tPath: ", as.character(private$path),
                      "\n\tDate: ", as.character(private$date),
                      "\n\tIsValid: ", as.character(private$isValid),
                      "\n\tSource: \"", as.character(private$source), "\"",
                      "\n\tData: \"", as.character(private$data), "\"",
                      "\n\tFlowPipes: ", paste(as.character(unlist(private$flowPipes)), collapse = " "),
                      "\n\tBanPipes: ", paste(as.character(unlist(private$banPipes)), collapse = " "),
                      "\n\tProperties: ")

      properties <- ""
      if (length(private$properties) != 0) {
        properties <- "\n\t\t"
        properties <- paste0(properties, paste0(lapply(names(private$properties), function(propertyName) {
          paste0("- ", propertyName, ": ",
                 paste(as.character(unlist(private$properties[[propertyName]])), collapse = " "),
                 collapse = "")
        }), collapse = "\n\t\t"))
      } else {
        properties <- "Not located"
      }
      toRet <- paste0(toRet, properties, "\n")
      toRet
    }
  ),

  private = list(
    # A \code{\link{character}} value. Configuration to read the eml files.
    # Indicates whether the text/plain part or the text/html part is read in
    # multipart emails.
    PartSelectedOnMPAlternative = "text/plain"
  )
)
