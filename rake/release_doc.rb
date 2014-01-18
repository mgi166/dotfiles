require 'erb'
require 'date'

class ReleaseDoc
  DEFALUT_PATH = './release_doc_templates.erb'

  attr_reader
  def initialize
    @file = File.read(DEFALUT_PATH)
    @date = Date.today.strftime("%Y%m%d")
  end

  def generate
    ERB.new(@file).result(binding)
  end

  def create_bindings
  end

  def checket
    print 'Enter release checket number: '
    @checket = STDIN.gets.chomp.gsub(/#/, '')
  end

  # TODO
  def tag
  end

  # TODO: create class svn command?
  def svn_diff
  end
end

namespace :release_doc do
  desc 'generate templates'
  task :generate do
    puts ReleaseDoc.new.generate
  end
end
