# Windows-native install: copies generated files to Windows user profile.
# Run from repo root: pwsh -File scripts/install-windows.ps1

param([string]$Config = "defaults/config.json")

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path | Split-Path -Parent
$tmpDir   = Join-Path $env:TEMP "agents-install-$(Get-Random)"
$winHome  = $env:USERPROFILE

Write-Host ">> Generating to temp dir..."
node "$repoRoot\scripts\generate.js" all --config "$repoRoot\$Config" --output-dir $tmpDir
if ($LASTEXITCODE -ne 0) { Write-Error "Generation failed"; exit 1 }

$mappings = @(
    @{ From = "copilot\agents";       To = ".copilot\agents" },
    @{ From = "copilot\skills";       To = ".copilot\skills" },
    @{ From = "copilot\instructions"; To = ".copilot\instructions" },
    @{ From = "claude\agents";        To = ".claude\agents" },
    @{ From = "claude\skills";        To = ".claude\skills" },
    @{ From = "claude\rules";         To = ".claude\rules" }
)

Write-Host ">> Copying to $winHome ..."
foreach ($m in $mappings) {
    $src  = Join-Path $tmpDir $m.From
    $dest = Join-Path $winHome $m.To
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item -Recurse -Force -Path "$src\*" -Destination $dest
    $count = (Get-ChildItem $dest -Recurse -File).Count
    Write-Host "   OK ~\$($m.To) ($count files)"
}

# Configure VS Code settings
Write-Host ">> Configuring VS Code settings..."
node "$repoRoot\scripts\configure-vscode-settings.js"

# Cleanup
Remove-Item -Recurse -Force $tmpDir

Write-Host ""
Write-Host "Installation complete!"
Write-Host "  Copilot agents:       $((Get-ChildItem "$winHome\.copilot\agents" -File).Count)"
Write-Host "  Copilot skills:       $((Get-ChildItem "$winHome\.copilot\skills" -Directory).Count)"
Write-Host "  Copilot instructions: $((Get-ChildItem "$winHome\.copilot\instructions" -File).Count)"
Write-Host "  Claude agents:        $((Get-ChildItem "$winHome\.claude\agents" -File).Count)"
Write-Host "  Claude skills:        $((Get-ChildItem "$winHome\.claude\skills" -Directory).Count)"
Write-Host "  Claude rules:         $((Get-ChildItem "$winHome\.claude\rules" -File).Count)"
