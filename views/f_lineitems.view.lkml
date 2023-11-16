view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS" ;;

  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }
  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }
  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }
  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }
  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }
  dimension: l_extendedprice {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }
  dimension: l_linenumber {
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }
  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }
  dimension: l_orderkey {
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }
  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }
  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }
  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }
  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }
  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }
  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }
  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }
  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }
  dimension: l_shipmode {
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }
  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }
  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }
  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }
  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }
  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }
  measure: count {
    type: count
  }

  measure: TotalSalePrice {
    label: "Total Sale Price"
    description: "Total Sales Value in USD"
    type: sum
    sql: ${l_totalprice} ;;
    value_format_name: usd
  }
  measure: AVGSalePrice {
    label: "Total Average Price"
    description: "Total Average Value in USD"
    type: average
    sql: ${l_totalprice};;
    # value_format_name: usd
  }
  measure: CumulativeTotalSales {
    label: "CumulativeTotalSales"
    description: "CumulativeTotalSales"
    type: running_total
    sql: ${l_totalprice};;
    # value_format_name: usd
  }
  measure: Total_USA_Sales {
    label: "Total USA Sales"
    description: "Total USA Sales"
    type: sum
    filters: {
      field: "d_customer.c_nation"
      value: "UNITED STATES"
    }
    sql: ${l_totalprice} ;;
    # value_format_name: usd
  }
  dimension: Cohort_of_suppliers_according_to_Account_Balance {
    label: "Cohort_of_suppliers_according_to_Account_Balance"
    description: "Cohort_of_suppliers_according_to_Account_Balance"
    style: integer
    type: tier
    tiers: [1,3001,5001,7001]
        sql: ${l_totalprice};;
    # value_format_name: usd
  }
  measure: Total_Gross_Revenue {
    label: "Total_Gross_Revenue"
    description: "Total_Gross_Revenue"
    type: sum
    filters: [l_orderstatus: "F"]
    sql: ${l_totalprice};;
    # value_format_name: usd
  }
  measure: Total_Cost {
    label: "Total_Cost"
    description: "Total Cost"
    type: sum
    sql: ${l_supplycost};;
    # value_format_name: usd
  }
  measure: Total_Gross_Margin_Amount {
    label: "Total_Gross_Margin_Amount"
    description: "Total_Gross_Margin_Amount"
    type: number
    sql: ${Total_Gross_Revenue} - ${Total_Cost};;
    # value_format_name: usd
  }
  measure: Goss_Margin_Percentage {
    label: "Goss_Margin_Percentage"
    description: "Goss_Margin_Percentage"
    type: number
    sql: ${Total_Gross_Margin_Amount} / NULLIF(${Total_Gross_Revenue},0);;
    # value_format_name: usd
  }
  measure: Number_of_Items_Returned {
    label: "Number_of_Items_Returned"
    description: "Number_of_Items_Returned"
    type: sum
    filters: [l_returnflag: "R"]
    sql: ${l_quantity};;
    # value_format_name: usd
  }
  measure: Total_Number_of_Items_Sold {
    label: "Total_Number_of_Items_Sold"
    description: "Total_Number_of_Items_Sold"
    type: sum
    sql: ${l_quantity};;
    # value_format_name: usd
  }
  measure: Item_Return_Rate {
    label: "Item_Return_Rate"
    description: "Item_Return_Rate"
    type: number
    sql: ${Number_of_Items_Returned} / ${Total_Number_of_Items_Sold} ;;
    # value_format_name: usd
  }

  measure: Average_Spend_per_Customer {
    label: "Average_Spend_per_Customer"
    description: "Average_Spend_per_Customer"
    type: number
    sql: ${TotalSalePrice}/${d_customer.count};;
    # value_format_name: usd
  }


}
