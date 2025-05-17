
# Remove-Item -Path "*.exe"
Write-Host -ForegroundColor Yellow Compile $args[0]
# Remove-Item -Path "*.hi"
# Remove-Item -Path "*.o"
ghc $args[0] -Wall
