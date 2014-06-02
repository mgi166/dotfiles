class Installer
  DEFAULT_PATH = File.expand_path('~')
  BLACKLIST_FILE_NAME = ['.', '..','.DS_Store', '.git', '.gitmodules']

  class << self
    def install(file)
      new(file).install
    end

    def uninstall(file)
      new(file).uninstall
    end

    def items
      Dir.glob('.*').reject {|item| BLACKLIST_FILE_NAME.include?(item) }
    end

    def backup(file)
      new(file).do_backup
    end
  end

  def initialize(file)
    @file = file
  end

  def do_backup
    unless File.symlink?(destination_path)
      if backup?
        FileUtils.mkdir('backup', verbose: true) unless File.exist?('./backup')
        FileUtils.rm_r(backup_path, verbose: true, secure: true) if File.exist?(backup_path)
        FileUtils.cp_r(destination_path, backup_path, verbose: true)
      end
    end
  end

  def install
    if File.exist?(destination_path)
      if continue?
        do_backup
        put_symlink
      end
    else
      put_symlink
    end
  end

  def put_symlink
    FileUtils.rm_r(destination_path, verbose: true, secure: true) if File.exist?(destination_path)
    FileUtils.symlink(File.expand_path(@file), destination_path, verbose: true)
  end

  def uninstall
    if File.exist?(destination_path)
      FileUtils.rm_r(destination_path, verbose: true, secure: true)
    else
      puts "`#{destination_path}' don't exist"
    end
  end

  private

  def backup?
    print "Backup current your dotfiles? `#{destination_path}' [y|n] "
    STDIN.gets.chomp =~ /\A(y|yes)\Z/i ? true : false
  end

  def backup_path
    File.join('.', 'backup', @file)
  end

  def continue?
    print "`#{destination_path}' is already existed. Continue to install? [y|n] "
    STDIN.gets.chomp =~ /\A(y|yes)\Z/i ? true : false
  end

  def destination_path
    File.join(DEFAULT_PATH, @file)
    #    File.join 'test', file
  end
end
