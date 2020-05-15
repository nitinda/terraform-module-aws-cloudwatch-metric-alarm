resource "aws_cloudwatch_metric_alarm" "cloudwatch_metric_alarm" {
  alarm_name                            = var.alarm_name
  comparison_operator                   = var.comparison_operator
  evaluation_periods                    = var.evaluation_periods
  metric_name                           = var.metric_name
  namespace                             = var.namespace
  period                                = var.period
  statistic                             = var.statistic
  threshold                             = var.threshold
  threshold_metric_id                   = var.threshold_metric_id
  actions_enabled                       = var.actions_enabled
  alarm_actions                         = var.alarm_actions
  alarm_description                     = var.alarm_description
  datapoints_to_alarm                   = var.datapoints_to_alarm
  dimensions                            = var.dimensions
  insufficient_data_actions             = var.insufficient_data_actions
  ok_actions                            = var.ok_actions
  unit                                  = var.unit
  extended_statistic                    = var.extended_statistic
  treat_missing_data                    = var.treat_missing_data
  evaluate_low_sample_count_percentiles = var.evaluate_low_sample_count_percentiles
  
  dynamic "metric_query" {
    for_each = var.metric_query
    content {
      expression  = lookup(metric_query.value, "expression", null)
      id          = metric_query.value.id
      label       = lookup(metric_query.value, "label", null)
      return_data = lookup(metric_query.value, "return_data", null)

      dynamic "metric" {
        for_each = lookup(metric_query.value, "metric", [])
        content {
          dimensions  = lookup(metric.value, "dimensions", null)
          metric_name = metric.value.metric_name
          namespace   = lookup(metric.value, "namespace", null)
          period      = metric.value.period
          stat        = metric.value.stat
          unit        = lookup(metric.value, "unit", null)
        }
      }
    }
  }
  tags = var.tags
}

