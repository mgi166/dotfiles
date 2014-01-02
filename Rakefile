namespace :dotfiles do
  DEFAULT_PATH = File.expand_path('~')
  BLACKLIST_FILE_NAME = ['README.md', 'backup', 'Rakefile']

  def items
    [].tap do |result|
      Dir.glob('*'){ |item| result << item unless BLACKLIST_FILE_NAME.include?(item) }
    end
  end

  def re_install?
    print 'Dotfiles is already installed. Remove all dotfiles, and re-install new dotfiles? [y|n] '
    STDIN.gets.chomp =~ /\A(y|yes)\Z/i ? true : false
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
    FileUtils.remove_entry_secure(destination_path(file)) if File.exist? destination_path(file)
    FileUtils.symlink(File.expand_path(file), destination_path(file), verbose: true)
  end

  desc 'install all dotfiles in your home'
  task :install do
    begin
      Rake::Task['dotfiles:symlink'].invoke
      puts 'Thank you for your install'
    rescue => e
      if re_install?
        Rake::Task['dotfiles:backup'].invoke if backup?
        Rake::Task['dotfiles:uninstall'].invoke
        retry
      end

      puts e.backtrace.unshift(e.message).join("\n")
      exit 1
    end
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
    items.each {|i| File.delete(destination_path(i)) if File.exist?(destination_path(i)) }
    puts 'done uninstall'
  end

  desc 'backup all your dotfiles at present'
  task :backup do
    Dir.mkdir('./backup') unless File.exist?('backup')
    if backup?
      items.each do |i|
        path = File.symlink?(destination_path(i)) ? File.readlink(destination_path(i)) : destination_path(i)
        FileUtils.remove_entry_secure(backup_path(i)) if File.exist? backup_path(i)
        FileUtils.cp_r(path, backup_path(i), verbose: true) if File.exist? destination_path(i)
      end
    end
  end

  desc 'The suject list of files or directories to install'
  task :list do
    puts items
  end

  desc 'debug task'
  task :hoge do
    p items
  end
end
