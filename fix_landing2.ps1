# ASCII-only script (PowerShell 5.1 safe).
$ErrorActionPreference = 'Stop'
$FILE = Get-ChildItem -LiteralPath $PSScriptRoot -Filter 'CRYPTO-TRADERS*.html' | Select-Object -First 1 -ExpandProperty FullName
if (-not $FILE) { throw "HTML file not found" }
Write-Host "Target: $FILE"
$html = [System.IO.File]::ReadAllText($FILE, [System.Text.Encoding]::UTF8)

function Get-IconSvg($label) {
    return "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 48 48'%3E%3Crect width='48' height='48' rx='8' fill='%231e222d' stroke='%232a2e39'/%3E%3Ctext x='24' y='28' text-anchor='middle' fill='%2300c805' font-size='10' font-weight='bold' font-family='monospace'%3E$label%3C/text%3E%3C/svg%3E"
}

# Card icons: context-aware labels based on the card title that follows the icon
function Pick-Label($title) {
    if ($title -match '24/7|rund um die Uhr')                            { return '24/7' }
    if ($title -match 'Sicher|Schutz|SSL|Verschl|Compliance')            { return 'SSL' }
    if ($title -match 'Pr.zis|Genau|Execution|Order')                    { return 'EXE' }
    if ($title -match 'schnell|Geschwind|Blitz|Latenz|Speed|Sekunde')    { return 'SPD' }
    if ($title -match 'KI|AI|Intelligen|neuronal|berwach|Lern')          { return 'AI' }
    if ($title -match 'Asset|Krypto|Aktien|kosystem|Infrastruktur|Netzwerk|Liquid') { return 'NET' }
    if ($title -match 'Auto|Strategi|Modus|Robot')                       { return 'BOT' }
    if ($title -match 'Klick|Start|Einfach|Einricht|Zugang')             { return 'GO' }
    if ($title -match 'Analys|Daten|Markt|Signal')                       { return 'DATA' }
    if ($title -match 'Gewinn|Rendite|Kapital|Geld|Profit|Einkommen')    { return 'ROI' }
    if ($title -match 'Support|Hilfe|Manager|Betreu')                    { return 'SUP' }
    if ($title -match 'API|Schnittstell')                                { return 'API' }
    return 'CT'
}

$script:cnt1 = 0
$html = [regex]::Replace($html, '(?s)(<span class=cards-block__icon>\s*)<img [^>]+>(\s*</span>)([^<]{0,200})(</h4>)', {
    param($m)
    $script:cnt1++
    $title = $m.Groups[3].Value
    $label = Pick-Label $title
    $icon = Get-IconSvg $label
    return $m.Groups[1].Value + '<img src="' + $icon + '" alt="" width=48 height=48>' + $m.Groups[2].Value + $title + $m.Groups[4].Value
})
Write-Host "Card icons fixed: $($script:cnt1)"

# Any leftover base64 PNG images (icons in other slots) -> neutral terminal icon
$script:cnt2 = 0
$genericIcon = Get-IconSvg 'CT'
$html = [regex]::Replace($html, '<img src="data:image/png;base64,[^"]*"[^>]*>', {
    param($m)
    $script:cnt2++
    return '<img src="' + $genericIcon + '" alt="" width=48 height=48>'
})
$html = [regex]::Replace($html, '<img src=data:image/png;base64,[^ >]+( [^>]*)?>', {
    param($m)
    $script:cnt2++
    return '<img src="' + $genericIcon + '" alt="" width=48 height=48>'
})
Write-Host "Leftover PNG replaced: $($script:cnt2)"

[System.IO.File]::WriteAllText($FILE, $html, [System.Text.UTF8Encoding]::new($false))
$sizeKb = [math]::Floor((Get-Item -LiteralPath $FILE).Length / 1024)
Write-Host "Done. File size: $sizeKb KB"
