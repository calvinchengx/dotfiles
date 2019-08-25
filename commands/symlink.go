package commands

import (
	"fmt"
	"os"
	"path"
	"path/filepath"
)

func symlinkFilesInDirectory(homedir string, targetDir string, verbose bool) {
	fmt.Printf("Symlink files in %s\n", targetDir)

	var files []string

	dotvimDir := path.Join(homedir, dotfilesDir, targetDir)
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
		target := path.Join(homedir, filepath.Base(source))
		if verbose {
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
