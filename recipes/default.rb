#
# Cookbook Name:: haskell-dev
# Recipe:: default
#
# Copyright (C) 2014 David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

# Environment

include_recipe "my-environment"

git "clone haskell-redo" do
  repository "git@github.com:dsaenztagarro/haskell-redo.git"
  reference "master"
  action :sync
  destination "#{node['my-environment']['projects_path']}/redo"
end

include_recipe "my-environment::permissions"

# Backend

execute "install_haskell_platform" do
  command "apt-get install haskell-platform -y"
end
