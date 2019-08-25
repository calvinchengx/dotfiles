package fileops

import (
	"fmt"
	"log"
	"os/exec"
)

// InstallPackage allows us install a package in an os-agnostic fashion
func InstallPackage(pkg, goos string) error {
	fmt.Printf("Install %s\n", pkg)
	var cmd *exec.Cmd
	switch goos {
	case "darwin":
		cmd = exec.Command("brew", "install", pkg)
	case "linux":
	default:
		cmd = exec.Command("apt", "install", pkg)
	}
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
