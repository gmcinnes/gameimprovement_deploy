name "mongodb"
description "Mongodb Server"

run_list(
    "recipe[mongodb]",
    "recipe[gameimprovement_bootstrap::limits]",
    "recipe[gameimprovement_bootstrap::mongodb_ulimits]"
)
