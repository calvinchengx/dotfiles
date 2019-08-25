package commands

import (
	"github.com/calvinchengx/dotfiles/exec"
	"github.com/calvinchengx/dotfiles/fileops"
)

func packageManagers(goos string) {

	e := fileops.E{
		Exec: exec.New(),
	}

	switch goos {
	case "darwin":
		if e.CheckExists("brew") {
			homeBrewUpgrade()
		} else {
			homeBrewInstall()
		}
	case "linux":
	default:
	}
}
