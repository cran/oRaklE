% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/full_forecast.R
\name{full_forecast}
\alias{full_forecast}
\title{Title}
\usage{
full_forecast(
  start_year,
  end_year_data,
  country,
  test_set_steps = 2,
  future = "yes",
  end_year = 2028,
  data_directory = tempdir(),
  verbose = FALSE
)
}
\arguments{
\item{start_year}{Specifies the starting year for which predictions and models will be generated.}

\item{end_year_data}{Specifies the final year for which data from the Transparency Platform of the European Network of
Transmission System Operators for Electricity (ENTSO-E, https://transparency.entsoe.eu/) is retrieved and for which models will be generated.}

\item{country}{String. Specifies the country.}

\item{test_set_steps}{Integer. Specifies how many years are used for generating the test/validation set for the model selection.}

\item{future}{String. Option to enable or disable the future forecasts. If set to "yes" forecasts will be made until the specified end_year. If set to
anything else, forecasts will only be generated until the specified end_year_data value.}

\item{end_year}{Specifies the final year for which future predictions will be generated.}

\item{data_directory}{The path to the directory where the results and plots will be saved. The default is set to a temporary directory.
It is highly recommended to set it to something that is not a temporary directory if you want to use this function.}

\item{verbose}{A boolean value indicating if you want the generated plots and detailed status updates to be shown (set to TRUE if yes).
#' @seealso See also functions \code{\link{long_term_lm}}, \code{\link{mid_term_lm}}, and \code{\link{short_term_lm}} for the prediction models
and \code{\link{long_term_future}}, \code{\link{mid_term_future}}, and \code{\link{short_term_future}} for the future prediction models.}
}
\value{
Returns a list with the combined model results and plots. And a list with the results, models and plots for the long-term trend, mid-term seasonality, and
short-term seasonality respectively.
The combined model predictions and plots are saved in the respective folder for the country.
\describe{
\item{full_model_predictions}{The combined model results and plots.}
\item{longterm}{The long-term trend models, results, and plots.}
\item{midterm}{The mid-term seasonality models, results, and plots.}
\item{shortterm}{The short-term seasonality models, results, and plots.}
}
}
\description{
Title
}
\examples{
library(ggplot2)
## Without future predictions
\donttest{
forecast_data <- full_forecast(
  start_year = 2017, end_year_data = 2021, country = "France", test_set_steps = 2,
  future = "no"
)
}
ggplot(example_full_model_predictions) +
  geom_line(aes(date, hourly_demand, color = "actual")) +
  geom_line(aes(date, complete_model, color = "fitted")) +
  xlab("\nYear") +
  ylab("Hourly Demand\n [MW]\n") +
  geom_vline(xintercept = example_full_model_predictions$date[26280], linetype = 2) +
  ggthemes::theme_foundation(base_size = 14, base_family = "sans") +
  xlab("\nHour") +
  ylab("Hourly Demand\n [MW]\n") +
  ggtitle(paste("Complete Model Results - FR\n")) +
  theme(
    plot.title = element_text(
      face = "bold",
      size = rel(1.2), hjust = 0.5
    ),
    text = element_text(),
    panel.background = element_rect(colour = NA),
    plot.background = element_rect(colour = NA),
    panel.border = element_rect(colour = NA),
    axis.title = element_text(face = "bold", size = rel(1)),
    axis.title.y = element_text(angle = 90, vjust = 2),
    axis.title.x = element_text(vjust = -0.2),
    axis.text = element_text(),
    axis.line.x = element_line(colour = "black"),
    axis.line.y = element_line(colour = "black"),
    axis.ticks = element_line(),
    panel.grid.major = element_line(colour = "#f0f0f0"),
    panel.grid.minor = element_blank(),
    legend.key = element_rect(colour = NA),
    legend.position = "bottom",
    legend.direction = "horizontal",
    legend.key.size = unit(0.2, "cm"),
    plot.margin = unit(c(10, 5, 5, 5), "mm"),
    strip.background = element_rect(colour = "#f0f0f0", fill = "#f0f0f0"),
    strip.text = element_text(face = "bold")
  ) +
  theme(legend.title = element_blank())

## With future predictions
\donttest{
forecast_data <- full_forecast(
  start_year = 2017, end_year_data = 2021, country = "France", test_set_steps = 2,
  future = "yes", end_year = 2028
)
}
suppressWarnings(
  ggplot(example_full_model_future_predictions) +
    geom_line(aes(1:nrow(example_full_model_future_predictions),
      hourly_demand,
      color = "actual"
    )) +
    geom_line(aes(1:nrow(example_full_model_future_predictions), complete_model,
      color = "fitted"
    )) +
    xlab("\nYear") +
    ylab("Hourly Demand\n [MW]\n") +
    geom_vline(xintercept = 26280, linetype = 2) +
    geom_vline(xintercept = 43800, linetype = 3) +
    ggthemes::theme_foundation(base_size = 14, base_family = "sans") +
    xlab("\nHour") +
    ylab("Hourly Demand\n [MW]\n") +
    scale_y_continuous(labels = scales::label_number(scalar = 1)) +
    ggtitle(paste("Complete Model Results - FR\n")) +
    theme(
      plot.title = element_text(
        face = "bold",
        size = rel(1.2), hjust = 0.5
      ),
      text = element_text(),
      panel.background = element_rect(colour = NA),
      plot.background = element_rect(colour = NA),
      panel.border = element_rect(colour = NA),
      axis.title = element_text(face = "bold", size = rel(1)),
      axis.title.y = element_text(angle = 90, vjust = 2),
      axis.title.x = element_text(vjust = -0.2),
      axis.text = element_text(),
      axis.line.x = element_line(colour = "black"),
      axis.line.y = element_line(colour = "black"),
      axis.ticks = element_line(),
      panel.grid.major = element_line(colour = "#f0f0f0"),
      panel.grid.minor = element_blank(),
      legend.key = element_rect(colour = NA),
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.key.size = unit(0.2, "cm"),
      plot.margin = unit(c(10, 5, 5, 5), "mm"),
      strip.background = element_rect(colour = "#f0f0f0", fill = "#f0f0f0"),
      strip.text = element_text(face = "bold")
    ) +
    theme(legend.title = element_blank()) +
    scale_x_continuous(
      breaks = c(1, 8761, 17521, 26281, 35041, 43801, 52561, 61321, 70081, 78841, 87601, 96361),
      labels = c(2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028)
    ) +
    annotate("text", x = 13140, y = 99216.6, label = "Training", size = 4, hjust = 0.5, vjust = 0) +
    annotate("text", x = 35040, y = 99216.6, label = "Test", size = 4, hjust = 0.5, vjust = 0) +
    annotate("text", x = 74460, y = 99216.6, label = "Unknown", size = 4, hjust = 0.5, vjust = 0)
)
}
