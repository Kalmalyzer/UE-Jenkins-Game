# Helper function for invoking an external utility (executable).
# The raison d'être for this function is to allow 
# calls to external executables via their *full paths* to be mocked in Pester.
#
# Reference: https://stackoverflow.com/a/56821110
function Invoke-External-PrintStdout {

	<#
		.SYNOPSIS
		Runs an external program, in a mock-friendly way

    .DESCRIPTION
    This runs a console command. It will not work well with non-console applications.
    Standard Input is fed in from the Stdin parameter.
    Standard Output and Standard Error are both written to the console.
    The first error message will be formatted like so:
      <commandname> : <message>
        + CategoryInfo          : NotSpecified: (<message>  :String) [], RemoteException
        + FullyQualifiedErrorId : NativeCommandError 
      ... but further stderr prints will be just the messages themselves, but still colored in red.
    Stdout and stderr will be interleaved in the order that the application prints to them.
	#>

    param (
        [Parameter(Mandatory=$true)] [string] $LiteralPath,
        [Parameter(Mandatory=$false)] [string] $Stdin=$null,
        [Parameter(Mandatory=$false)] [string[]] $ArgumentList
    )

  $Stdin | & $LiteralPath $ArgumentList | Out-Host

  return $LASTEXITCODE
}
