namespace :dotfiles do
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

  desc 'install all dotfiles in your home'
  task :install do
  end

  desc 'create symbolic link that files in dotfiles connect each files on your home'
  task :symlink do
    files.each do |f|
      File.symlink(f, f[/^\.(.*)/, 1])
    end
  end
end
