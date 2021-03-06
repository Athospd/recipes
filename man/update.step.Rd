% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update.R
\name{update.step}
\alias{update.step}
\title{Update a recipe step}
\usage{
\method{update}{step}(object, ...)
}
\arguments{
\item{object}{A recipe \code{step}.}

\item{...}{Key-value pairs where the keys match up with names of elements
in the step, and the values are the new values to update the step with.}
}
\description{
This \code{step} method for \code{update()} takes named arguments as \code{...} who's values
will replace the elements of the same name in the actual step.
}
\details{
For a step to be updated, it must not already have been trained. Otherwise,
conflicting information can arise between the data returned from \code{\link[=juice]{juice()}}
and the information in the step.

This function is mainly useful for finalizing \emph{varying parameters}, but
it can also be used on non-varying parameters as well (as seen in the
example below).
}
\examples{
data(biomass)

biomass_tr <- biomass[biomass$dataset == "Training",]
biomass_te <- biomass[biomass$dataset == "Testing",]

# Create a recipe using step_bs() with degree = 3
rec <- recipe(
  HHV ~ carbon + hydrogen + oxygen + nitrogen + sulfur,
  data = biomass_tr
) \%>\%
  step_bs(carbon, hydrogen, degree = 3)

# Update the step to use degree = 4
rec2 <- rec
rec2$steps[[1]] <- update(rec2$steps[[1]], degree = 4)

# Prep both recipes
rec_prepped  <- prep(rec, training = biomass_tr)
rec2_prepped <- prep(rec2, training = biomass_tr)

# Juice both to see what changed
juice(rec_prepped)
juice(rec2_prepped)

# Cannot update a recipe step that has been trained!
\dontrun{
update(rec_prepped$steps[[1]], degree = 4)
}

}
