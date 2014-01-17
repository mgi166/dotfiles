namespace :dotfiles do
  class Installer
    DEFAULT_PATH = File.expand_path('~')
    BLACKLIST_FILE_NAME = ['.', '..', '.git']

    def initialize(file)
      @file = file
    end

    def self.install_file(file)
      new(file).install_file
    end

    def self.uninstall_file(file)
      new(file).uninstall_file
    end

    def self.items
      [].tap do |result|
        Dir.glob('.*'){ |item| result << item unless BLACKLIST_FILE_NAME.include?(item) }
      end
    end

    def self.backup
      [].tap do |array|
        items.each do |i|
          ins = new(i)
          ins.do_backup
          array << ins.backup_path
        end
      end.tap do |result|
        puts "Done nothing because target files is symlink or don't exist" unless result.all?{|path| File.exist? path}
      end
    end

    def destination_path
      File.join(DEFAULT_PATH, @file)
      #    File.join 'test', file
    end

    def backup_path
      File.join('backup', @file)
    end

    def backup?
      print "Backup current your dotfiles? `#{destination_path}' [y|n] "
      STDIN.gets.chomp =~ /\A(y|yes)\Z/i ? true : false
    end

    def continue?
      print "`#{destination_path}' is already exist. Continue to install? [y|n] "
      STDIN.gets.chomp =~ /\A(y|yes)\Z/i ? true : false
    end

    def do_backup
      unless File.symlink? destination_path
        if backup?
          FileUtils.mkdir('backup') unless File.exist? 'backup'
          FileUtils.remove_entry_secure(backup_path) if File.exist? backup_path
          FileUtils.cp_r(destination_path, backup_path, verbose: true)
        end
      end
    end

    def put_symlink
      FileUtils.remove_entry_secure(destination_path) if File.exist?(destination_path)
      FileUtils.symlink(File.expand_path(@file), destination_path, verbose: true)
    end

    def install_file
      if File.exist? destination_path
        if continue?
          do_backup
          put_symlink
        end
      else
        put_symlink
      end
    end

    def uninstall_file
      FileUtils.remove_entry_secure(destination_path) if File.exist?(destination_path)
    end
  end

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
    do_backup '.gitignore'
  end
end
