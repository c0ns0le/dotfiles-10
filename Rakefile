require 'rake'
require 'erb'
require 'find'
require 'fileutils'

def get_files
  home_files = Dir["#{ENV['HOME']}/.*"]
  home_files = home_files | Dir["#{ENV['HOME']}/.*/*"]
  return home_files.sort
end

task :default do
  Rake::Task['install_vimrc'].invoke
  Rake::Task['install_bashrc'].invoke
  Rake::Task['install_gitrc'].invoke
  Rake::Task['install_perforcerc'].invoke
end

desc "install vimrc into user's home directory"
task :install_vimrc do
  files = ['vimrc']
  files.each do |file|
    install_file src_file = file, dest_path = ENV['HOME']
  end
end

desc "install bashrc into user's home directory"
task :install_bashrc do
  files = ['bashrc']
  files.each do |file|
    install_file src_file = file, dest_path = ENV['HOME']
  end
end

desc "install git aliases for bashrc"
task :install_gitrc do
  files = ['vcs/git.bashrc']
  files.each do |file|
    install_file src_file = file, dest_path = "#{ENV['HOME']}/.vcs"
  end
end

desc "install perforce aliases for bashrc"
task :install_perforcerc do
  files = ['vcs/perforce.bashrc']
  files.each do |file|
    install_file src_file = file, dest_path = "#{ENV['HOME']}/.vcs"
  end
end

desc "install sublime (3) packages"
task :install_sublime_pkgs do
  host_os = RUBY_PLATFORM
  file = "#{Dir.pwd}/Sublime/User"
  case host_os
  when /darwin|mac os/
    link_dir src_path = file, dest_path = "#{ENV['HOME']}/Library/Application\ Support/Sublime\ Text\ 3/Packages/User"
  else
    puts 'OS Not Configured'
  end
end

desc "Write bash_login"
task :login do
  home_files = get_files
  writeme = Array.new
  if home_files.include? "#{ENV['HOME']}/.vimrc"
    writeme.push '.vimrc'
  end
  if home_files.include? "#{ENV['HOME']}/.bashrc"
    writeme.push '.bashrc'
  end
  if home_files.include? "#{ENV['HOME']}/.vcs/git.bashrc"
    writeme.push '.vcs/git.bashrc'
  end
  if home_files.include? "#{ENV['HOME']}/.vcs/perforce.bashrc"
    writeme.push '.vcs/perforce.bashrc'
  end

  write_login writeme
end

def install_file src_file, dest_path
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

def link_dir(src_path, dest_path)
  symlink src_path, dest_path
end

def write_login items
  File.open('bash_login', 'w') do |f|
    items.each do |item|
      f.puts "source #{item}"
    end
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
