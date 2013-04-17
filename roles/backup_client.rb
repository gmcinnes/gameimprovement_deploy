name "backup_client"
description "Backs up to a remote machine"
run_list(
  "recipe[bootstrap::backup_client]"
)
