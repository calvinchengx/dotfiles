package commands

import (
	"fmt"
	"log"
	"os/exec"
	"path"

	"github.com/calvinchengx/dotfiles/fileops"
)

func vim(goos string, homedir string) {
	switch goos {
	case "darwin":
		exist, path := fileops.CheckExistsAgainstPath("vim")
		install := exist == false || exist == true && path != "/usr/local/bin/vim"
		if install {
			fileops.InstallPackage("vim", goos)
		}
	case "linux":
	default:
		install := fileops.CheckExists("vim") == false
		if install {
			fileops.InstallPackage("vim", goos)
		}
	}
}

func vimPlugDependencies(homedir string) error {
	fmt.Printf("Install vim's plug dependencies\n")
	filePath := path.Join(homedir, dotfilesDir, "scripts", "vimplug_install.sh")
	cmd := exec.Command("bash", filePath)
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
