Add-Type -AssemblyName System.Speech
$SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
#$Path = "C:\Users\TomRuneWakaValen\Desktop\PowerShell Scripts\Out Of Context Ououts reader and fixer\Semi Filterd text.txt"       #This is for me

$Path = ".\Semi Filterd text.txt"       #this is for frinds
$lines = Get-Content -Path $Path
for ($i = 1; $i -lt $lines.Count; $i++)
{
    $Safe = 2
    $Random = Get-Random -Maximum $lines.Count
    $line = $lines[$Random]
    if(
    $line -like  '*"*' -or
    $line -like  '*“*' -or
    $line -like  '*«*'
    )
    {
        do
        {
            Write-Output "Well Fuck"
            $Safe = $Safe + 1
            $speak = $lines[$Random - $Safe]
        }While (
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
        $Quote = "$speak quoted: $line"
        Write-Output $line
        Write-Output $speak
        $SpeechSynth.Speak($Quote)
    }
}