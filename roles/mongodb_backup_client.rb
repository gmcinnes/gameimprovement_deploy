name "mongodb_backup_client"
description "Backs up a local instance of mongodb to the local machine on a daily basis"
run_list(
  "recipe[bootstrap::mongodb_backup]"
)
