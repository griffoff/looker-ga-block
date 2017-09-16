connection: "bigquery-prod"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: ga_sessions {
  extends: [ga_sessions_base]

  always_filter: {
    filters: {
      field: ga_sessions.partition_date
      value: "7 days ago for 7 days"
      ## Partition Date should always be set to a recent date to avoid runaway queries
    }
    filters: {
      field: ga_sessions.platform_picker
      value: "MindTap"
    }
  }
}
