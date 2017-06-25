require 'serverspec'
require 'net/ssh'

set :backend, :ssh

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

options = Net::SSH::Config.for(host)

options[:user] = 'ubuntu'
options[:keys] = '.vagrant/machines/default/virtualbox/private_key'

set :host,        ENV['TARGET_HOST'] || "192.168.33.10"
set :ssh_options, options

# Disable sudo
set :disable_sudo, true

Dir['./spec/shared/*'].each { |f| require f }

# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
