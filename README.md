# _Terraform Module: terraform-module-aws-cloudwatch-metric-alarm_

_Terraform Module for_ **_AWS AWS CloudWatch Metric Alarm_**


<!--BEGIN STABILITY BANNER-->
---

![_Code : Stable_](https://img.shields.io/badge/Code-Stable-brightgreen?style=for-the-badge&logo=github)

> **_This is a stable example. It should successfully build out of the box_**
>
> _This examples does is built on Construct Libraries marked "Stable" and does not have any infrastructure prerequisites to build._

---
<!--END STABILITY BANNER-->



## _General_

_This module may be used to create_ **_AWS CloudWatch Metric Alarm_** _resources in AWS cloud provider......_



---


## _Prerequisites_

_This module needs_ **_Terraform 0.12.19_** _or newer._
_You can download the latest Terraform version from_ [_here_](https://www.terraform.io/downloads.html).

_This module deploys aws services details are in respective feature branches._



---


## _Features_

_Below we are able to check the resources that are being created as part of this module call:_

* **_AWS CloudWatch Metric Alarm_**


---

## _Usage_

## _Using this repo_

_To use this module, add the following call to your code:_

* **_Example Usage_**

* **_Example in Conjunction with Scaling Policies_**
```tf
module "cloudwatch_metric_alarm_up" {
  source = "git::https://github.com/nitinda/terraform-module-aws-cloudwatch-metric-alarm.git?ref=master"

  providers = {
    aws = aws.services
  }

  alarm_name          = "AlarmHigh"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  
}
```

* **_Example with an Expression_**

```tf
module "cloudwatch_metric_alarm_up" {
  source = "git::https://github.com/nitinda/terraform-module-aws-cloudwatch-metric-alarm.git?ref=master"

  providers = {
    aws = aws.services
  }

  alarm_name          = "AlarmHigh"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 20
  datapoints_to_alarm = 1

  dimensions = {
    AutoScalingGroupName = module.autoscaling_group.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [ module.aws_autoscaling_policy.arn ]
  
}
```

* **_Example of monitoring Healthy Hosts on NLB using Target Group and NLB_**
```tf
module "cloudwatch_metric_alarm_up" {
  source = "git::https://github.com/nitinda/terraform-module-aws-cloudwatch-metric-alarm.git?ref=master"

  providers = {
    aws = aws.services
  }

  alarm_name          = "AlarmHigh"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  threshold           = "10"
  alarm_description   = "Request error rate has exceeded 10%"

  metric_query {
    id          = "e1"
    expression  = "m2/m1*100"
    label       = "Error Rate"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "RequestCount"
      namespace   = "AWS/ApplicationELB"
      period      = "120"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = "app/web"
      }
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "HTTPCode_ELB_5XX_Count"
      namespace   = "AWS/ApplicationELB"
      period      = "120"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        LoadBalancer = "app/web"
      }
    }
  }
  
}
```

---

## _Inputs_

_The variables required in order for the module to be successfully called from the deployment repository are the following:_

> **_NOTE_**_: You cannot create a metric alarm consisting of both statistic and extended_statistic parameters. You must choose one or the other_




|**_Variable_** | **_Description_** | **_Type_** | **_Argument Status_** | **_Default Value_** |
|:----|:----|-----:|:---:|:---:|
| **_alarm\_name_** | _The descriptive name for the alarm. This name must be unique within the user's AWS account_ | _string_ | **_Required_** |
| **_comparison\_operator_** | _The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported:_ **_GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold_**_. Additionally, the values_**_LessThanLowerOrGreaterThanUpperThreshold, LessThanLowerThreshold_**_, and_ **_GreaterThanUpperThreshold_** _are used only for alarms based on anomaly detection models._ | _string_ | **_Required_** |
| **_evaluation\_periods_** | _The number of periods over which data is compared to the specified threshold._ | _number_ | **_Required_** |
| **_metric\_name_** | _The name for the alarm's associated metric_ | _string_ | **_Optional_** | **_null_** |
| **_namespace_** | _The namespace for the alarm's associated metric_ | _string_ | **_Optional_** | **_null_** |
| **_period_** | _The period in seconds over which the specified statistic is applied_ | _number_ | **_Optional_** | **_null_** |
| **_statistic_** | _The statistic to apply to the alarm's associated metric. Either of the following is supported:_ **_SampleCount, Average, Sum, Minimum, Maximum_** | _string_ | **_Optional_** | **_null_** |
| **_threshold_** | _The value against which the specified statistic is compared. This parameter is required for alarms based on static thresholds, but should not be used for alarms based on anomaly detection models._ | _number_ | **_Optional_** | **_null_** |
| **_threshold\_metric\_id_** | _If this is an alarm based on an anomaly detection model, make this value match the ID of the ANOMALY\_DETECTION\_BAND function_ | _string_ | **_Optional_** | **_null_** |
| **_actions\_enabled_** | _Indicates whether or not actions should be executed during any changes to the alarm's state. Defaults to **_true_**_ | _boolean_ | **_Optional_** | **_true_** |
| **_alarm\_actions_** | _The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN)._ | _string_ | **_Optional_** | **_null_** |
| **_alarm\_description_** | _The description for the alarm_ | _string_ | **_Optional_** | **_null_** |
| **_datapoints\_to\_alarm_** | _The number of datapoints that must be breaching to trigger the alarm._ | _string_ | **_Optional_** | **_null_** |
| **_dimensions_** | _The dimensions for the alarm's associated metric. For the list of available dimensions see the AWS documentation [here](http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html)._ | _string_ | **_Optional_** | **_null_** |
| **_alarm\_description_** | _The description for the alarm_ | _string_ | **_Optional_** | **_null_** |
| **_insufficient\_data\_actions_** | _The description for the alarm_ | _list(string)_ | **_Optional_** | **_null_** |
| **_alarm\_description_** | _The list of actions to execute when this alarm transitions into an INSUFFICIENT\_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN)._ | _string_ | **_Optional_** | **_null_** |
| **_ok\_actions_** | _The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Name (ARN)._ | _list(string)_ | **_Optional_** | **_null_** |
| **_unit_** | _The unit for the alarm's associated metric_ | _string_ | **_Optional_** | **_null_** |
| **_extended\_statistic_** | _The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100._ | _string_ | **_Optional_** | **_null_** |
| **_treat\_missing\_data_** | _Sets how this alarm is to handle missing data points. The following values are supported:_ **_missing_**_,_ **_ignore_**_,_ **_breaching_** _and_ **_notBreaching_**_. Defaults to_ **_missing_** | _string_ | **_Optional_** | **_missing_** |
| **_evaluate\_low\_sample\_count\_percentiles_** | _Used only for alarms based on percentiles. If you specify ignore, the alarm state will not change during periods with too few data points to be statistically significant. If you specify evaluate or omit this parameter, the alarm will always be evaluated and possibly change state no matter how many data points are available. The following values are supported:_ **_ignore_**_, and_ **_evaluate_** | _string_ | **_Optional_** | **_null_** |
| **_metric\_query_** | _Enables you to create an alarm based on a metric math expression. You may specify at most 20._ | _any_ | **_Optional_** | **_null_** |
| **_tags_** | _A map of tags to assign to the resource._ | _any_ | **_Optional_** | **_{}_** |



> **_NOTE_**_: If you specify at least one metric_query, you may not specify a metric_name, namespace, period or statistic. If you do not specify a metric_query, you must specify each of these (although you may use extended_statistic instead of statistic)._


---

## _Outputs_

### _General_

_This module has the following outputs:_

_The ARN of the cloudwatch metric alarm_
* **_arn_**

_The ID of the health check_
* **_id_**


---


### _Usage_

_In order for the variables to be accessed on module level please use the syntax below:_

```tf
module.<module_name>.<output_variable_name>
```

_The output variable is able to be accessed through terraform state file using the syntax below:_

```tf
data.terraform_remote_state.<module_name>.<output_variable_name>

```

---

## Authors
_Module maintained by Module maintained by the -_ **_Nitin Das_**
