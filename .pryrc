Pry.config.prompt = [ proc { ">> " }, proc { "| " }]
Pry.config.editor = proc { |file| "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n #{file}" }
