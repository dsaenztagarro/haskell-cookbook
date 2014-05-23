#
# Cookbook Name:: haskell
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Environment

home_dir = "/home/vagrant"
development_dir = "#{home_dir}/Development"
projects_dir = "#{development_dir}/projects"

include_recipe 'apt'
include_recipe 'vim'
include_recipe 'git'

directory projects_dir do
  owner 'vagrant'
  group 'vagrant'
  recursive true
end

git "clone pyckio-frontend" do
  repository "hgit@github.com:dsaenztagarro/haskell-redo.git"
  reference "master"
  action :sync
  destination "#{projects_dir}/redo"
end

git "clone dotfiles" do
  repository "git@github.com:dsaenztagarro/dotfiles.git"
  reference "master"
  action :sync
  destination "#{projects_dir}/dotfiles"
end

git "clone solarized" do
  repository "git@github.com:altercation/solarized.git"
  reference "master"
  action :sync
  destination "#{projects_dir}/solarized"
end

directory "/home/vagrant/.vim/bundle" do
  owner 'vagrant'
  group 'vagrant'
  recursive true
end

git "clone vundle.vim" do
  repository "git@github.com:gmarik/Vundle.vim.git"
  reference "master"
  action :sync
  destination "/home/vagrant/.vim/bundle/Vundle.vim"
end

execute "install_vim_plugins" do
  command "vim +BundleInstall +qall"
end

# Backend

install_recipe "haskell::source"
