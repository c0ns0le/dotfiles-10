require 'rake'
require 'erb'
require 'find'
require 'fileutils'

def get_files
  home_files = Dir["#{ENV['HOME']}/.*"]
  home_files = home_files | Dir["#{ENV['HOME']}/.*/*"]
  return home_files.sort
end

def link_dir(src_path, dest_path)
  symlink src_path, dest_path, :force
end

def write_login items
  file = 'bash_login'
  File.open(file, 'w') do |f|
    items.each do |item|
      f.puts "source $HOME/#{item}"
    end
  end
  unless File.symlink? "#{ENV['HOME']}/.#{file}"
    symlink "#{Dir.pwd}/#{file}", "#{ENV['HOME']}/.#{file}"
  end
end

task :default do
end

namespace :install do
  desc "install vimrc into user's home directory"
  task :vimrc do
    system("ln -sin #{File.dirname(__FILE__)}/vimrc #{ENV['HOME']}/.vimrc")
  end

  desc "install git aliases for bashrc"
  task :gitrc do
    files = ['vcs/git.bashrc']
    files.each do |file|
      install_file src_file = file, dest_path = "#{ENV['HOME']}/.vcs"
    end
  end

  desc "install perforce aliases for bashrc"
  task :perforcerc do
    files = ['vcs/perforce.bashrc']
    files.each do |file|
      install_file src_file = file, dest_path = "#{ENV['HOME']}/.vcs"
    end
  end

  desc 'Install F.lux for OS X'
  task :flux do
    `wget https://justgetflux.com/mac/Flux.zip`
    `unzip Flux.zip`
    `mv Flux.app /Applications`
    `rm Flux.zip`
  end

  desc 'Install Homebrew (OS X)'
  task :brew do
    system('ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
    system('brew tap homebrew/bundle')
    system('brew bundle')
  end

  desc 'Install vim plugins'
  task :vim_plugins do
    system("git clone https://github.com/gmarik/Vundle.vim.git #{ENV['HOME']}/.vim/bundle/Vundle.vim")
    system('vim +PluginInstall +qall')
  end
end

namespace :config do
  desc 'Configure bashrc'
  task :bashrc do
    files = ["#{Dir.pwd}/bash/bashrc"]
    files.each do |file|
      symlink file, "#{ENV['HOME']}/.bashrc", :force => true
    end
  end

  desc 'Configure zshrc'
  task :zshrc do
    File.write('/Users/ali/.zshrc', "source #{File.dirname(__FILE__)}/zsh/zshrc") unless File.readable?('/Users/ali/.zshrc')
    system('git submodule update --init --recursive')
  end

  desc 'create ssh dir'
  task :ssh do
    system('mkdir ~/.ssh')
    system('chmod 0700 ~/.ssh')
    system('ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa')
  end

  desc 'link atom dir'
  task :atom do
    system("ln -sin #{File.dirname(__FILE__)}/atom #{ENV['HOME']}/atom")
    system("mv #{ENV['HOME']}/atom #{ENV['HOME']}/.atom")
  end

  desc 'link tmux conf'
  task :tmux do
    system("ln -sin #{File.dirname(__FILE__)}/tmux.conf #{ENV['HOME']}/.tmux.conf")
  end
end

