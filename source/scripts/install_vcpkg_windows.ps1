

$DEPENDENCIES = @(
    "libsndfile",
    "boost-circular-buffer",
    "boost-config",
    "boost-property-tree",
    "boost-ptr-container",
    "boost-smart-ptr",
    "boost-spirit",
    "pthread"
)

$VCPKG_WORFLOW_ROOT = C:\vcpkg
$VCPKG_LOCAL_ROOT = .\build\deps\vcpkg\vcpkg

$ROOT = (Get-Location).Path
# also $PWD can be used

function Install-With-Vcpkg {
    if (Test-Path -Path $VCPKG_WORFLOW_ROOT) {
        "In Workflow"
        c:\vcpkg\vcpkg install $args
    } else {
        "Not in Workflow"
        Set-Location -Path $ROOT
        Write-Output (Get-Location).Path
        New-Item -ItemType Directory -Path "build\deps" -Force | Out-Null
        Set-Location -Path "build\deps"
        git clone --depth=1 https://github.com/Microsoft/vcpkg.git | Out-Null
        .\vcpkg\bootstrap-vcpkg.bat -disableMetrics | Out-Null
        # Set-Location -Path "vcpkg"
        .\build\deps\vcpkg\vcpkg install --triplet x64-windows $args
    }
}

Install-With-Vcpkg $DEPENDENCIES
