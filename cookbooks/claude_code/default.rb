skills_path = File.expand_path("cookbooks/claude_code/files/.claude/skills")

directory File.expand_path("~/.claude/skills")

Dir.glob("#{skills_path}/*/").each do |skill_dir|
  skill_name = File.basename(skill_dir)

  link File.expand_path("~/.claude/skills/#{skill_name}") do
    to skill_dir
    force true
  end
end
