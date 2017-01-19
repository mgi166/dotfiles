#!/bin/sh
set -ex

mitamae_version="1.3.2"
mitamae_cache="mitamae-${mitamae_version}"

if ! [ -f "bin/${mitamae_cache}" ]; then
  case "$(uname)" in
    "Linux")
      mitamae_bin="mitamae-x86_64-linux"
      ;;
    "Darwin")
      mitamae_bin="mitamae-x86_64-darwin"
      ;;
    *)
      echo "unexpected uname: $(uname)"
      exit 1
      ;;
  esac

  curl -o "bin/${mitamae_bin}.tar.gz" -sL "https://github.com/k0kubun/mitamae/releases/download/v${mitamae_version}/${mitamae_bin}.tar.gz"
  tar xvzf "bin/${mitamae_bin}.tar.gz"
  rm "bin/${mitamae_bin}.tar.gz"
  mv "${mitamae_bin}" "bin/${mitamae_cache}"
  chmod +x "bin/${mitamae_cache}"
fi

ln -sf "${mitamae_cache}" bin/mitamae

# FIXME: Always run Darwin recipe.
bin/mitamae local --node-json nodes/darwin_packages.json roles/darwin.rb