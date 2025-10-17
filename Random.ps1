Add-Type -AssemblyName System.Speech
$SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer

# $Path = "C:\Users\TomRuneWakaValen\Desktop\PowerShell Scripts\Out Of Context Ououts reader and fixer\Semi Filterd text.txt"
$Path = ".\Semi Filterd text.txt"

$lines = Get-Content -Path $Path

Write-Host "Working"
Write-Host $lines.Count

for ($i = 1; $i -lt $lines.Count; $i++) {
    Write-Host $i
    # Detect a line containing a quote
    $Random = Get-Random -Maximum $lines.Count
    $line = $lines[$Random]
    if ($line -match '"([^"]+)"\s*-(.+)$')
    {
        $quoteText = $matches[1].Trim()
        $quotedName = $matches[2].Trim()

        # sets the corect pronunes becuse why not
        if ($quoter -eq "Magathi" -or "Ginger" -or "Natasha") {$pronune = "She was"}
        if ($quoter -eq "Oscar" -or "Ben" -or "Chad") {$pronune = "He was"}
        if ($quoter -eq "Jupiter") {$pronune = "They were"}
        if ($quoter -eq "Imre") {$pronune = "God was"}

        # Grab name and date/time from previous lines (if present)
        $quoter = $lines[$Random - 3]
        $date = $lines[$Random - 1]
        # Speak the quote info
        Write-Host "$quoter, on $date, quoted:"
        Write-Host @quoteText
        $SpeechSynth.Speak("$quoter, on $date, said:")
        $SpeechSynth.Speak($quoteText)
        Write-Host ""
        Write-Host "Press SPACE to hear who they were quoting..." -ForegroundColor Yellow

        # Wait for spacebar
        do 
        {
            $key = [System.Console]::ReadKey($true)
        } until ($key.Key -eq 'Spacebar')

        # Speak quoted person
        Write-Host "They were quoting $quotedName"
        $SpeechSynth.Speak("$pronune quoting $quotedName")
        Write-Host ""
    }
}
