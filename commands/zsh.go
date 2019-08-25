package commands

import (
	"fmt"
	"log"
	"os/exec"
)

func zsh(goos string) {
	switch goos {
	case "darwin":
		exist, path := checkExistsWithPath("zsh")
		install := exist == false || exist == true && path != "/usr/local/bin/zsh"
		if install {
			installPackage("zsh", goos)
		}
	case "linux":
	default:
		install := checkExists("zsh") == false
		if install {
			installPackage("zsh", goos)
		}
	}
}

func zshInstallWith(packageManagerName string) error {
	fmt.Printf("Install vim\n")
	cmd := exec.Command(packageManagerName, "install", "zsh")
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
