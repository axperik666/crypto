# -*- coding: utf-8 -*-
$ErrorActionPreference = 'Stop'
$FILE = Get-ChildItem -LiteralPath $PSScriptRoot -Filter 'CRYPTO-TRADERS*.html' | Select-Object -First 1 -ExpandProperty FullName
if (-not $FILE) { throw "HTML file not found in $PSScriptRoot" }
Write-Host "Target: $FILE"

$LOGO_SVG = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 40 40'%3E%3Crect width='40' height='40' rx='6' fill='%23131722'/%3E%3Cpath d='M8 30 L14 22 L20 26 L32 12' stroke='%2300c805' stroke-width='2.5' fill='none' stroke-linecap='round'/%3E%3Ccircle cx='32' cy='12' r='2.5' fill='%2300c805'/%3E%3C/svg%3E"

$HERO_TERMINAL = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 640 400'%3E%3Crect width='640' height='400' fill='%23131722'/%3E%3Crect x='0' y='0' width='640' height='36' fill='%231e222d'/%3E%3Ccircle cx='20' cy='18' r='5' fill='%23ef5350'/%3E%3Ccircle cx='38' cy='18' r='5' fill='%23ffc107'/%3E%3Ccircle cx='56' cy='18' r='5' fill='%2300c805'/%3E%3Ctext x='80' y='23' fill='%23b2b5be' font-family='monospace' font-size='12'%3ECrypto-Traders Terminal%3C/text%3E%3Crect x='0' y='36' width='140' height='364' fill='%231a1f2b'/%3E%3Ctext x='12' y='60' fill='%2300c805' font-size='11' font-family='monospace'%3EBTC/USDT +1.24%25%3C/text%3E%3Ctext x='12' y='80' fill='%23b2b5be' font-size='11' font-family='monospace'%3EETH/USDT -0.42%25%3C/text%3E%3Ctext x='12' y='100' fill='%23b2b5be' font-size='11' font-family='monospace'%3EXRP/USDT +0.18%25%3C/text%3E%3Crect x='150' y='50' width='8' height='120' fill='%2300c805'/%3E%3Crect x='165' y='80' width='8' height='90' fill='%23ef5350'/%3E%3Crect x='180' y='60' width='8' height='110' fill='%2300c805'/%3E%3Crect x='195' y='100' width='8' height='70' fill='%23ef5350'/%3E%3Crect x='210' y='45' width='8' height='125' fill='%2300c805'/%3E%3Crect x='225' y='75' width='8' height='95' fill='%2300c805'/%3E%3Crect x='240' y='90' width='8' height='80' fill='%23ef5350'/%3E%3Crect x='255' y='55' width='8' height='115' fill='%2300c805'/%3E%3Crect x='270' y='70' width='8' height='100' fill='%2300c805'/%3E%3Crect x='285' y='95' width='8' height='75' fill='%23ef5350'/%3E%3Crect x='300' y='50' width='8' height='120' fill='%2300c805'/%3E%3Crect x='315' y='65' width='8' height='105' fill='%2300c805'/%3E%3Crect x='330' y='85' width='8' height='85' fill='%23ef5350'/%3E%3Crect x='345' y='40' width='8' height='130' fill='%2300c805'/%3E%3Crect x='360' y='60' width='8' height='110' fill='%2300c805'/%3E%3Crect x='375' y='80' width='8' height='90' fill='%23ef5350'/%3E%3Crect x='390' y='55' width='8' height='115' fill='%2300c805'/%3E%3Crect x='405' y='70' width='8' height='100' fill='%2300c805'/%3E%3Crect x='420' y='100' width='8' height='70' fill='%23ef5350'/%3E%3Crect x='435' y='48' width='8' height='122' fill='%2300c805'/%3E%3Crect x='450' y='62' width='8' height='108' fill='%2300c805'/%3E%3Crect x='465' y='88' width='8' height='82' fill='%23ef5350'/%3E%3Crect x='480' y='52' width='8' height='118' fill='%2300c805'/%3E%3Crect x='495' y='72' width='8' height='98' fill='%2300c805'/%3E%3Crect x='510' y='95' width='8' height='75' fill='%23ef5350'/%3E%3Crect x='525' y='58' width='8' height='112' fill='%2300c805'/%3E%3Crect x='540' y='68' width='8' height='102' fill='%2300c805'/%3E%3Crect x='555' y='82' width='8' height='88' fill='%23ef5350'/%3E%3Crect x='570' y='50' width='8' height='120' fill='%2300c805'/%3E%3Crect x='585' y='75' width='8' height='95' fill='%2300c805'/%3E%3Crect x='600' y='90' width='8' height='80' fill='%23ef5350'/%3E%3Crect x='615' y='55' width='8' height='115' fill='%2300c805'/%3E%3Cline x1='140' y1='200' x2='640' y2='200' stroke='%232a2e39' stroke-width='1'/%3E%3Ctext x='150' y='230' fill='%23b2b5be' font-size='10' font-family='monospace'%3EOrder Book | Spread 0.02%25 | Latency 12ms%3C/text%3E%3C/svg%3E"

$SECTION_CHART = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 400 280'%3E%3Crect width='400' height='280' rx='8' fill='%231e222d'/%3E%3Cpath d='M20 220 L60 180 L100 200 L140 140 L180 160 L220 100 L260 120 L300 80 L340 110 L380 60' stroke='%2300c805' stroke-width='2' fill='none'/%3E%3Ctext x='20' y='30' fill='%23ffffff' font-size='14' font-family='sans-serif'%3EMarktanalyse Engine%3C/text%3E%3C/svg%3E"
$SECTION_AI = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 400 280'%3E%3Crect width='400' height='280' rx='8' fill='%231e222d'/%3E%3Crect x='40' y='60' width='320' height='160' rx='4' fill='%23131722' stroke='%232a2e39'/%3E%3Ccircle cx='120' cy='140' r='30' fill='none' stroke='%2300c805' stroke-width='2'/%3E%3Ctext x='200' y='130' fill='%23ffffff' font-size='13'%3EAI Strategy Core%3C/text%3E%3Ctext x='200' y='155' fill='%23b2b5be' font-size='11'%3ENeural Network Processing%3C/text%3E%3C/svg%3E"

function Get-IconSvg($label) {
    return "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 48 48'%3E%3Crect width='48' height='48' rx='8' fill='%231e222d'/%3E%3Ctext x='24' y='28' text-anchor='middle' fill='%2300c805' font-size='9' font-family='monospace'%3E$label%3C/text%3E%3C/svg%3E"
}

$ICONS = @(
    (Get-IconSvg '24/7'), (Get-IconSvg 'API'), (Get-IconSvg 'SPD'), (Get-IconSvg 'SSL'),
    (Get-IconSvg 'AI'), (Get-IconSvg 'ALL'), (Get-IconSvg 'GO'), (Get-IconSvg 'LRN')
)

$NEW_THEME_CSS = @'
<style id=ct-platform-theme>
:root{--page-background:#0b0e14;--card-background:#1e222d;--text-color:#ffffff;--text-muted:#b2b5be;--accent-color:#00c805;--accent-hover:#26a69a;--header-background:rgba(11,14,20,.95);--footer-background:#0b0e14;--border-color:#2a2e39}
body,#body,.page-site{background:#0b0e14!important;color:#fff!important}
.header,.header--transparent{background:rgba(11,14,20,.95)!important;backdrop-filter:blur(12px);border-bottom:1px solid var(--border-color)}
.header__top-text,.header .nav a,.header .nav a.active,.logo span{color:#fff!important}
.header .nav a:hover{color:#00c805!important}
.lang{background:#1e222d!important;border:1px solid var(--border-color)!important}
section,.seo,.sec,.calculator,.container,.footer__text{color:#fff}
h1,h2,h3,h4{color:#fff!important;font-weight:600!important}
h1 span,h2 span,.gradient-text{background:none!important;-webkit-text-fill-color:#fff!important;color:#fff!important}
p,li,td,th,label,.footer__small-text p{color:var(--text-muted)!important}
.hero__wrapper,body .hero__wrapper,.hero__form,.form,.modal__content,.modal__wrapper{background:#1e222d!important;border:1px solid var(--border-color)!important;box-shadow:0 4px 24px rgba(0,0,0,.45)!important;color:#fff!important;backdrop-filter:none}
.form__input,.form__input-wrapper input{background:#131722!important;border:1px solid var(--border-color)!important;color:#fff!important;box-shadow:none!important;border-radius:6px!important}
.form__input::placeholder{color:rgba(178,181,190,.5)!important}
.form__input:focus{border-color:#00c805!important;outline:none!important}
.form__input:-webkit-autofill,.form__input:-webkit-autofill:hover,.form__input:-webkit-autofill:focus{-webkit-box-shadow:0 0 0 1000px #131722 inset!important;-webkit-text-fill-color:#fff!important;caret-color:#fff!important}
.form__input-wrapper label,.form__label{color:var(--text-muted)!important}
.intl-tel-input .iti-flag.de{display:none!important}
.intl-tel-input.de-only .selected-flag{cursor:default;display:flex!important;align-items:center!important;gap:6px!important;padding:0 10px!important;background:transparent!important}
.intl-tel-input .flag-container{background:#131722!important;border-right:1px solid var(--border-color)!important;border-radius:6px 0 0 6px!important;pointer-events:none!important}
.de-flag-img{width:22px!important;height:14px!important;border-radius:2px!important;flex-shrink:0!important;display:block!important}
.selected-dial-code{color:#fff!important;font-weight:600!important;font-size:14px!important}
.intl-tel-input.de-only .iti-arrow{display:none!important}
.component-card,.sec__item,.review-item,.review-card,.card,.compare-table,.table-wrap,.calc-type,.calc-type__right,.calc-type__left,.irs--round,.modal,.faq__item,.step__item{background:#1e222d!important;border:1px solid var(--border-color)!important;color:#fff!important}
.calc-type .calc-type__left,.calc-type .calc-type__right{background:#1e222d!important}
.calc-type .calc-type__field--title{color:var(--text-muted)!important}
table th{background:#131722!important;color:#fff!important;border-color:var(--border-color)!important}
table td{color:var(--text-muted)!important;border-color:var(--border-color)!important}
.btn,.btn.form__btn,.btn.sec__btn,.header__btn.btn{background:#00c805!important;color:#0b0e14!important;font-weight:700!important;letter-spacing:.06em;text-transform:uppercase;box-shadow:none!important;border:none!important;border-radius:4px!important}
.btn:hover,.btn.form__btn:hover,.btn.sec__btn:hover{background:#26a69a!important;color:#0b0e14!important;transform:none!important}
.footer{background:#0b0e14!important;border-top:1px solid var(--border-color)}
.footer a{color:var(--text-muted)!important}
.footer a:hover{color:#00c805!important}
.swiper-pagination-bullet{background:rgba(178,181,190,.35)!important}
.swiper-pagination-bullet-active{background:#00c805!important}
#title h1{background:transparent!important;-webkit-text-fill-color:#fff!important;color:#fff!important;box-shadow:none!important;padding:0!important;font-size:clamp(1.5rem,3vw,2rem)!important;line-height:1.25!important;text-shadow:none!important}
#title p{color:var(--text-muted)!important;font-size:1.05rem!important}
.header__timer,.header__top-text{background:#1e222d!important;color:var(--text-muted)!important;border-bottom:1px solid var(--border-color)}
.compare-table th:first-child,.compare-table td:first-child{color:#00c805!important}
input[type=range],.irs--round .irs-bar,.irs--round .irs-handle{background-color:#00c805!important}
.irs--round .irs-line{background:rgba(178,181,190,.2)!important}
.modal__overlay{background:rgba(11,14,20,.88)!important}
.form__note{font-size:12px;line-height:1.5;color:var(--text-muted)!important;margin-top:12px;text-align:center}
.form__note strong{color:#fff!important}
.footer-badges{display:flex;flex-wrap:wrap;gap:10px;margin:20px 0 16px}
.footer-badge{display:inline-flex;align-items:center;padding:6px 12px;border:1px solid var(--border-color);border-radius:4px;font-size:11px;font-weight:700;letter-spacing:.05em;color:var(--text-muted)!important;background:#1e222d}
.footer-badge--accent{border-color:#00c805;color:#00c805!important}
.footer-risk{border-top:1px solid var(--border-color);padding-top:24px;margin-top:8px}
.footer-risk p{font-size:12px!important;line-height:1.65!important;color:rgba(178,181,190,.85)!important;margin-bottom:12px!important}
.footer-risk strong{color:#fff!important}
.hero__image img,.seo__image img{border-radius:8px;border:1px solid var(--border-color)}
.cards-block__icon img{width:48px!important;height:48px!important;border-radius:8px}
</style>
'@

$NEW_FIXES_CSS = @'
<style id=ct-fixes>
.cards .container,.cards--more .container,#cards-id-1 .container,#cards-id-3 .container,#cards-id-4 .container{background:#1e222d!important;border:1px solid #2a2e39!important}
.cards-block,.cards-block.columns--default{background:#131722!important;border:1px solid #2a2e39!important}
.cards-block__title,.cards-block h4,.cards-block h4 strong{color:#fff!important}
.cards-block__text,.cards-block__text p{color:#b2b5be!important}
.cards-block__icon img,.logo img,section img,.hero__wrapper img{display:block!important;visibility:visible!important;opacity:1!important}
.logo img{width:32px!important;height:32px!important}
</style>
'@

$NEW_PHONE_CSS = @'
<style id=phone-fix>
.form__input-wrapper.phone-wrapper::before{display:none!important;content:none!important}
.form__input-wrapper.phone-wrapper svg{display:none!important}
.form__input-wrapper.phone-wrapper{padding:0!important;position:static!important;background:transparent!important;box-shadow:none!important;border:none!important}
.phone-field-de{display:grid!important;grid-template-columns:auto 1fr!important;align-items:stretch!important;width:100%!important;min-height:48px!important;border:1px solid #2a2e39!important;border-radius:6px!important;overflow:hidden!important;background:#131722!important;box-shadow:none!important}
.phone-field-de__prefix{display:grid!important;grid-template-columns:22px auto!important;align-items:center!important;gap:4px!important;padding:0 12px!important;background:transparent!important;border-right:1px solid #2a2e39!important;box-sizing:border-box!important}
.phone-field-de__prefix span{color:rgba(178,181,190,.55)!important;font-weight:400!important;font-size:16px!important;line-height:48px!important;white-space:nowrap!important}
input.phone-de,input[type=tel].phone-de{width:100%!important;min-width:0!important;margin:0!important;padding:0 14px!important;border:none!important;border-radius:0!important;background:transparent!important;height:48px!important;font-size:16px!important;color:#fff!important;outline:none!important}
input.phone-de::placeholder{color:rgba(178,181,190,.45)!important}
input.phone-de:-webkit-autofill{-webkit-box-shadow:0 0 0 1000px #131722 inset!important;-webkit-text-fill-color:#fff!important}
.lang-wrap--de-only .lang__active{cursor:default!important;pointer-events:none!important}
</style>
'@

$FORM_NOTE = '<p class=form__note><strong>Hinweis:</strong> Nach der Registrierung erhalten Sie einen Anruf von Ihrem persönlichen Account-Manager von Crypto-Traders Pro zur Verifizierung und Einrichtung Ihres Handelskontos im Terminal.</p>'

$FOOTER_RISK = @'
<div class=footer-badges>
<span class="footer-badge footer-badge--accent">18+</span>
<span class=footer-badge>GDPR Compliant</span>
<span class=footer-badge>SSL Secured</span>
</div>
<div class=footer-risk>
<p><strong>Risikohinweis:</strong> Crypto-Traders Pro (crypto-traders.co) stellt eine professionelle Handelsumgebung für den Handel mit digitalen Assets, einschließlich CFDs und margingebundenen Finanzinstrumenten, bereit. Der Handel mit Hebelprodukten birgt ein erhebliches Verlustrisiko und ist nicht für alle Anleger geeignet. Sie können Ihr eingesetztes Kapital ganz oder teilweise verlieren. Vergangene Performance ist kein verlässlicher Indikator für zukünftige Ergebnisse. Stellen Sie sicher, dass Sie die mit dem Handel verbundenen Risiken vollständig verstehen, bevor Sie Kapital einsetzen.</p>
<p><strong>Regulatorischer Hinweis:</strong> Die auf dieser Website bereitgestellten Informationen dienen ausschließlich allgemeinen Informationszwecken und stellen keine Anlageberatung, Rechtsberatung oder Aufforderung zum Kauf oder Verkauf von Finanzinstrumenten dar. Crypto-Traders Pro handelt als technologischer Dienstleister und stellt Zugang zu professionellen Handelswerkzeugen bereit. Nutzer sind selbst verantwortlich für die Einhaltung der in ihrem Wohnsitzland geltenden Gesetze und Vorschriften.</p>
<p><strong>Datenschutz:</strong> Wir verarbeiten personenbezogene Daten gemäß der Datenschutz-Grundverordnung (DSGVO / GDPR). Details entnehmen Sie bitte unserer <a href=https://crypto-traders.co/privacy/>Datenschutzerklärung</a>. Durch die Nutzung dieser Plattform bestätigen Sie, dass Sie mindestens 18 Jahre alt sind.</p>
<p>© 2025–2026 Crypto-Traders Pro · crypto-traders.co · Alle Rechte vorbehalten.</p>
</div>
'@

Write-Host "Reading file..."
$html = [System.IO.File]::ReadAllText($FILE, [System.Text.Encoding]::UTF8)

# Calc-fix: extract and recolor
if ($html -match '(?s)<style id=calc-fix>(.*?)</style>') {
    $calcCss = $Matches[1] -replace '#7B49E9', '#00c805' -replace '123,73,233', '0,200,5'
    $NEW_CALC_CSS = "<style id=calc-fix>$calcCss</style>"
    $html = [regex]::Replace($html, '(?s)<style id=calc-fix>.*?</style>', $NEW_CALC_CSS, 1)
}

$html = $html.Replace('<title>CRYPTO-TRADERS – KI für automatisierten Handel</title>', '<title>Crypto-Traders Pro – Algorithmische Handelsplattform</title>')
$html = [regex]::Replace($html, '<meta name=description content="[^"]*">', '<meta name=description content="Crypto-Traders Pro – Professionelle algorithmische Handelsplattform für digitale Assets. Terminal-Zugang mit Analyse-Tools, Order-Execution und KI-Strategien.">', 1)
$html = [regex]::Replace($html, '<meta property=og:title content="[^"]*">', '<meta property=og:title content="Crypto-Traders Pro – Algorithmische Handelsplattform">', 1)
$html = [regex]::Replace($html, '<meta property=og:description content="[^"]*">', '<meta property=og:description content="Erhalten Sie Zugang zu professionellen Analyse-Tools, hoher Order-Execution und automatisierten Handelsstrategien auf der Crypto-Traders Terminal-Plattform.">', 1)
$html = $html.Replace('<meta property=og:site_name content="CRYPTO-TRADERS — Kryptowährungs-Handelsplattform">', '<meta property=og:site_name content="Crypto-Traders Pro">')

$html = [regex]::Replace($html, '(?s)<style id=ct-platform-theme>.*?</style>', $NEW_THEME_CSS, 1)
$html = [regex]::Replace($html, '(?s)<style id=ct-fixes>.*?</style>', $NEW_FIXES_CSS, 1)
$html = [regex]::Replace($html, '(?s)<style id=phone-fix>.*?</style>', $NEW_PHONE_CSS, 1)

$html = $html.Replace('style=background:#11191C', 'style=background:#0b0e14')
$html = $html.Replace('background:#11191C', 'background:#0b0e14')
$html = $html.Replace('background-color:#11191C', 'background-color:#1e222d')

$oldHeader = @'
<div class=header__top-text>
 – Advertorial &amp; <a href=https://crypto-traders.co/abuse-report/ target=_blank>DMCA Protected</a>–
 </div>
 <div class=header__timer data-type=user data-duration=4000>
 <div>
 <strong>Alarm! Nur noch <span>76</span> Plätze verfügbar. Jetzt registrieren, solange der Zugang offen ist</strong> </div>
 </div>
'@
$newHeader = @'
<div class=header__top-text>
 Crypto-Traders Pro · Offizielle Handelsplattform · <a href=https://crypto-traders.co/ target=_blank>crypto-traders.co</a>
 </div>
'@
$html = $html.Replace($oldHeader, $newHeader)

$html = [regex]::Replace($html, '<img src="data:image/svg\+xml[^"]*" alt="CRYPTO-TRADERS"[^>]*>', "<img src=`"$LOGO_SVG`" alt=`"Crypto-Traders Pro`" style=`"width:32px;height:32px;display:block;flex-shrink:0`">")
$html = $html.Replace('<span style="font-weight:700;font-size:18px;color:#FFFFFF;letter-spacing:0.5px;">CRYPTO-TRADERS</span>', '<span style="font-weight:700;font-size:17px;color:#FFFFFF;letter-spacing:0.4px;">Crypto-Traders Pro</span>')
$html = $html.Replace('<span style="font-weight:700;font-size:16px;color:#ffffff;letter-spacing:0.5px;">CRYPTO-TRADERS</span>', '<span style="font-weight:700;font-size:15px;color:#ffffff;letter-spacing:0.4px;">Crypto-Traders Pro</span>')

$html = $html.Replace("<a href=#form-modal class=`"header__btn btn`">`n Aktien kaufen", "<a href=#form-modal class=`"header__btn btn`">`n Terminal-Zugang")

$html = $html.Replace('<h1>CRYPTO-TRADERS – Professioneller KI-Handel mit Kryptowährungen und Aktien für jedermann</h1>', '<h1>Crypto-Traders™: Algorithmische Handelsplattform für digitale Assets.</h1>')
$html = $html.Replace('<p>Automatisierter Handel mit adaptiven Strategien für jedes Erfahrungsniveau. Wir zeigen Ihnen, wie Sie Erfolge erzielen</p>', '<p>Erhalten Sie Zugang zu professionellen Analyse-Tools, hoher Order-Execution und automatisierten Handelsstrategien auf Basis von KI. Registrieren Sie Ihr Konto für den Terminal-Zugang.</p>')

$html = $html.Replace('Beginnen Sie Ihre Investition mit der Öl- und Gasindustrie!', 'Konto im Terminal eröffnen')
$html = $html.Replace('<p>Benutzerkonto erstellen</p>', '<p>Konto im Terminal eröffnen</p>')

$html = $html.Replace('Registrierung abschließen</button>', 'ZUGANG FREISCHALTEN</button>')
$html = $html.Replace('Formular absenden</button>', 'ZUGANG FREISCHALTEN</button>')
$html = $html.Replace('Jetzt registrieren</button>', 'TERMINAL STARTEN</button>')
$html = $html.Replace('Jetzt aktivieren</button>', 'TERMINAL STARTEN</button>')

$html = $html.Replace('</label> </form>', "</label>`n$FORM_NOTE </form>")

# Hero image
$html = [regex]::Replace($html, '(?s)(<div class=hero__image>\s*)<img src="data:image/[^"]*"[^>]*>', "`${1}<img src=`"$HERO_TERMINAL`" alt=`"Crypto-Traders Terminal`" style=`"width:100%;border-radius:8px`">", 1)

# SEO images
$seoCount = 0
$html = [regex]::Replace($html, '(?s)(<div class=seo__image>\s*)<img src="data:image/[^"]*"[^>]*>', {
    param($m)
    $script:seoCount++
    $src = if ($script:seoCount -eq 1) { $SECTION_CHART } else { $SECTION_AI }
    $alt = if ($script:seoCount -eq 1) { 'Marktanalyse' } else { 'KI-Engine' }
    return "$($m.Groups[1].Value)<img src=`"$src`" alt=`"$alt`" style=`"width:100%;border-radius:8px`">"
}, 2)

# Card icons
$iconIdx = 0
$html = [regex]::Replace($html, '<img src=data:image/png;base64,[^>]+>', {
    $src = $ICONS[$iconIdx % $ICONS.Count]
    $script:iconIdx++
    return "<img src=`"$src`" alt=`"`" width=48 height=48>"
})

# Footer small text
$oldFooterSmall = @'
<p>Professioneller KI-Handel für jedermann.<br>
CRYPTO-TRADERS handelt automatisch mit<br>
Kryptowährungen und Aktien mit einer<br>
Genauigkeit von 89–92 %. Einrichtung<br>
in nur 3 Klicks, Handel rund um die Uhr.</p>
'@
$newFooterSmall = @'
<p>Crypto-Traders Pro – Ihre professionelle<br>
Handelsumgebung für digitale Assets.<br>
Terminal-Zugang mit Echtzeit-Analyse,<br>
Order-Execution und KI-gestützten Strategien.</p>
'@
$html = $html.Replace($oldFooterSmall, $newFooterSmall)

$html = [regex]::Replace($html, '(?s)<div class=footer__text>.*?</div>\s*</div>\s*</footer>', "<div class=footer__text>$FOOTER_RISK</div>`n </div>`n</footer>", 1)

# Section headings
$replacements = @{
    '<h2>Die Zukunft des Tradings ist da – seien Sie dabei!</h2>' = '<h2>Crypto-Traders Terminal – Professioneller Marktzugang</h2>'
    '<h2>CRYPTO-TRADERS – Technologie, die die Spielregeln verändert hat</h2>' = '<h2>Crypto-Traders Pro – Institutionelle Handelsinfrastruktur</h2>'
    '<h2>So funktioniert CRYPTO-TRADERS AI</h2>' = '<h2>So funktioniert die Crypto-Traders Engine</h2>'
    '<h3><strong>Das Ergebnis – echte Vorteile für jeden Nutzer:</strong></h3>' = '<h3><strong>Plattform-Vorteile im Überblick:</strong></h3>'
    'Nachgewiesene Genauigkeit 89–92 %' = 'Präzise Order-Execution'
    '<h2>CRYPTO-TRADERS: Tausende von Assets in einem einheitlichen Ökosystem</h2>' = '<h2>Crypto-Traders Pro: Umfassendes Asset-Ökosystem</h2>'
    '<h2>Was der automatische Modus von CRYPTO-TRADERS kann</h2>' = '<h2>Automatisierte Strategien im Crypto-Traders Terminal</h2>'
    '<h2>Die Leistungsfähigkeit der Künstlichen Intelligenz von CRYPTO-TRADERS in Zahlen</h2>' = '<h2>Crypto-Traders Pro – Plattform-Kennzahlen</h2>'
    '<h2>Sicherheit und Zuverlässigkeit von CRYPTO-TRADERS</h2>' = '<h2>Sicherheit und Compliance bei Crypto-Traders Pro</h2>'
    '<h2>Was unsere Benutzer sagen</h2>' = '<h2>Erfahrungsberichte von Terminal-Nutzern</h2>'
    '<h2>Steigen Sie bei CRYPTO-TRADERS ein – nur 3 Klicks</h2>' = '<h2>Terminal-Zugang in drei Schritten</h2>'
    '<h2>CRYPTO-TRADERS im Vergleich zur Konkurrenz</h2>' = '<h2>Crypto-Traders Pro im Plattform-Vergleich</h2>'
    '<h2>CRYPTO-TRADERS in Zahlen</h2>' = '<h2>Crypto-Traders Pro in Zahlen</h2>'
    '<p>Drei Jahre Algorithmus-Training und Tests auf realen Märkten liefern konstant hohe Ergebnisse</p>' = '<p>Optimierte Algorithmen für präzise Marktausführung auf institutionellem Niveau</p>'
    'Über CRYPTO-TRADERS </a>' = 'Über Crypto-Traders Pro </a>'
    '<th>CRYPTO-TRADERS</th>' = '<th>Crypto-Traders Pro</th>'
}
foreach ($k in $replacements.Keys) { $html = $html.Replace($k, $replacements[$k]) }

Write-Host "Writing file..."
[System.IO.File]::WriteAllText($FILE, $html, [System.Text.UTF8Encoding]::new($false))
$sizeKb = [math]::Floor((Get-Item $FILE).Length / 1024)
Write-Host "Done. File size: $sizeKb KB"
