package fileops

import (
	"fmt"
	"log"
	"os/exec"
	"path"
)

func (p *Profile) homeBrewUpgrade() error {
	pathString := path.Join(p.HomeDir, p.DotfilesDir, "scripts", "homebrew_upgrade.sh")
	cmd := exec.Command("bash", pathString)
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}

func (p *Profile) homeBrewInstall() error {
	fmt.Printf("Installing homebrew\n")
	pathString := path.Join(p.HomeDir, p.DotfilesDir, "scripts", "homebrew.sh")
	cmd := exec.Command("bash", pathString)
	out, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf(string(out))
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
