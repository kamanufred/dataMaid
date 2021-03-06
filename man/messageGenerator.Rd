% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/messageGenerator.R
\name{messageGenerator}
\alias{messageGenerator}
\title{Produce a message for the output of a checkFunction}
\usage{
messageGenerator(problemStatus,
  message = "Note that a check function found the following problematic values:",
  nMax = 10)
}
\arguments{
\item{problemStatus}{A list consisting of two entries:

\code{$problem} - logical indicating whether a problem was found by the
\code{checkFunction} responsible for the making the \code{messageGenerator()} call,

\code{$problemValues} - a vector of values from the variable that were
deemed problematic (see details below).}

\item{message}{Optional, but recommended. A message describing what problem the
problem values are related to. If \code{NULL} a standard message is added using the name
of the function that called \code{messageGenerator}.}

\item{nMax}{Maximum number of problem values to be printed in the message. If the total
number of problem values exceeds nMax, the number of omitted problem
values are added to the message. Defaults to \code{Inf}, in which case all problem
values are printed.}
}
\value{
A character string with a problem description.
}
\description{
Helper function for producing output messages for
\code{\link{checkFunction}} type functions.
}
\details{
This function is a tool for building \code{\link{checkFunction}}s for the
\code{dataMaid} \code{\link{makeDataReport}} function. \code{checkFunction}s will often identify a number
of values in a variable that are somehow problematic. \code{messageGenerator} takes
these values, pastes them together with a problem description and makes sure that the
formatting is appropriate for being rendered in a \code{rmarkdown} document.
We recommend writing short and precise problem descriptions (see examples),
 but if no message is supplied, the following message is generated:
"Note that a check function found the following problematic values: [problem values]".
}
\examples{

#Varibales with/without underscores
 noUSVar <- c(1:10)
 USVar <- c("_a", "n_b", "b_", "_", 1:10)

#Define a checkFunction using messageGenerator with a manual
#problem description:
identifyUnderscores <- function(v, nMax = Inf) {
  v <- as.character(v)
  underscorePlaces <- regexpr("_", v) > 0
  problemValues <- unique(v[underscorePlaces])
  problem <- any(underscorePlaces)
  message <- messageGenerator(list(problemValues = problemValues, problem = problem),
                              "The following values contain underscores:",
                              nMax = nMax)
  checkResult(list(problem = problem, message = message,
      problemValues = problemValues))
 }

 identifyUnderscores(noUSVar) #no problem
 identifyUnderscores(USVar) #problems
 
#Only print the first two problemvalues in the message:
 identifyUnderscores(USVar, nMax = 2)

#Define same function, but without a manual problem description in
#the messageGenerator-call:
 identifyUnderscores2 <- function(v, nMax = Inf) {
  v <- as.character(v)
  underscorePlaces <- regexpr("_", v) > 0
  problemValues <- unique(v[underscorePlaces])
  problem <- any(underscorePlaces)
  message <- messageGenerator(list(problemValues = problemValues,
                                   problem = problem), nMax = nMax)
  checkResult(list(problem = problem, message = message,
      problemValues = problemValues))
 }

 identifyUnderscores2(noUSVar) #no problem
 identifyUnderscores2(USVar) #problems

}
\seealso{
\code{\link{check}}, \code{\link{checkFunction}}, \code{\link{makeDataReport}}
}
