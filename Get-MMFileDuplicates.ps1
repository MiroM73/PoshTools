# find file duplicates
$PathToFiles = 'E:\!eBooks'
$files = Get-ChildItem $PathToFiles -Recurse -File
$files | Group-Object Length | Where-Object count -gt 1 |
    ForEach-Object {
        "#"*80
        $_.group.fullname | ForEach-Object {
            [pscustomobject]@{
                hash     = (Get-FileHash $_).hash
                fullname = $_
            }
        }
    } | Tee-Object -Variable hash
Write-Host ''
$hash | Group-Object hash | Where-Object count -gt 1 | Select-Object @{n = 'fullname'; e = { $_.group.fullname } }