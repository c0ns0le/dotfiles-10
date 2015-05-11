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
    files = ['vimrc']
    files.each do |file|
      install_file src_file = file, dest_path = ENV['HOME']
    end
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

  desc "install sublime (3) packages"
  task :sublime_pkgs do
    host_os = RUBY_PLATFORM
    file = "#{Dir.pwd}/Sublime/User"
    case host_os
    when /darwin|mac os/
      dest_path = "#{ENV['HOME']}/Library/Application\ Support/Sublime\ Text\ 3/Packages/"
      rm_rf("#{dest_path}/User")
      link_dir src_path = file, dest_path = dest_path
    else
      puts 'OS Not Configured'
    end
  end

  desc 'Install Oh My ZSH'
  task :zsh do
    `curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh`
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

  # @TODO: Task is broken. Fix later.
  # desc 'Install vim plugins'
  # task :vim_plugins do
  #   files = ["#{Dir.pwd}/vim"]
  #   files.each do |file|
  #     link_dir src_file = file, dest_path = "#{ENV['HOME']}/.vim"
  #   end
  # end
end
namespace :config do
  desc "Configure AWS paths [ZSH only]"
  task :aws_paths do
    awsplugin_path = "#{ENV['HOME']}/.oh-my-zsh/custom/plugins/aws"
    files = ['aws.plugin.zsh']
    files.each do |file|
      install_file src_file = file, dest_path = "#{awsplugin_path}"
    end
  end

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

