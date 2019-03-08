$ProgressPreference="SilentlyContinue"
$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

mkdir "$env:EPHEMERAL_DISK_TEMP_PATH" -ea 0
$env:TEMP = $env:TMP = $env:GOTMPDIR = $env:EPHEMERAL_DISK_TEMP_PATH
$env:GOCACHE = "$env:EPHEMERAL_DISK_TEMP_PATH\go-build"
$env:GOBIN = "$env:EPHEMERAL_DISK_TEMP_PATH\go-bin"
$env:PATH = "$env:PATH;$env:GOBIN"
$env:DEPENDENCIES_DIR = "$env:EPHEMERAL_DISK_TEMP_PATH\dependencies"
$env:VERSION_TAG="$env:OS_VERSION" #TODO: change test to use OS_VERSION instead of VERSION_TAG 
# download dependencies that will be embedded into the rootfs

# set environment vars


go get github.com/onsi/ginkgo
go get github.com/onsi/gomega

go install github.com/onsi/ginkgo/ginkgo

cd repo

mkdir "$env:DEPENDENCIES_DIR" -ea 0
.\download-dependencies.ps1 -dependenciesDir  $env:DEPENDENCIES_DIR
ginkgo