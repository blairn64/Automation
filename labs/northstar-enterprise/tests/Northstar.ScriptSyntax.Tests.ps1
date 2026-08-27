Describe 'Northstar PowerShell syntax' {
    $root = Split-Path -Parent $PSScriptRoot
    $scripts = Get-ChildItem -Path $root -Recurse -Filter '*.ps1' | Where-Object {
        $_.FullName -notmatch '[\\/]tests[\\/]'
    }

    It 'contains PowerShell scripts to validate' {
        $scripts.Count | Should -BeGreaterThan 0
    }

    foreach ($script in $scripts) {
        It "parses cleanly: $($script.Name)" {
            $tokens = $null
            $errors = $null
            [void][System.Management.Automation.Language.Parser]::ParseFile(
                $script.FullName,
                [ref]$tokens,
                [ref]$errors
            )
            $errors.Count | Should -Be 0
        }
    }
}
