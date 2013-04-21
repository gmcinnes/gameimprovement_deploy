#
# Cookbook Name:: bootstrap
# Recipe:: tweak_aliases_for_postfix 
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Add useful entries, such as root forwarding to /etc/aliases 
resources("template[/etc/aliases]").cookbook "site-postfix"
