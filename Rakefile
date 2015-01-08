require_relative './lib/installer'

desc 'install dotfiles in your home / if you give arguments, install only that you select'
task :install do
  target_files = ARGV.drop(1)

  # override the filename task(ex. `.emacs` or `.gemrc`) to empty
  ARGV.drop(1).each do |file|
    task file.to_sym do; end
  end

  if target_files
    target_files.each {|i| Installer.install(i) }
  else
    Installer.items.each {|i| Installer.install(i) }
  end
end

desc 'uninstall all dotfiles in your home / if you give arguments, install only that you select'
task :uninstall do
  target_files = ARGV.drop(1)

  ARGV.drop(1).each do |file|
    task file.to_sym do; end
  end

  if target_files
    target_files.each {|i| Installer.uninstall(i) }
  else
    Installer.items.each {|i| Installer.uninstall(i) }
  end
end

desc 'backup all your dotfiles at present / if you give arguments, install only that you select'
task :backup do
  target_files = ARGV.drop(1)

  ARGV.drop(1).each do |file|
    task file.to_sym do; end
  end

  if target_files
    target_files.each {|i| Installer.backup(i) }
  else
    Installer.items.each {|i| Installer.backup(i) }
  end
end

desc 'The target list of files or directories to install'
task :list do
  puts Installer.items
end
