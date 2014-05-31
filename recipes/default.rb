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
# include_recipe "my-environment::gui"

# Backend

# ATENTION: Install process requires at least 4096mb RAM

execute "install_opengl" do
  command <<-EOH
    sudo apt-get install libgl1-mesa-dev libglc-dev freeglut3-dev libedit-dev libglw1-mesa libglw1-mesa-dev -y
  EOH
end

execute "install_ghc763" do
  command <<-EOH
    cd /tmp
    aptitude install -y libgmp3c2 libgmp3-dev
    ln -s /usr/lib/x86_64-linux-gnu/libgmp.so.10.0.5 /usr/lib/libgmp.so.3
    wget https://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2
    tar xvf ghc-7.6.3-x86_64-unknown-linux.tar.bz2
    cd ghc-7.6.3
    ./configure
    make install
  EOH
end

execute "install_haskell_platform" do
  command <<-EOH
    cd /tmp
    wget http://lambda.haskell.org/platform/download/2013.2.0.0/haskell-platform-2013.2.0.0.tar.gz
    tar xvf haskell-platform-2013.2.0.0.tar.gz
    cd haskell-platform-2013.2.0.0
    ./configure
    make install
  EOH
end

# Install recent versions of alex (the Haskell lexer generator) and happy (the
# Haskell parser generator).
execute "install_haskell_dev_tools" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
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

# Inside project:
# cabal sandbox init
