variable "alarm_name" {
  description = "The descriptive name for the alarm. This name must be unique within the user's AWS account"
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "metric_name" {
  description = "The name for the alarm's associated metric"
  default     = null
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric"
  default     = null
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied"
  default     = null
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric"
  default     = null
}

variable "threshold" {
  description = "The value against which the specified statistic is compared"
  default     = null
}

variable "threshold_metric_id" {
  description = "If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY_DETECTION_BAND function"
  default     = null
}

variable "actions_enabled" {
  description = "Indicates whether or not actions should be executed during any changes to the alarm's state"
  default     = null
}

variable "alarm_actions" {
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state"
  default     = null
}

variable "alarm_description" {
  description = "The description for the alarm."
  default     = null
}

variable "datapoints_to_alarm" {
  description = "The number of datapoints that must be breaching to trigger the alarm"
  default     = null
}

variable "dimensions" {
  description = "The dimensions for the alarm's associated metric"
  default     = null
}

variable "insufficient_data_actions" {
  description = "The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state"
  default     = []
  type        = list(string)
}

variable "ok_actions" {
  description = "The list of actions to execute when this alarm transitions into an OK state from any other state"
  default     = []
  type        = list(string)
}

variable "unit" {
  description = "The unit for the alarm's associated metric"
  default     = null
}

variable "extended_statistic" {
  description = "The percentile statistic for the metric associated with the alarm"
  default     = null
}

variable "treat_missing_data" {
  description = "Sets how this alarm is to handle missing data points"
  default     = null
}

variable "evaluate_low_sample_count_percentiles" {
  description = "Used only for alarms based on percentiles."
  default     = null
}

variable "metric_query" {
  description = "Enables you to create an alarm based on a metric math expression"
  default     = []
  type        = any
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  default     = {}
  type        = any
}
