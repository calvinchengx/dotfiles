package fileops

import (
	"fmt"
	"os"
	"path"
	"path/filepath"
)

// SymlinkFilesInDirectory allows us to symlink all files found in a targetDirectory in .dotfiles folder
func (p *Profile) SymlinkFilesInDirectory(targetDir string) {
	fmt.Printf("Symlink files in %s\n", targetDir)

	var files []string

	dotvimDir := path.Join(p.HomeDir, p.DotfilesDir, targetDir)
	err := filepath.Walk(dotvimDir, func(path string, info os.FileInfo, err error) error {
		// exclude the directory itself
		if filepath.Base(path) != targetDir {
			files = append(files, path)
		}
		return nil
	})

	if err != nil {
		panic(err)
	}

	for _, source := range files {
		target := path.Join(p.HomeDir, filepath.Base(source))
		if p.Verbose {
			fmt.Printf("%s -> %s\n", target, source)
		}
		if _, err := os.Lstat(target); err == nil {
			if err := os.Remove(target); err != nil {
				fmt.Printf("failed to unlink: %+v", err)
			}
		} else if os.IsNotExist(err) {
			fmt.Printf("failed to check symlink: %+v", err)
		}
		// execute symlink
		os.Symlink(source, target)
	}
}
