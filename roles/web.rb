name "web"
description "Web Server"

run_list(
    "recipe[bootstrap::app_bundle_dependencies]",
    "recipe[nginx]",
    "recipe[bootstrap::monit_web]",
    "recipe[nodejs::install_from_package]",
    "recipe[ufw]"
)

override_attributes(
  # Adjust sudo so that any users in the admin, wheel, sysadmin
  # groups get sudo access. Ditto, the "vagrant" and "deploy"
  # users.
  #
  # Make sudo passwordless.  We are already requiring ssh key
  # logins, and preventing root logins.  We assume that if you
  # can get on the box through that a privilege escalation to
  # root will be trivial anyway
  "authorization" => {
    "sudo" => {
      "groups" => ["admin", "wheel", "sysadmin"],
      "users"  => ["vagrant", "deploy"],
      "passwordless" => "true"
    }
  },

  # Create a user called "deploy" to handle running our app under
  "users" => ["deploy"],

  # Set various parameters about Unicorn.  We sleep before forking just
  # to throttle the master process from forking too quickly. Apparently this 
  # " helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy."
  #
  # The other stuff should be self explanatory.
  "unicorn" => {
    "worker_timeout" => "60",
    "preload_app"    => false,
    "before_fork"    => "sleep 1",
    "port"           => "8080",
    "options"        => { "tcp_nodelay" => true, "backlog" => 100 }
  },
  
  # Open ports 80 and 443 in the firewall for http and https respectively
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
