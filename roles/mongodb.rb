name "mongodb"
description "Mongodb Server"

run_list(
  "recipe[mongodb]",
  "recipe[bootstrap::limits]",
  "recipe[site_monit::mongodb]"
)


override_attributes(
  # Linux enforces limits on the number of open files, or running processes a
  # user can have.  We try and increase that for the mongodb user.
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

