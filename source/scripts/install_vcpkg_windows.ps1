
$DEPENDENCIES = @(
    "libsndfile",
    "boost-circular-buffer",
    "boost-config",
    "boost-property-tree",
    "boost-ptr-container",
    "boost-smart-ptr",
    "boost-spirit"
)

$ROOT = (Get-Location).Path

function Install-With-Vcpkg {
    Set-Location -Path $ROOT
    Write-Output (Get-Location).Path
    New-Item -ItemType Directory -Path "build\deps" -Force | Out-Null
    Set-Location -Path "build\deps"
    git clone --depth=1 https://github.com/Microsoft/vcpkg.git | Out-Null
    .\vcpkg\bootstrap-vcpkg.bat -disableMetrics | Out-Null
    Set-Location -Path "vcpkg"
    .\vcpkg install $args
}

Install-With-Vcpkg $DEPENDENCIES
