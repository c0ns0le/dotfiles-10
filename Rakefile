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
  symlink src_path, dest_path
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

def replace_file(file)
  FileUtils.rmtree "$HOME/.#{file.sub(/\.erb$/, '')}"
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    
    if File.exists? "#{ENV['HOME']}/.#{file}"
      puts "~/.#{file} already exists"
    else
      puts "linking ~/.#{file}"
      symlink "#{Dir.pwd}/#{file}", "#{ENV['HOME']}/.#{file}"
    end
  end
end

def install_file src_file, dest_path
  replace_all = false
  unless File.directory? dest_path
    FileUtils.mkdir_p(dest_path)
  end
  if File.exist?(File.join(dest_path, ".#{src_file.sub(/\.erb$/, '')}"))
    if File.identical? src_file, File.join(dest_path, ".#{src_file.sub(/\.erb$/, '')}")
      puts "identical ~/.#{src_file.sub(/\.erb$/, '')}"
    elsif replace_all
      replace_file(file)
    else
      print "overwrite ~/.#{src_file.sub(/\.erb$/, '')}? [ynaq] "
      case $stdin.gets.chomp
      when 'a'
        replace_all = true
        replace_file(src_file)
      when 'y'
        replace_file(src_file)
      when 'q'
        exit
      else
        puts "skipping ~/.#{src_file.sub(/\.erb$/, '')}"
      end
    end
  else
    link_file(src_file)
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

  desc "install bashrc into user's home directory"
  task :bashrc do
    files = ['bashrc']
      files.each do |file|
      install_file src_file = file, dest_path = ENV['HOME']
    end
  end

  desc "install zshrc into user's home directory"
  task :zshrc do
    files = ['zshrc']
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

  desc 'Install RVM'
  task :rvm do
    `curl -sSL https://get.rvm.io | sh`
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
end
