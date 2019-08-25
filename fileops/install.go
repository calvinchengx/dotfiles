package fileops

import (
	"fmt"
	"log"
	osexec "os/exec"

	"github.com/calvinchengx/dotfiles/exec"
)

// MustInstallPackage will check if package already exists and installs it if it doesn't
func (p *Profile) MustInstallPackage(pkg string) {

	e := E{
		Exec: exec.New(),
	}

	switch p.Goos {
	case "darwin":
		exist, path := e.CheckExistsAgainstPath(pkg)
		install := exist == false || exist == true && path != "/usr/local/bin/"+pkg
		if install {
			p.installPackage(pkg)
		}
	case "linux":
	default:
		install := e.CheckExists(pkg) == false
		if install {
			p.installPackage(pkg)
		}
	}
}

// InstallPackage allows us install a package in an os-agnostic fashion
func (p *Profile) installPackage(pkg string) error {
	fmt.Printf("Install %s\n", pkg)
	var cmd *osexec.Cmd
	switch p.Goos {
	case "darwin":
		cmd = osexec.Command("brew", "install", pkg)
	case "linux":
	default:
		cmd = osexec.Command("apt", "install", pkg)
	}
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
