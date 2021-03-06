name "baseline"
description "Universal Server Baseline"
run_list(
    "recipe[apt]",
    "recipe[unattended_upgrades]",
    "recipe[site-apt::apt_get_upgrade]",
    "recipe[ntp]",
    "recipe[postfix]",
    "recipe[postfix::aliases]",
    "recipe[site-postfix::tweak_aliases_for_postfix]",
    "recipe[site-postfix::install_postfix_credentials]",
    "recipe[site-sysctl::sysctl]",
    "recipe[openssh]",
    "recipe[vim]",
    "recipe[sudo]",
    "recipe[monit]",
    "recipe[site-monit::init_fix]",
    "recipe[monit::ssh]",
    "recipe[monit::postfix]",
    "recipe[site-monit::baseline]",
    "recipe[ufw]",
    "recipe[logrotate]",
    "recipe[fail2ban]",
    "recipe[rbenv]",
    "recipe[rbenv::ruby_build]",
    "recipe[site-ruby::install_ruby]",
    "recipe[build-essential]",
    "recipe[user]",
    "recipe[user::data_bag]",
    "recipe[backupninja]"
)

override_attributes(

  # Send monit mails to root@localhost.  Later we'll use 
  # /etc/aliases and postfix to bounce all the root mail over
  # to the actual sysadmin
  "monit" => {
    "notify_email" => "root@localhost",
    "mail_format" => {
      "from" => "monit@gameimprovement.com"
    }
  },

  # Configure postfix.  We're configuring a situation here where
  # we're relaying mail through gmail's SMTP server.  We connect
  # to it using SASL.  The credentials for the SASL connection
  # are picked up in the recipe from a data bag.  See
  # data_bags/secrets/gmail.json.template for details.
  "postfix" => {
    "mydomain" => "gameimprovement.com",
    "myorigin" => "$mydomain",
    "myhostname" => "gameimprovement.com",
    "relayhost" => "[smtp.gmail.com]:587",
    "smtp_use_tls" => "yes",
    "smtp_sasl_auth_enable" => "yes",
    "smtp_sasl_password_maps" => "hash:/etc/postfix/sasl_passwd",
    "smtp_tls_cafile" => "/usr/lib/ssl/certs/Equifax_Secure_CA.pem",
    "smtp_sasl_security_options" => "",
    "smtp_tls_security_options" => "may",
    
    # Here we're adding aliases for /etc/aliases.  Mail to monit goes to 
    # root, and mail to root goes to support@gameimprovement.com
    "aliases" => {
      "monit" => "root",
      "root" => "support@gameimprovement.com"
    }
  },

  # Turn on sftp inside openssh.  Turn off password authentication,
  # and don't permit root logins
  "openssh" => {
    "server" => {
      "subsystem" => "sftp internal-sftp",
      "password_authentication" => "no",
      "permit_root_login" => "no"
    }
  },
  
  # Sysctl Magic Shit (TM)
  "sysctl" => { 
    
    # 256 KB default performs well experimentally, and is often 
    # recommended by ISVs.
    "net.core.rmem_default"      => "262144",
    "net.core.wmem_default"      => "262144",
  
    # Decrease the time default value for tcp_fin_timeout connection
    "net.ipv4.tcp_fin_timeout"    => "30",
   
    # Decrease the time default value for tcp_keepalive_time connection
    "net.ipv4.tcp_keepalive_time" => "1800",
   
    # support large window scaling RFC 1323
    "net.ipv4.tcp_window_scaling" => "1",
    
    # Filesystem I/O is usually much more efficient than swapping, so try to
    # keep swapping low.  It's usually safe to go even lower than this on
    # systems with server-grade storage.
    "vm.swappiness" => "0",
   
    # If a workload mostly uses anonymous memory and it hits this limit, the
    # entire working set is buffered for I/O, and any more write buffering
    # would require swapping, so it's time to throttle writes until I/O can
    # catch up.  Workloads that mostly use file mappings may be able to use
    # even higher values.
    "vm.dirty_ratio" => "50",

    # Controls the System Request debugging functionality of the kernel
    "kernel.sysrq" => 1, 

    # reboot on panic
    "kernel.panic" => 30, 
    
    # Boost up the number of open files for mongodb
    "fs.file-max" => 102400
  }
)
