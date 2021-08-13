package "git"

execute "tap PotatoLabs" do
  command "brew tap PotatoLabs/homebrew-git-redate"
  not_if "brew list | grep git-redate"
end

package "git-redate"
package "hub"
