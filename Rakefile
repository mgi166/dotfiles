namespace :dotfiles do
  DEFAULT_PATH = File.expand_path('~')
  BLACKLIST_FILE_NAME = ['.', '..', '.git']

  def items
    [].tap do |result|
      Dir.glob('.*'){ |item| result << item unless BLACKLIST_FILE_NAME.include?(item) }
    end
  end

  def destination_path(file)
    File.join(DEFAULT_PATH, file)
    #    File.join 'test', file
  end

  def backup_path(file)
    File.join('backup', file)
  end

  def backup?(file)
    print "Backup current your dotfiles? `#{destination_path(file)}' [y|n] "
    STDIN.gets.chomp =~ /\A(y|yes)\Z/i ? true : false
  end

  def symlink?(file)
    print "`#{destination_path(file)}' is already exist. Continue to install? [y|n] "
    STDIN.gets.chomp =~ /\A(y|yes)\Z/i ? true : false
  end

  def do_backup(file)
    if File.exist? destination_path(file) and !File.symlink? destination_path(file)
      if backup?(file)
        FileUtils.remove_entry_secure(backup_path(file))
        FileUtils.cp_r(destination_path(file), backup_path(file), verbose: true)
      end
    end
    yield(file) if block_given?
  end

  def put_symlink(file)
    FileUtils.remove_entry_secure(destination_path(file)) if File.exist?(destination_path(file))
    FileUtils.symlink(File.expand_path(file), destination_path(file), verbose: true)
  end

  def installing(file)
    if File.exist? destination_path(file)
      if symlink?(file)
        do_backup(file)
        put_symlink(file)
      end
    else
      do_backup(file)
      put_symlink(file)
    end
  end

  def uninstall(file)
    FileUtils.remove_entry_secure(destination_path(file)) if File.exist?(destination_path(file))
  end

  desc 'install all dotfiles in your home / if you give an argument, install only that you select'
  task :install, :file do |t, args|

    args.with_defaults(file: items)
    files = [].tap {|array| array << args[:file]}.flatten
    files.each { |f| installing(f) }
  end

  desc 'uninstall all dotfiles in your home'
  task :uninstall do
    items.each {|i| uninstall(i) }
    puts 'done uninstall'
  end

  desc 'backup all your dotfiles at present'
  task :backup do
    [].tap do |array|
      items.each do |item|
        do_backup(item) do |i|
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
    do_backup '.gitignore'
  end
end
