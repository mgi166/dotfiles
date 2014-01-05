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

  def backup(file)
    if File.exist?(destination_path(file)) and !File.symlink?(destination_path(file))
      Dir.mkdir('./backup') unless File.exist?('backup')
      if backup?(file)
        do_backup(file)
        puts "Done backup to `#{File.expand_path(backup_path(file))}'"
      end
    end

    yield(file) if block_given?
  end

  desc 'install all dotfiles in your home / if you give an argument, install only that you select'
  task :install, :file do |t, args|
    args.with_defaults(file: items)
    files = [].tap {|array| array << args[:file]}.flatten

    files.each do |f|
      backup(f)
      do_symlink(f)
    end
  end

  desc 'uninstall all dotfiles in your home'
  task :uninstall do
    items.each {|i| FileUtils.remove_entry_secure(destination_path(i)) if File.exist?(destination_path(i)) }
    puts 'done uninstall'
  end

  desc 'backup all your dotfiles at present'
  task :backup do
    [].tap do |array|
      items.each do |item|
        backup(item) do |i|
          array << i if File.exist? backup_path(i)
        end
      end
    end.tap do |result|
      puts "Done nothing because target files is symlink or don't exist" if result.empty?
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
