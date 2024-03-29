% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DefaultPipeline.R
\name{DefaultPipeline}
\alias{DefaultPipeline}
\title{Class implementing a default pipelining process.}
\description{
This \code{\link{DefaultPipeline}} class inherits from the
\code{\link{GenericPipeline}} class. Includes the \strong{execute} method which
provides a default pipelining implementation.
}
\section{Details}{

The default flow is:

\preformatted{
instance \%>|\%

  TargetAssigningPipe$new() \%>|\%

  StoreFileExtPipe$new() \%>|\%

  GuessDatePipe$new() \%>|\%

  File2Pipe$new() \%>|\%

  MeasureLengthPipe$new(propertyName = "length_before_cleaning_text") \%>|\%

  FindUserNamePipe$new() \%>|\%

  FindHashtagPipe$new() \%>|\%

  FindUrlPipe$new() \%>|\%

  FindEmoticonPipe$new() \%>|\%

  FindEmojiPipe$new() \%>|\%

  GuessLanguagePipe$new() \%>|\%

  ContractionPipe$new() \%>|\%

  AbbreviationPipe$new() \%>|\%

  SlangPipe$new() \%>|\%

  ToLowerCasePipe$new() \%>|\%

  InterjectionPipe$new() \%>|\%

  StopWordPipe$new() \%>|\%

  MeasureLengthPipe$new(propertyName = "length_after_cleaning_text") \%>|\%

  TeeCSVPipe$new()
}
}

\section{Inherit}{

This class inherits from \code{\link{GenericPipeline}} and implements the
\code{execute} abstract function.
}

\seealso{
\code{\link{bdpar.log}}, \code{\link{Instance}},
         \code{\link{DynamicPipeline}}, \code{\link{GenericPipeline}},
         \code{\link{GenericPipe}}, \code{\link{\%>|\%}}
}
\section{Super class}{
\code{\link[bdpar:GenericPipeline]{bdpar::GenericPipeline}} -> \code{DefaultPipeline}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-DefaultPipeline-new}{\code{DefaultPipeline$new()}}
\item \href{#method-DefaultPipeline-execute}{\code{DefaultPipeline$execute()}}
\item \href{#method-DefaultPipeline-get}{\code{DefaultPipeline$get()}}
\item \href{#method-DefaultPipeline-print}{\code{DefaultPipeline$print()}}
\item \href{#method-DefaultPipeline-toString}{\code{DefaultPipeline$toString()}}
\item \href{#method-DefaultPipeline-clone}{\code{DefaultPipeline$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-DefaultPipeline-new"></a>}}
\if{latex}{\out{\hypertarget{method-DefaultPipeline-new}{}}}
\subsection{Method \code{new()}}{
Creates a \code{\link{DefaultPipeline}} object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{DefaultPipeline$new()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-DefaultPipeline-execute"></a>}}
\if{latex}{\out{\hypertarget{method-DefaultPipeline-execute}{}}}
\subsection{Method \code{execute()}}{
Function where is implemented the flow of the
\code{\link{GenericPipe}s}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{DefaultPipeline$execute(instance)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{instance}}{A \code{\link{Instance}} value. The \code{\link{Instance}}
that is going to be processed.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
The preprocessed \code{\link{Instance}}.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-DefaultPipeline-get"></a>}}
\if{latex}{\out{\hypertarget{method-DefaultPipeline-get}{}}}
\subsection{Method \code{get()}}{
Gets a list with containing the set of
\code{link{GenericPipe}s} of the pipeline,
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{DefaultPipeline$get()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
The set of \code{\link{GenericPipe}s} containing the pipeline.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-DefaultPipeline-print"></a>}}
\if{latex}{\out{\hypertarget{method-DefaultPipeline-print}{}}}
\subsection{Method \code{print()}}{
Prints pipeline representation. (Override print function)
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{DefaultPipeline$print(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{Further arguments passed to or from other methods.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-DefaultPipeline-toString"></a>}}
\if{latex}{\out{\hypertarget{method-DefaultPipeline-toString}{}}}
\subsection{Method \code{toString()}}{
Returns a \code{\link{character}} representing the pipeline
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{DefaultPipeline$toString()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
\code{\link{DefaultPipeline}} \code{\link{character}} representation
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-DefaultPipeline-clone"></a>}}
\if{latex}{\out{\hypertarget{method-DefaultPipeline-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{DefaultPipeline$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
