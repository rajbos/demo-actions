# close all open issues in this repo using the github cli
$list = gh issue list --state open --limit 1000 --json number | ConvertFrom-Json
foreach ($item in $list) {
    gh issue close  $item.number
}

