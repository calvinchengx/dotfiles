package depsvim

import (
	"fmt"
	"log"
	osexec "os/exec"
	"path"

	"github.com/calvinchengx/dotfiles/fileops"
)

// PlugDependencies executes a script that installs plug-managed dependencies
func PlugDependencies(p *fileops.Profile) error {
	fmt.Printf("Install vim's plug dependencies\n")
	filePath := path.Join(p.HomeDir, p.DotfilesDir, "scripts", "vimplug_install.sh")
	cmd := osexec.Command("bash", filePath)
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Printf("combined out:\n%s\n", string(out))
	return nil
}
