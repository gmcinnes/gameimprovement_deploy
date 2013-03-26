name "baseline"
description "Web Server"

run_list(
    "recipe[gameimprovement_bootstrap::app_bundle_dependencies]",
    "recipe[nginx]"
)
