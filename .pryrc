Pry.config.prompt = [ proc { ">> " }, proc { "| " }]
Pry.config.editor = proc { |file| "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n #{file}" }

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

if defined?(PryStackExplorer)
  Pry.commands.alias_command 'sh', 'show-stack'
  Pry.commands.alias_command 'u', 'up'
  Pry.commands.alias_command 'd', 'down'
  Pry.commands.alias_command 'fr', 'frame'
end
