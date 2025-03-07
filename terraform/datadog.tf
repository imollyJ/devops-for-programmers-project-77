resource "datadog_monitor" "check_mollyj" {
  name    = "Host is unavaible (monitor)"
  type    = "service check"
  query   = "\"ntp.in_sync\".over(\"*\").by(\"host\").last(6).count_by_status()"
  message = "Host is unavaible. Check configuration @all"

  monitor_thresholds {
    critical = 5
    warning  = 3
    ok       = 1
  }

  notify_audit      = false
  notify_no_data    = false
  renotify_interval = 0
  timeout_h         = 0
  include_tags      = false
  new_group_delay   = 60
}
