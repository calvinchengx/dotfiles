package static

import (
	"os"
	"path"

	"github.com/gobuffalo/packr"
)

// PackFiles help us pack a folder as static files
func PackFiles(relativePath string) packr.Box {
	root, _ := os.Getwd()
	path := path.Join(root, relativePath)
	box := packr.NewBox(path)
	return box
}
