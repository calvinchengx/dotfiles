package fileops

import (
	"fmt"
	"io/ioutil"
	"os"
	"path"

	"github.com/calvinchengx/dotfiles/static"
)

// Directory is the data structure to specify the behaviour for our directory and its files
type Directory struct {
	Name     string
	ModeDir  os.FileMode
	ModeFile os.FileMode
}

// DataDirectory allows to specify subdirectories that should exist in .dotfiles folder
func (p *Profile) DataDirectory() error {
	for _, dir := range p.Dirs {
		path := path.Join(p.HomeDir, p.DotfilesDir, dir.Name)
		err := os.MkdirAll(path, dir.ModeDir)
		if err != nil {
			return err
		}
		p.BoxFiles(dir.Name, dir.ModeFile)
	}
	return nil
}

// BoxFiles packages and retrieves files using packr library
// subdir can be "dotvim" or "scripts"
// perm can be 0755 or 0644
func (p *Profile) BoxFiles(subdir string, perm os.FileMode) {
	boxDotVim := static.PackFiles(subdir)
	files := boxDotVim.List()
	for _, file := range files {
		fileContent := boxDotVim.Bytes(file)
		filePath := path.Join(p.HomeDir, p.DotfilesDir, subdir, file)
		err := ioutil.WriteFile(filePath, fileContent, perm)
		if err != nil {
			fmt.Println(err)
		}
	}
}
