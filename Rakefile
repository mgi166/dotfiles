namespace :dotfiles do
  DEFAULT_PATH = File.expand_path('~')
  BLACKLIST_FILE_PATTERN = ['README.md', 'backup']

  def items
    [].tap do |result|
      Dir.glob('*'){ |item| result << item unless BLACKLIST_FILE_PATTERN.include?(item) }
    end
  end

  def re_install?
    print 'Dotfiles is already installed. Remove all dotfiles, and re-install new dotfiles? [y|n] '
    if STDIN.gets.chomp =~ /\A(y|yes)\Z/i
      true
    else
      false
    end
  end

  def backup?
    print 'backup? [y|n] '

    if STDIN.gets.chomp =~ /\A(y|yes)\Z/i
      true
    else
      false
    end
  end

  def destination_path(file)
#    File.join(DEFAULT_PATH, file)
    file[/^\.(.*)/, 1]
  end

  desc 'install all dotfiles in your home'
  task :install do
    Rake::Task['dotfiles:symlink'].invoke
    puts 'Thank you for your install'
  end

  desc 'create symbolic link that all files in dotfiles connect each home files'
  task :symlink do
    items.each do |f|
      File.symlink(f, destination_path(f))
    end
  end

  desc 'uninstall all dotfiles in your home'
  task :uninstall do
    items.each do |i|
      File.delete(destination_path(i))
    end
    puts 'done uninstall'
  end

  desc 'backup all your dotfiles at present'
  task :backup do
    Dir.mkdir('./backup') unless File.exist?('backup')
    if backup?
      items.each do |i|
        path = File.symlink?(destination_path(i)) ? File.readlink(destination_path(i)) : destination_path(i)
        p i
        FileUtils.cp_r(path, File.join('backup', destination_path(i)), verbose: true) if File.exist? destination_path(i)
      end
    end
  end

  desc 'test task'
  task :hoge do
    p items
  end
end
