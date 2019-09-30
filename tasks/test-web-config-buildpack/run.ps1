#function main {
#    Write-Host "Hello Malini!"
#}

#Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#Start-Sleep -Seconds 3

#Set-ExecutionPolicy Bypass -Scope Process -Force
#Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
#$env:Path +=";%ALLUSERSPROFILE%\chocolatey\bin"

#choco install netfx-4.7.1-devpack -y
#choco install netfx-4.7.2-devpack -y
#choco install dotnetcore-sdk --version=2.2.104 -y
./build.ps1 Test

#main # Run the application.
