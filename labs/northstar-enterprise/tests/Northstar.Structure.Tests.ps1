Describe 'Northstar Enterprise lab structure' {
    $root = Split-Path -Parent $PSScriptRoot

    It 'has the flagship build orchestrator' {
        Test-Path (Join-Path $root 'Build-NorthstarLab.ps1') | Should -BeTrue
    }

    It 'has the Active Directory deployment layer' {
        Test-Path (Join-Path $root 'active-directory/Install-NorthstarForest.ps1') | Should -BeTrue
        Test-Path (Join-Path $root 'active-directory/Install-Northstar-SecondaryDC.ps1') | Should -BeTrue
        Test-Path (Join-Path $root 'active-directory/Initialize-NorthstarDirectory.ps1') | Should -BeTrue
    }

    It 'has the infrastructure and monitoring layers' {
        Test-Path (Join-Path $root 'infrastructure') | Should -BeTrue
        Test-Path (Join-Path $root 'monitoring') | Should -BeTrue
        Test-Path (Join-Path $root 'elastalert2') | Should -BeTrue
    }

    It 'has incident scenarios and architecture documentation' {
        Test-Path (Join-Path $root 'incidents') | Should -BeTrue
        Test-Path (Join-Path $root 'architecture') | Should -BeTrue
        Test-Path (Join-Path $root 'README.md') | Should -BeTrue
    }
}
