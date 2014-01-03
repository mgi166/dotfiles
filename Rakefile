namespace :dotfiles do
  DEFAULT_PATH = File.expand_path('~')
  BLACKLIST_FILE_NAME = ['README.md', 'backup', 'Rakefile']

  def items
    [].tap do |result|
      Dir.glob('*'){ |item| result << item unless BLACKLIST_FILE_NAME.include?(item) }
    end
  end

  def backup?(file)
    print "Backup current your dotfiles? `#{file}' [y|n] "
    STDIN.gets.chomp =~ /\A(y|yes)\Z/i ? true : false
  end

  def destination_path(file)
#    File.join(DEFAULT_PATH, file)
    File.join 'test', file
  end

  def backup_path(file)
    File.join('backup', file)
  end

  def do_backup(file)
    FileUtils.remove_entry_secure(backup_path(file))       if File.exist?(backup_path(file))
    FileUtils.cp_r(file, backup_path(file), verbose: true) if File.exist?(destination_path(file))
  end

  def do_symlink(file)
    FileUtils.remove_entry_secure(destination_path(file)) if File.exist?(destination_path(file))
    FileUtils.symlink(File.expand_path(file), destination_path(file), verbose: true)
  end

  desc 'install all dotfiles in your home'
  task :install do
    Rake::Task['dotfiles:symlink'].invoke
    puts 'Thank you for your install'
  end

  desc 'custom install that you select a file'
  task :install, :file do |t, args|
    if File.exist?(destination_path(args[:file])) and !File.symlink?(destination_path(args[:file]))
      Dir.mkdir('./backup') unless File.exist?('backup')
      do_backup(args[:file]) if backup?(args[:file])
      puts "Done backup to `#{File.expand_path(backup_path(args[:file]))}'"
    end

    do_symlink(args[:file])
  end

  desc 'create symbolic link that all files in dotfiles connect each home files'
  task :symlink do
    items.each do |i|
      if File.exist?(destination_path(i)) and !File.symlink?(destination_path(i))
        Dir.mkdir('./backup') unless File.exist?('backup')
        do_backup(i) if backup?(i)
        puts "Done backup to `#{File.expand_path(backup_path(i))}'"
      end

      do_symlink(i)
    end
  end

  desc 'uninstall all dotfiles in your home'
  task :uninstall do
    items.each {|i| FileUtils.remove_entry_secure(destination_path(i)) if File.exist?(destination_path(i)) }
    puts 'done uninstall'
  end

  desc 'backup all your dotfiles at present'
  task :backup do
    items.each do |i|
      if File.exist?(destination_path(i)) and !File.symlink?(destination_path(i))
        Dir.mkdir('./backup') unless File.exist?('backup')
        do_backup(i) if backup?(i)
        puts "Done backup to `#{File.expand_path(backup_path(i))}'"
      end
    end
  end

  desc 'The target list of files or directories to install'
  task :list do
    puts items
  end

  desc 'debug task'
  task :hoge do
  end
end
