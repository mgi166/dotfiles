shared_examples 'git' do
  describe command('git --version') do
    its(:stdout) { should match /\Agit/ }
  end
end
