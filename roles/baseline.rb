name "baseline"
description "Universal Server Baseline"
run_list(
    "recipe[apt]",
    "recipe[unattended_upgrades]",
    "recipe[gameimprovement_bootstrap::apt_get_upgrade]",
    "recipe[ntp]",
    "recipe[postfix]",
    "recipe[postfix::aliases]",
    "recipe[gameimprovement_bootstrap::install_postfix_credentials]",
    "recipe[gameimprovement_bootstrap::sysctl]",
    "recipe[openssh]",
    "recipe[vim]",
    "recipe[sudo]",
    "recipe[monit]",
    "recipe[monit::ssh]",
    "recipe[monit::postfix]",
    "recipe[ufw]",
    "recipe[logrotate]",
    "recipe[fail2ban]",
    "recipe[rbenv]",
    "recipe[rbenv::ruby_build]",
    "recipe[gameimprovement_bootstrap::install_ruby]",
    "recipe[build-essential]",
    "recipe[gameimprovement_bootstrap::ruby_shadow]",
    "recipe[user]",
    "recipe[user::data_bag]"
)

override_attributes(
  "postfix" => {
    "mydomain" => "gameimprovement.ca",
    "myorigin" => "$mydomain",
    "myhostname" => "gameimprovement.ca",
    "relayhost" => "[smtp.gmail.com]:587",
    "smtp_use_tls" => "yes",
    "smtp_sasl_auth_enable" => "yes",
    "smtp_sasl_password_maps" => "hash:/etc/postfix/sasl_passwd",
    "smtp_tls_cafile" => "/usr/lib/ssl/certs/Equifax_Secure_CA.pem",
    "smtp_sasl_security_options" => "",
    "smtp_tls_security_options" => "may",
    "aliases" => {
      "monit" => "root",
      "root" => "grantmcinnes1@gmail.com"
    }
  }
)
