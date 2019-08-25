package commands

import "github.com/calvinchengx/dotfiles/fileops"

func packageManagers(goos string) {
	switch goos {
	case "darwin":
		if fileops.CheckExists("brew") {
			homeBrewUpgrade()
		} else {
			homeBrewInstall()
		}
	case "linux":
	default:
	}
}
