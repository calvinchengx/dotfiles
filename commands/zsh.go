package commands

import (
	"github.com/calvinchengx/dotfiles/exec"
	"github.com/calvinchengx/dotfiles/fileops"
)

func zsh(goos string) {

	e := fileops.E{
		Exec: exec.New(),
	}

	switch goos {
	case "darwin":
		exist, path := e.CheckExistsAgainstPath("zsh")
		install := exist == false || exist == true && path != "/usr/local/bin/zsh"
		if install {
			fileops.InstallPackage("zsh", goos)
		}
	case "linux":
	default:
		install := e.CheckExists("zsh") == false
		if install {
			fileops.InstallPackage("zsh", goos)
		}
	}
}
