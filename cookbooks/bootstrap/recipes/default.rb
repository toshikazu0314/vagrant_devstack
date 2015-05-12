#
# Cookbook Name:: bootstrap
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/apt/sources.list" do
  source 'sources.list.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

execute "apt-get" do
  command 'apt-get update'
end

%w{language-pack-en language-pack-ja git}.each do |pkg|
  package pkg do
    action :install
  end
end

user "stack" do
  supports :manage_home => true
  comment 'devstack user'
  home '/home/stack'
  shell '/bin/bash'
  action :create
end

template "/etc/sudoers.d/stack" do
  source 'sudoers.d.stack.erb'
  mode '0440'
  owner 'root'
  group 'root'
end

template "/etc/network/interfaces.d/eth2.cfg" do
  source 'eth2.cfg.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

git "/home/stack/devstack" do
  repository '/vagrant_openstack/devstack'
  user 'stack'
  group 'stack'
  action :checkout
end

template '/home/stack/devstack/local.conf' do
  source 'local.conf.erb'
  mode '0644'
  owner 'stack'
  group 'stack'
end

template '/home/stack/change-terminal-owner.sh' do
  source 'change-terminal-owner.sh.erb'
  mode '0755'
  owner 'stack'
  group 'stack'
end

template '/home/stack/http_proxy.sh' do
  source 'http_proxy.sh.erb'
  mode '0755'
  owner 'stack'
  group 'stack'
end

template '/home/stack/add_bridge_and_port.sh' do
  source 'add_bridge_and_port.sh.erb'
  mode '0755'
  owner 'stack'
  group 'stack'
end
