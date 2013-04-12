name "mongodb"
description "Mongodb Server"

run_list(
  "recipe[mongodb]",
  "recipe[bootstrap::limits]",
  "recipe[bootstrap::monit_mongodb]",
  "recipe[bootstrap::mongodb_backup]"
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

