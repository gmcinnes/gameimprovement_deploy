name "image_generation_server"
description "Generates shot images using d3"

run_list(
    "recipe[nodejs]",
    "recipe[npm]",
    "recipe[bootstrap::node_dependencies]",
    "recipe[phantomjs]"
)
