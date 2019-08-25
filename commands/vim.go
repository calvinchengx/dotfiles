package commands

import (
	"fmt"
	"log"
	osexec "os/exec"
	"path"

	"github.com/calvinchengx/dotfiles/exec"
	"github.com/calvinchengx/dotfiles/fileops"
)

func vim(goos string, homedir string) {

	e := fileops.E{
		Exec: exec.New(),
	}

	switch goos {
	case "darwin":
		exist, path := e.CheckExistsAgainstPath("vim")
		install := exist == false || exist == true && path != "/usr/local/bin/vim"
		if install {
			fileops.InstallPackage("vim", goos)
		}
	case "linux":
	default:
		install := e.CheckExists("vim") == false
		if install {
			fileops.InstallPackage("vim", goos)
		}
	}
}

func vimPlugDependencies(homedir string) error {
	fmt.Printf("Install vim's plug dependencies\n")
	filePath := path.Join(homedir, dotfilesDir, "scripts", "vimplug_install.sh")
	cmd := osexec.Command("bash", filePath)
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
