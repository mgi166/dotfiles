require './rake/installer'

namespace :dotfiles do
  desc 'install all dotfiles in your home / if you give an argument, install only that you select'
  task :install, :file do |t, args|
    args.with_defaults(file: Installer.items)
    files = [].tap {|array| array << args[:file]}.flatten
    files.each { |f| Installer.install_file(f) }
  end

  desc 'uninstall all dotfiles in your home'
  task :uninstall do
    Installer.items.each {|i| Installer.uninstall_file(i) }
    puts 'done uninstall'
  end

  desc 'backup all your dotfiles at present'
  task :backup do
    Installer.backup
  end

  desc 'The target list of files or directories to install'
  task :list do
    puts Installer.items
  end

  desc 'debug task'
  task :hoge do
  end
end
