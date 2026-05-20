claude_dir = File.expand_path("~/.claude")
files_path = File.expand_path("cookbooks/claude_code/files/.claude")

directory claude_dir

link "#{claude_dir}/settings.json" do
  to "#{files_path}/settings.json"
  force true
end

link "#{claude_dir}/scripts" do
  to "#{files_path}/scripts"
  force true
end

directory "#{claude_dir}/skills"

Dir.glob("#{files_path}/skills/*/").each do |skill_dir|
  skill_name = File.basename(skill_dir)

  link "#{claude_dir}/skills/#{skill_name}" do
    to skill_dir
    force true
  end
end
