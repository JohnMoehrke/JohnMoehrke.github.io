param(
    [string]$InputFile = "Resume.md",
    [string]$OutputFile = "resume.html",
    [string]$TemplateFile = "resume-template.html",
    [string]$CssFile = "resume.css"
)

$ErrorActionPreference = "Stop"

$pandoc = Get-Command pandoc -ErrorAction Stop

if (-not (Test-Path $InputFile)) { throw "Input file not found: $InputFile" }
if (-not (Test-Path $TemplateFile)) { throw "Template file not found: $TemplateFile" }
if (-not (Test-Path $CssFile)) { throw "CSS file not found: $CssFile" }

& $pandoc.Source $InputFile `
    -f gfm `
    -t html5 `
    --standalone `
    --template $TemplateFile `
    --css $CssFile `
    --metadata title="John F. Moehrke - Resume" `
    -o $OutputFile

Write-Host "Generated $OutputFile from $InputFile using $TemplateFile and $CssFile"
