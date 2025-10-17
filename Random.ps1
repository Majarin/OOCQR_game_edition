Add-Type -AssemblyName System.Speech
$SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer

# $Path = "C:\Users\TomRuneWakaValen\Desktop\PowerShell Scripts\Out Of Context Ououts reader and fixer\Semi Filterd text.txt"
$Path = ".\Semi Filterd text.txt"

$lines = Get-Content -Path $Path


for ($i = 1; $i -lt $lines.Count; $i++) {
    
    # Detect a line containing a quote
    $Random = Get-Random -Maximum $lines.Count
    $line = $lines[$Random]
    if ($line -match '"([^"]+)"\s*-(.+)$')
    {
        $quoteText = $matches[1].Trim()
        $quotedName = $matches[2].Trim()
        
        $ii = 0
        $iii = 0
        # Grab name and date/time from previous lines (if present)
        do{
            
            $ii++
            $quoter = $lines[$Random - $ii]

        }until ($quoter -eq "Magathi" -or $quoter -eq "Ginger" -or $quoter -eq "Natasha" -or $quoter -eq "Oscar" -or $quoter -eq "Ben" -or $quoter -eq "Chad"-or $quoter -eq "Jupiter" -or $quoter -eq "Imre")
        do {
            
            $iii++
            $date = $lines[$Random - $iii]

        } until ($date -match '^[120]' -and $date -match '/')
        
        # sets the corect pronunes becuse why not
        
        if ($quoter -eq "Magathi" -or $quoter -eq "Ginger" -or $quoter -eq "Natasha") {$pronune = "She was"}
        elseif($quoter -eq "Oscar" -or $quoter -eq "Ben" -or $quoter -eq "Chad") {$pronune = "He was"} 
        elseif ($quoter -eq "Jupiter") {$pronune = "They were"}
        elseif ($quoter -eq "Imre") {$pronune = "God was"}
        
    
        # Speak the quote info
        
        Write-Host "$quoter, on $date, quoted:"
        Write-Host @quoteText
        $SpeechSynth.Speak("$quoter, on $date")
        $SpeechSynth.Speak($quoteText)
        Write-Host ""
        Write-Host "Press SPACE to hear who they were quoting..." -ForegroundColor Yellow

        # Wait for spacebar
        do 
        {
            $key = [System.Console]::ReadKey($true)
        } until ($key.Key -eq 'Spacebar')

        # Speak quoted person
        Write-Host "$pronune quoting $quotedName"
        $SpeechSynth.Speak("$pronune quoting $quotedName")
        Write-Host ""
                do 
        {
            $key = [System.Console]::ReadKey($true)
        } until ($key.Key -eq 'Spacebar')
    }
}
