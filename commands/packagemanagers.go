package commands

func packageManagers(goos string) {
	switch goos {
	case "darwin":
		if checkExists("brew") {
			homeBrewUpgrade()
		} else {
			homeBrewInstall()
		}
	case "linux":
	default:
	}
}
