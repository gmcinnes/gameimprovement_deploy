name "baseline"
description "Web Server"

run_list(
    "recipe[gameimprovement_bootstrap::app_bundle_dependencies]",
    "recipe[nginx]",
    "recipe[gameimprovement_bootstrap::monit_definitions]"
)

override_attributes(
  "authorization" => {
    "sudo" => {
      "groups" => ["admin", "wheel", "sysadmin"],
      "users"  => ["vagrant", "deploy"],
      "passwordless" => "true"
    }
  },
  "users" => ["deploy"],
  "unicorn" => {
    "worker_timeout" => "60",
    "preload_app"    => false,
    "before_fork"    => "sleep 1",
    "port"           => "8080",
    "options"        => { "tcp_nodelay" => true, "backlog" => 100 }
  },
  "firewall" => {
    "open ports for http" => {
      "port" => "80"
    }
  }
)
