namespace :dotfiles do
  DEFAULT_PATH = File.expand_path('~')

  def files
    [].tap do |result|
      Dir.glob('.*'){ |item| result << item if File.file?(item) }
    end
  end

  # TODO: it should fix match pattern
  def dirs
    [].tap do |result|
      Dir.glob('.??*'){ |item| result << item if File.directory?(item) }
    end
  end

  def items
    files + dirs
  end

  def re_install?
    print 'Dotfiles is already installed. Remove all dotfiles, and re-install new dotfiles? [y|n] '
    if STDIN.gets.chomp =~ /\A(y|yes)\Z/i
      true
    else
      false
    end
  end

  desc 'install all dotfiles in your home'
  task :install do
    Rake::Task['dotfiles:symlink'].invoke
    puts 'done install'
  end

  desc 'create symbolic link that all files in dotfiles connect each home files'
  task :symlink do
    items.each do |f|
      File.symlink(f, f[/^\.(.*)/, 1])
    end
  end

  desc 'uninstall all dotfiles in your home'
  task :uninstall do
    items.each do |i|
      File.delete(i[/^\.(.*)/, 1])
    end
    puts 'done uninstall'
  end

  desc 'hoge'
  task :hoge do
    p re_install?
  end
end
