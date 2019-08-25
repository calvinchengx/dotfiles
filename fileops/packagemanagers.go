package fileops

import (
	"github.com/calvinchengx/dotfiles/exec"
)

// PackageManagers ensure that brew and apt are available in their respective OSes
func (p *Profile) PackageManagers() {

	e := E{
		Exec: exec.New(),
	}

	switch p.Goos {
	case "darwin":
		if e.CheckExists("brew") {
			p.homeBrewUpgrade()
		} else {
			p.homeBrewInstall()
		}
	case "linux":
	default:
		p.aptUpgrade()
	}
}
