$origin_path = "C:\Windows\Temp\games\" 
$destination_path = "C:\Users\Bridges369\OneDrive\Games\PCSX2\"


function Clear-Light-Host {
  Param (

    [Parameter(Position=1)]
    [int32]$Count=1

  )

  $CurrentLine  = $Host.UI.RawUI.CursorPosition.Y
  $ConsoleWidth = $Host.UI.RawUI.BufferSize.Width

  $i = 1
  for ($i; $i -le $Count; $i++) {
    
    [Console]::SetCursorPosition(0,($CurrentLine - $i))
    [Console]::Write("{0,-$ConsoleWidth}" -f " ")

  }

  [Console]::SetCursorPosition(0,($CurrentLine - $Count))
}


function Main {

  Write-Host "╒═══╤═══════════════════════════════════════╗"  -ForegroundColor Green

  # EXTRACT FILES
  foreach ($file in Get-ChildItem -Path $origin_path -Filter "*.zip") {
    $name = $file.NameString
    
    try {
      Expand-Archive -Path $file -DestinationPath $destination_path -Confirm

      Clear-Light-Host 5
      Write-Host "│ 󰸞 │`t" -ForegroundColor Green -NoNewline
      Write-Host $name   -ForegroundColor White

      Remove-Item -Path $file -Confirm
      Clear-Light-Host 5

    } catch {
      Write-Host "│ 󱎘 │`t" -ForegroundColor Red -NoNewline
      Write-Host $name   -ForegroundColor White
      Write-Host $_        -ForegroundColor Red
    }
  }
  
  # REMOVE UNCOMPATIBLE FILES WITH PCSX2
  foreach ($cue_file in Get-ChildItem -Path $destination_path -Filter "*.cue") {
    Remove-Item $cue_file -Confirm
    Clear-Light-Host 5
  }

  Write-Host "╘═══╧═══════════════════════════════════════╝" -ForegroundColor Green

}
Main
