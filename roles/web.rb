name "baseline"
description "Web Server"

run_list(
    "recipe[bootstrap::app_bundle_dependencies]",
    "recipe[nginx]",
    "recipe[bootstrap::monit_definitions]",
    "recipe[bootstrap::install_imagemagick]"
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
    "rules" => [
      "open ports for http" => {
        "port" => "80"
      },
      "open ports for https" => {
        "port" => "443"
      }
    ]
  }
)
