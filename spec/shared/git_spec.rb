shared_examples 'git' do
  describe package('git') do
    it { should be_installed }
  end
end
