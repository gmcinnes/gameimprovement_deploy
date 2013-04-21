#
# Cookbook Name:: site-postfix 
# Recipe:: install_postfix_credentials 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Pull the SASL credentials to connect to the SMTP server
# we relay through, and install them in Postfix
secrets = data_bag_item("secrets", "gmail")
gmail_username = secrets['username']
gmail_password = secrets['password']

node.set['postfix']['smtp_sasl_user_name'] = gmail_username
node.set['postfix']['smtp_sasl_passwd'] = gmail_password
include_recipe "postfix::sasl_auth"
