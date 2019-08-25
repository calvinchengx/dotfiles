package commands

import (
	"github.com/calvinchengx/dotfiles/fileops"
)

func zsh(goos string) {
	switch goos {
	case "darwin":
		exist, path := fileops.CheckExistsAgainstPath("zsh")
		install := exist == false || exist == true && path != "/usr/local/bin/zsh"
		if install {
			fileops.InstallPackage("zsh", goos)
		}
	case "linux":
	default:
		install := fileops.CheckExists("zsh") == false
		if install {
			fileops.InstallPackage("zsh", goos)
		}
	}
}
