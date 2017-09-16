include: "ga_block.view.lkml"

explore: ga_sessions_block {
  extends: [ga_sessions_base]
  extension: required

}

view: ga_sessions {
  extends: [ga_sessions_base]
  # The SQL_TABLE_NAME must be replaced here for date partitioned queries to work properly.

#   sql_table_name: `115907067.ga_sessions_*` ;;



  sql_table_name: {% assign plat = ga_sessions.platform_selector._sql %}
                  {% if plat contains 'MindTap' %} `titanium-kiln-120918.115907067.ga_sessions_*`
                  {% elsif plat contains 'Aplia' %} `titanium-kiln-120918.130709608.ga_sessions_*`
                  {% elsif plat contains 'SAM' %} `titanium-kiln-120918.116188121.ga_sessions_*`
                  {% elsif plat contains 'MindTap Mobile' %} `titanium-kiln-120918.92812344.ga_sessions_*`
                  {% elsif plat contains 'CNow V7' %} `titanium-kiln-120918.116197107.ga_sessions_*`
                  {% elsif plat contains 'CNow V8' %} `titanium-kiln-120918.121361627.ga_sessions_*`
                  {% elsif plat contains 'CNow MindApp' %} `titanium-kiln-120918.121398401.ga_sessions_*`

                  {% endif %}
                  ;;

  filter: platform_picker {
    suggestions: ["MindTap","Aplia", "SAM", "CNow V7", "CNow V8", "CNow MindApp"]
  }

  dimension: platform_selector {
    type: string
    hidden: no
    sql: {% parameter platform_picker %} ;;
  }



  # If you have custom dimensions on sessions, declare them here.

  # dimension: custom_dimension_2 {
  #   sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=2) ;;
  # }


  # dimension: custom_dimension_2 {
  #   sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=2) ;;
  # }

  # dimension: custom_dimension_3 {
  #   sql: (SELECT value FROM UNNEST(${TABLE}.customdimensions) WHERE index=3) ;;
  # }
}

view: geoNetwork {
  extends: [geoNetwork_base]
}

view: totals {
  extends: [totals_base]
}

view: trafficSource {
  extends: [trafficSource_base]
}

view: device {
  extends: [device_base]
}

view: hits {
  extends: [hits_base]
}

view: hits_page {
  extends: [hits_page_base]
}

# -- Ecommerce Fields

view: hits_transaction {
  #extends: [hits_transaction_base]  # Comment out to remove fields
}

view: hits_item {
  #extends: [hits_item_base]
}

# -- Advertising Fields

view: adwordsClickInfo {
  #extends: [adwordsClickInfo_base]
}

view: hits_publisher {
  #extends: [hits_publisher_base]   # Comment out this line to remove fields
}

#  We only want some of the interaction fields.
view: hits_social {
  extends: [hits_social_base]

  dimension: socialInteractionNetwork {hidden: yes}

  dimension: socialInteractionAction {hidden: yes}

  dimension: socialInteractions {hidden: yes}

  dimension: socialInteractionTarget {hidden: yes}

  #dimension: socialNetwork {hidden: yes}

  dimension: uniqueSocialInteractions {hidden: yes}

  #dimension: hasSocialSourceReferral {hidden: yes}

  dimension: socialInteractionNetworkAction {hidden: yes}
}


view: hits_appInfo {
  extends: [hits_appInfo_base]
}

view: hits_eventInfo {
  extends: [hits_eventInfo_base]
  dimension: play {
    sql: ${eventAction} = "play" ;;
    type: yesno
  }
}


view: hits_customDimensions {
  extends: [hits_customDimensions_base]
}

view: hits_customVariables {
  extends: [hits_customVariables_base]
}
