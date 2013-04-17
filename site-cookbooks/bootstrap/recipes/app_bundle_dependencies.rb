#
# Cookbook Name:: bootstrap
# Recipe:: app_bundle_dependencies
#
# Copyright 2013, Gameimprovement 
#
# All rights reserved - Do Not Redistribute
#
# Install XML libraries in order to allow Nokogiri to build
package "libxml2"
package "libxml2-dev"
package "libxslt1-dev"
