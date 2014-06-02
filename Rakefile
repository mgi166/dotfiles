require './rake/installer'

namespace :dotfiles do
  desc 'install dotfiles in your home / if you give arguments, install only that you select'
  task :install do
    target_files = ENV['f']

    if target_files
      target_files = target_files.split(',')
      target_files.each {|i| Installer.install(i) }
    else
      Installer.items.each {|i| Installer.install(i) }
    end
  end

  desc 'uninstall all dotfiles in your home'
  task :uninstall do
    target_files = ENV['f']

    if target_files
      target_files = target_files.split(',')
      target_files.each {|i| Installer.uninstall(i) }
    else
      Installer.items.each {|i| Installer.uninstall(i) }
    end
  end

  desc 'backup all your dotfiles at present'
  task :backup do
    target_files = ENV['f']

    if target_files
      target_files = target_files.split(',')
      target_files.each {|i| Installer.backup(i) }
    else
      Installer.items.each {|i| Installer.backup(i) }
    end
  end

  desc 'The target list of files or directories to install'
  task :list do
    puts Installer.items
  end

  desc 'debug task'
  task :hoge do
    target_files = ARGV.drop(1)

    if target_files.empty?
      Installer.items.each {|i| Installer.backup(i) }
    else
      target_files.each {|i| Installer.backup(i) }
    end
  end
end
