#
# Cookbook Name:: Resque monitoring
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

include_recipe "postfix"

directory "#{node[:checking_resque_path]}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cookbook_file "#{node[:checking_resque_path]}/checking_resque_workers.sh" do
  source "checking_resque_workers.sh" 
  mode 755
  owner 'root'
  group 'root'
end


cron "Checking Resque workers and schedulers" do
	  user 'root'
    minute "*/5"
	  command "bash #{node[:checking_resque_path]}/checking_resque_workers.sh"
    mailto "binh@misfitwearables.com"
	  action :create
end