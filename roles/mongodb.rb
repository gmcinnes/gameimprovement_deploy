name "mongodb"
description "Mongodb Server"

run_list(
    "recipe[mongodb]",
    "recipe[gameimprovement_bootstrap::limits]",
    "recipe[gameimprovement_bootstrap::mongodb_ulimits]"
)


override_attributes(
  "limits" => {
    "mongodb" => {
      "nproc" => {
        "soft" => "32000",
        "hard" => "32001"
      },
      "nofile" => {
        "soft" => "64000",
        "hard" => "64001"
      }
    }
  }
)

