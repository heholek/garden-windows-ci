This doc deals with how to update go version in a bosh release that sources it from [golang-release](https://github.com/bosh-packages/golang-release).

The following details how you would update winc-release from go-1.11 to go-1.12:

1. `git clone https://github.com/bosh-packages/golang-release ~/workspace/golang-release`

2. `cd ~/workspace/winc-release`

3. checkout develop

4. `bosh vendor-package golang-1.12-windows ~/workspace/golang-release`
This will upload the new golang blob to the blob store, create a new package named `golang-1.12-windows` in `packages`, and `.final_builds`. (You might need to set creds to get write access to blobstore. e.g. `set_bosh_windows_s3_blobstore`)

5. `rm -rf packages/golang-1.11-windows` && `rm -rf .final_builds/packages/golang-1.11-windows`

6. Replaces all references to the old golang package in packages with the new one (`grep -rl "golang-1.11-windows" ./packages | xargs sed -i "s/golang-1.11-windows/golang-1.12-windows/"`)

  * If you are just moving to golang-release for the first time, you might have to remove the line that sets `GOROOT` in the packaging script, and use `. C:\var\vcap\packages\golang-1.12-windows\bosh\compile.ps1`.

7. `bosh create-release --tarball /tmp/tmp.tgz --force` must work fine (or whatever you would do for offline releases).

7. Stage the changes to `packages/` and `.final_builds/`, and `git push`.

**TODO**: Automate this
