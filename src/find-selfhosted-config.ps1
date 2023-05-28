# find the self-hosted runner setup information from the _diag folder
[CmdletBinding()]
param (
    [Parameter()]
    $RunnerPath = 'C:\temp\gh-runner\'
)

$diagPath = Join-Path -Path $RunnerPath -ChildPath '_diag'
$diagFiles = Get-ChildItem -Path $diagPath -Filter '*-utc.log' -File | Sort-Object -Property LastWriteTime -Descending

# use the most recent file
$diagFile = $diagFiles | Select-Object -First 1

# overwrite with other filename for testing
#$diagFile = Get-Item -Path 'C:\temp\gh-runner\_diag\Worker_20230528-194114-utc.log'

# echo the filename we are using 
Write-Host "Using diag file: $($diagFile.FullName)"
$diagContent = Get-Content -Path $diagFile.FullName
# find the first line of the json object with all the information, denoted by '{'
$firstLine = $diagContent | Select-String -Pattern '{' | Select-Object -First 1
$previousLine = $diagContent | Select-Object -Skip ($firstLine.LineNumber-2) | Select-Object -First 1
# find the year in the prevous line, denoted by '[<year>-<month>'
$year = $previousLine -replace '.*\[(\d{4})-\d{2}.*', '$1'
# show the year
Write-Debug "Year: $year"

# find the next line after the $firstLine with the year in it, denoted by '[<year>-<month>'
$lastLine = $diagContent | Select-Object -Skip $firstLine.LineNumber #| Select-Object -First 1
$lastLine = $lastLine | Select-String -Pattern "\[$($year)-" | Select-Object -First 1
# find the line number of the last line
$lastLine = $diagContent | Select-String -Pattern "\$($lastLine)" | Select-Object -First 1

# echo the first and last line of the json object:
Write-Debug "Previous line: $previousLine"
Write-Debug "First line: $firstLine"
Write-Debug "Last line: $lastLine"

# get the json object from the diag file
$diagJson = "{" + $($diagContent | Select-Object -Skip $firstLine.LineNumber | Select-Object -First ($lastLine.LineNumber - $firstLine.LineNumber- 1))

# replace all occurences of *** with '***'
$diagJson = $diagJson -replace '\*\*\*', "'***'"

# temp write the json object to a file
$diagJson | Out-File -FilePath "$($PSScriptRoot)\output\runner-info.json" -Force

# show the json object
# Write-Host "JSON object: $diagJson"

# convert the json object to a powershell object
$diagObject = $diagJson | ConvertFrom-Json -Depth 20

# if object has GitHubUrl property, then show it:
if ($diagObject.GitHubUrl) {
    Write-Host "GitHub repo for the last run: [$($diagObject.GitHubUrl)]"
}

if ($diagObject.plan) {
    $owner = $diagObject.plan.definition.name
    $repo = $diagObject.plan.owner.name
    Write-Host "GitHub owner for the last run: [$owner\$repo]"
    Write-Host "Link: https://github.com/$owner/$repo/"
    Write-Host "Workflow definition file: $($diagObject.variables."system.workflowFilePath".value)"
}