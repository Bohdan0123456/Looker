view: d_customer {
  sql_table_name: "DATA_MART"."D_CUSTOMER" ;;

  dimension: c_address {
    type: string
    sql: ${TABLE}."C_ADDRESS" ;;
  }
  dimension: c_custkey {
    type: number
    primary_key: yes
    sql: ${TABLE}."C_CUSTKEY" ;;
  }
  dimension: c_mktsegment {
    type: number
    sql: ${TABLE}."C_MKTSEGMENT" ;;
  }
  dimension: c_name {
    type: string
    sql: ${TABLE}."C_NAME" ;;
  }
  dimension: c_nation {
    type: string
    sql: ${TABLE}."C_NATION" ;;
  }
  dimension: c_phone {
    type: string
    sql: ${TABLE}."C_PHONE" ;;
  }
  dimension: c_region{
    type: string
    sql: ${TABLE}."C_REGION" ;;
    link:{
      label: "Summary Dashboard Target"
      url: "/dashboards/291?C+Region={{_filters['d_customer.c_region'] | url_encode }}"
    }
  }
  measure: count {
    type: count
    drill_fields: [c_name]
  }
}
