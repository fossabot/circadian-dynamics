% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/process_timeseries.R
\name{process_timeseries}
\alias{process_timeseries}
\title{Helper function to prepare raw data for analysis}
\usage{
process_timeseries(df = NULL, sampling_rate = NULL, window_size_in_days = 3, window_step_in_days = 1, smooth_data = TRUE, detrend_data = FALSE, datetime = NULL, values = NULL)
}
\arguments{
\item{df}{A data.frame where the first column is a POSIXct object and the rest are independent measurement values.}

\item{sampling_rate}{A character string indicating the sampling rate of the data. Examples: '30 minutes', '1 hour', '4 seconds', '100 days'.}

\item{window_size_in_days}{a numeric indicating the width of the window size in day units.}

\item{window_step_in_days}{a numeric indicating the amount of day by which to move the window in day units.}

\item{smooth_data}{Logical. If TRUE (default) will smooth the measurement values useing a moving average. If FALSE measurement values won't be smoothed.}

\item{detrend_data}{Logical. If TRUE (default) will detrend the data. If FALSE measurement values won't be detrended. If both, detrend_data and smooth_data are TRUE, the detrending will run over the smoothed data.}

\item{butterworth}{Logical. If TRUE (default) will apply a buttwerworth filter to the measurement values using a moving average. If FALSE measurement values won't be filtered.}

\item{period}{The period on which we want to draw the threshold (default = 24).}

\item{type}{A string indicating if a low or high pass filter will be used. options: "low" (default), "high".}

\item{plot}{logical. If TRUE (default) plots the filtered data over the raw data. If FALSE, does not plot.}

\item{binning_n}{A numeric which indicated the amount of bins over which to run the smoothing average. Default = 4.}

\item{datetime}{Optional if a data.frame is supplied. A POSIXct vector.}

\item{values}{Optional if a data.frame is supplied. A vector of values from a mesurement.}
}
\value{
A named list of data.frames containing the output of [circadiandynamics::butterworth], [find_gaps()], [makes_time_windows()], and [smooth_detrend_by_windows()] for each measurement value.
}
\description{
Processes raw data in such a way that it can be directly inputted to the rythm_analysis_by_window function.
}
\examples{
processed_data <- process_timeseries(df = raw_data, sampling_rate = "30 min")

}
