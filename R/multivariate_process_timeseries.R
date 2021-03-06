
#' Helper function to prepare raw data for analysis
#' @description Processes raw data in such a way that it can be directly inputted to the multivariate_rythm_analysis function.
#' @usage multivariate_process_timeseries(df = NULL, sampling_rate = NULL, window_size_in_days = 3, window_step_in_days = 1, smooth_data = TRUE, detrend_data = FALSE)
#' @param df (required) A data.frame where the first column is a POSIXct object and the rest are independent measurement values.
#' @param sampling_rate
#' (required) A character string indicating the sampling rate of the data. Examples: '30 minutes', '1 hour', '4 seconds', '100 days'.
#' @param window_size_in_days (default=3) a numeric indicating the width of the window size in day units.
#' @param window_step_in_days (default=1) a numeric indicating the amount of day by which to move the window in day units.
#' @param smooth_data Logical. If TRUE (default) will smooth the measurement values useing a moving average. If FALSE measurement values won't be smoothed.
#' @param detrend_data Logical. If TRUE (default) will detrend the data. If FALSE measurement values won't be detrended. If both, detrend_data and smooth_data are TRUE, the detrending will run over the smoothed data.
#' @param butterworth Logical. If TRUE (default) will apply a buttwerworth filter to the measurement values using a moving average. If FALSE measurement values won't be filtered.
#'
#' @param binning_n A numeric which indicated the amount of bins over which to run the smoothing average. Default = 4.
#'
#' @param period The period on which we want to draw the threshold (default = 24).
#'
#' @param type A string indicating if a low or high pass filter will be used. options: "low" (default), "high".
#'
#' @param plot logical. If TRUE (default) plots the filtered data over the raw data. If FALSE, does not plot.
#' @return
#' A named list of data.frames containing the output of [process_timeseries()] for each measurement value.
#'
#' @export
#'
#' @examples
#'
#' processed_data <- multivariate_process_timeseries(df = raw_data,
#' sampling_rate = "30 min", window_size_in_days = 3,
#' window_step_in_days = 1, smooth_data = TRUE,
#' detrend_data = TRUE)
#'
multivariate_process_timeseries <- function(df = NULL, sampling_rate = NULL, window_size_in_days = 3,
                                window_step_in_days = 1, smooth_data = TRUE, detrend_data = TRUE,
                                buttwerworth = TRUE, period = 24, binning_n = 4, type = "low", plot = TRUE) {
###### Flow control parameters######
#1. Must supply a data frame.
if (is.null(df)) {
  stop("A data.frame must be supplied.")
}
#2.must have sampling rate and window size and step
if (is.null(window_size_in_days) | is.null(window_step_in_days)) {stop("Must include window_size and window_step. These are measured in days.")}
if (is.null(sampling_rate)) {stop("Must include sampling_rate. ex. '30 minutes', '1 hour', '4 seconds', '100 days'.")}
#3. Change the names of the df columns so we can work with it inside the function
if (!lubridate::is.POSIXct(df[[1]])) {
  stop("The first column must be a datetime object.")
}

processed_df <- purrr::map(2:ncol(df),
           .f = ~ process_timeseries(df = df[,c(1,.)], sampling_rate = sampling_rate, window_size_in_days = window_size_in_days,
                                     window_step_in_days = window_step_in_days, smooth_data = smooth_data, detrend_data = detrend_data,
                                     buttwerworth = buttwerworth, period = period, binning_n = binning_n, type = type, plot = plot))

names(processed_df) <- names(df)[-1]

return(processed_df)
}
