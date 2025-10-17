Add-Type -AssemblyName System.Speech
$SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer

# $Path = "C:\Users\TomRuneWakaValen\Desktop\PowerShell Scripts\Out Of Context Ououts reader and fixer\Semi Filterd text.txt"
$Path = ".\Semi Filterd text.txt"   

$lines = Get-Content -Path $Path

for ($i = 1; $i -lt $lines.Count; $i++) {
    $Safe = 2
    $Random = Get-Random -Maximum $lines.Count
    $line = $lines[$Random]

    if (
        $line -like '*"*' -or
        $line -like '*“*' -or
        $line -like '*«*'
    ) {
        do {
            Write-Output "Well Fuck"
            $Safe = $Safe + 1
            $speak = $lines[$Random - $Safe]
        } while (
            $speak -like '*«*' -or
            $speak -like '*“*' -or
            $speak -like '*"*' -or
            $speak -like " " -or
            $speak -eq "" -or
            $speak -match '^\d{1,2}/\d{1,2}/\d{4}' -or
            $speak -match '^\d{1,2}:\d{2}' -or
            $speak -match 'at \d{1,2}:\d{2} (AM|PM)'
        )

        $speak = $lines[$Random - $Safe]
        $quote = $line
        $quoter = $speak

        $SpeechSynth.Speak("$quoter quoted,")
        $SpeechSynth.Speak($quote)

        Write-Host ""
        Write-Host "Press SPACE to hear who they were quoting..." -ForegroundColor Yellow

        do {
            $key = [System.Console]::ReadKey($true)
        } until ($key.Key -eq 'Spacebar')

        # After pressing space, read the quoted line
        $quoted = $lines[$Random + 1]  # You can tweak this if “quoted” appears elsewhere
        if (![string]::IsNullOrWhiteSpace($quoted)) {
            $SpeechSynth.Speak("They were quoting: $quoted")
        } else {
            $SpeechSynth.Speak("No quoted line found.")
        }

        Write-Host ""
    }
}
