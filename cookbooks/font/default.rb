execute "install hackgen" do
  command = "brew tap homebrew/cask-fonts"
  not_if "brew list | grep font-hackgen"
end

package "font-hackgen"
package "font-hackgen-nerd"
