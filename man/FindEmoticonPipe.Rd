% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FindEmoticonPipe.R
\name{FindEmoticonPipe}
\alias{FindEmoticonPipe}
\title{Class to find and/or remove the emoticons on the data field of an Instance}
\description{
This class is responsible of detecting the existing emoticons in the
\strong{data} field of each \code{\link{Instance}}. Identified emoticons are
stored inside the \strong{emoticon} field of \code{\link{Instance}} class.
Moreover if required, is able to perform inline emoticon removement.
}
\section{Details}{

The regular expression indicated in the \code{emoticonPattern}
variable is used to identify emoticons.
}

\section{Note}{

\code{\link{FindEmoticonPipe}} will automatically invalidate the
\code{\link{Instance}} whenever the obtained data is empty.
}

\section{Inherit}{

This class inherits from \code{\link{GenericPipe}} and implements the
\code{pipe} abstract function.
}

\seealso{
\code{\link{AbbreviationPipe}}, \code{\link{ContractionPipe}},
         \code{\link{File2Pipe}}, \code{\link{FindEmojiPipe}},
         \code{\link{FindHashtagPipe}}, \code{\link{FindUrlPipe}},
         \code{\link{FindUserNamePipe}}, \code{\link{GuessDatePipe}},
         \code{\link{GuessLanguagePipe}}, \code{\link{Instance}},
         \code{\link{InterjectionPipe}}, \code{\link{MeasureLengthPipe}},
         \code{\link{GenericPipe}}, \code{\link{SlangPipe}},
         \code{\link{StopWordPipe}}, \code{\link{StoreFileExtPipe}},
         \code{\link{TargetAssigningPipe}}, \code{\link{TeeCSVPipe}},
         \code{\link{ToLowerCasePipe}}
}
\section{Super class}{
\code{\link[bdpar:GenericPipe]{bdpar::GenericPipe}} -> \code{FindEmoticonPipe}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{emoticonPattern}}{A \code{\link{character}} value. The regular
expression to detect emoticons.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{FindEmoticonPipe$new()}}
\item \href{#method-pipe}{\code{FindEmoticonPipe$pipe()}}
\item \href{#method-findEmoticon}{\code{FindEmoticonPipe$findEmoticon()}}
\item \href{#method-removeEmoticon}{\code{FindEmoticonPipe$removeEmoticon()}}
\item \href{#method-clone}{\code{FindEmoticonPipe$clone()}}
}
}
\if{html}{
\out{<details ><summary>Inherited methods</summary>}
\itemize{
\item \out{<span class="pkg-link" data-pkg="bdpar" data-topic="GenericPipe" data-id="getAlwaysBeforeDeps">}\href{../../bdpar/html/GenericPipe.html#method-getAlwaysBeforeDeps}{\code{bdpar::GenericPipe$getAlwaysBeforeDeps()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="bdpar" data-topic="GenericPipe" data-id="getNotAfterDeps">}\href{../../bdpar/html/GenericPipe.html#method-getNotAfterDeps}{\code{bdpar::GenericPipe$getNotAfterDeps()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="bdpar" data-topic="GenericPipe" data-id="getPropertyName">}\href{../../bdpar/html/GenericPipe.html#method-getPropertyName}{\code{bdpar::GenericPipe$getPropertyName()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="bdpar" data-topic="GenericPipe" data-id="hash">}\href{../../bdpar/html/GenericPipe.html#method-hash}{\code{bdpar::GenericPipe$hash()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="bdpar" data-topic="GenericPipe" data-id="setAlwaysBeforeDeps">}\href{../../bdpar/html/GenericPipe.html#method-setAlwaysBeforeDeps}{\code{bdpar::GenericPipe$setAlwaysBeforeDeps()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="bdpar" data-topic="GenericPipe" data-id="setNotAfterDeps">}\href{../../bdpar/html/GenericPipe.html#method-setNotAfterDeps}{\code{bdpar::GenericPipe$setNotAfterDeps()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="bdpar" data-topic="GenericPipe" data-id="setPropertyName">}\href{../../bdpar/html/GenericPipe.html#method-setPropertyName}{\code{bdpar::GenericPipe$setPropertyName()}}\out{</span>}
}
\out{</details>}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
Creates a \code{\link{FindEmoticonPipe}} object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{FindEmoticonPipe$new(
  propertyName = "emoticon",
  alwaysBeforeDeps = list(),
  notAfterDeps = list("FindHashtagPipe"),
  removeEmoticons = TRUE
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{propertyName}}{A \code{\link{character}} value. Name of the property
associated with the \code{\link{GenericPipe}}.}

\item{\code{alwaysBeforeDeps}}{A \code{\link{list}} value. The dependencies
alwaysBefore (\code{\link{GenericPipe}s} that must be executed before
this one).}

\item{\code{notAfterDeps}}{A \code{\link{list}} value. The dependencies
notAfter (\code{\link{GenericPipe}s} that cannot be executed after
this one).}

\item{\code{removeEmoticons}}{A \code{\link{logical}} value. Indicates if the
emoticons are removed.}

\item{\code{propertyLanguageName}}{A \code{\link{character}} value. Name of the
language property.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-pipe"></a>}}
\if{latex}{\out{\hypertarget{method-pipe}{}}}
\subsection{Method \code{pipe()}}{
Preprocesses the \code{\link{Instance}} to obtain/remove
the emoticons. The emoticons found in the data are added to the
list of properties of the \code{\link{Instance}}.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{FindEmoticonPipe$pipe(instance)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{instance}}{A \code{\link{Instance}} value. The \code{\link{Instance}}
to preprocess.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
The \code{\link{Instance}} with the modifications that have
occurred in the pipe.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-findEmoticon"></a>}}
\if{latex}{\out{\hypertarget{method-findEmoticon}{}}}
\subsection{Method \code{findEmoticon()}}{
Finds the \emph{emoticons} in the data.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{FindEmoticonPipe$findEmoticon(data)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{data}}{A \code{\link{character}} value. The text to search the
emoticons.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
The \code{\link{list}} with emoticons found.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-removeEmoticon"></a>}}
\if{latex}{\out{\hypertarget{method-removeEmoticon}{}}}
\subsection{Method \code{removeEmoticon()}}{
Removes the \emph{emoticons} in the data.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{FindEmoticonPipe$removeEmoticon(data)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{data}}{A \code{\link{character}} value. The text where emoticons
will be removed.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
The data with the emoticons removed.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{FindEmoticonPipe$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
