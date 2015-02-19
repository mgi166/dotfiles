Pry.config.prompt = [ proc { ">> " }, proc { "| " }]
Pry.config.editor = proc { |file| "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n #{file}" }

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end
