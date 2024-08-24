$origin_path = "C:\Windows\Temp\games\" 
$destination_path = "C:\Users\Bridges369\OneDrive\Games\PCSX2\"


function Main {
  
  # EXTRACT FILES
  foreach ($file in Get-ChildItem -Path $origin_path -Filter "*.zip") {
    $name = $file.NameString
    
    try {
      Expand-Archive -Path $file -DestinationPath $destination_path -Confirm

      Write-Host "| 󰸞 | $name" -ForegroundColor Green

      Remove-Item -Path $file -Confirm

    } catch {
      Write-Host "====================================" -ForegroundColor Red
      Write-Host "| 󱎘 | $name"                          -ForegroundColor Red
      Write-Host $_                                     -ForegroundColor Red
      Write-Host "====================================" -ForegroundColor Red
    }
  }
  
  # REMOVE UNCOMPATIBLE FILES WITH PCSX2
  foreach ($cue_file in Get-ChildItem -Path $destination_path -Filter "*.cue") {
    Remove-Item $cue_file -Confirm
  }

}; Main
