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

projects_path = node['my-environment']['projects_path']

git "clone haskell-redo" do
  repository "git@github.com:dsaenztagarro/haskell-redo.git"
  reference "master"
  action :sync
  destination "#{projects_path}/redo"
end

include_recipe "my-environment::permissions"
include_recipe "my-environment::gui"

# Backend

# ATENTION: Install process requires at least 4096mb RAM

execute "install_haskell_platform" do
  command <<-EOH
    apt-get install haskell-platform -y
  EOH
end

# Install recent versions of alex (the Haskell lexer generator) and happy (the
# Haskell parser generator).
execute "install_haskell_dev_tools" do
  command <<-EOH
    cabal update
    cabal install -g cabal-install
    cabal install -g alex
    cabal install -g happy
    cabal install -g haskell-src-exts
    cabal install -g hlint
    cabal install -g ghc-mod
    cabal install -g hdevtools
    cabal install -g pointfree
  EOH
end

# Parallel and Concurrent Programming in Haskell

execute "install_threadscope" do
  command "apt-get install threadscope -y"
end


# Install modern version of cabal with 'sandbox' command
# execute "install_cabal" do
#   command <<-EOH
#     cd /tmp
#     git clone https://github.com/haskell/cabal.git
#     cd cabal
#     git checkout Cabal-v1.18.1.2
#     cabal update
#     cabal install Cabal/ cabal-install/
#     cabal install cabal-install
#   EOH
# end

# Inside project:
# cabal sandbox init
